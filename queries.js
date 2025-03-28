const db = require('./db');
//const bcrypt = require('bcrypt');

const login = async (userLogin, userPassword) => {
    // Запрашиваем пользователя по логину
    const [results] = await db.query(
        `SELECT users.id, users.last_name, users.first_name, users.second_name, 
                users.phone, users.\`e-mail\`, users.login, 
                state.status, users.password 
         FROM users 
         JOIN state ON users.state_id = state.id 
         WHERE users.login = ? AND users.password = ?`,
        [userLogin, userPassword]
    );

    // console.log(results);
    // // Проверяем, найден ли пользователь
    // if (results.length === 0) {
    //     return { success: false, message: 'Неверный логин или пароль' };
    // }
    //
    //
    // // Проверяем пароль с хешем
    // const isMatch = await bcrypt.compare(userPassword, user.password);
    // if (!isMatch) {
    //     return { success: false, message: 'Неверный логин или пароль' };
    // }

    // Если все ок, удаляем пароль из объекта перед возвратом
    //delete user.password;

    return results;
};
const updatePasswords = async () => {
    const [users] = await db.query(`SELECT id, password FROM users`);

    for (const user of users) {
        const hashedPassword = await bcrypt.hash(user.password, 10);
        await db.query(`UPDATE users SET password = ? WHERE id = ?`, [hashedPassword, user.id]);
    }

    console.log('Пароли успешно обновлены!');
};
//раскомментировать для обновления паролей
//updatePasswords()
const getClients = async (manager_id) => {
    const [results] = await db.query('SELECT * FROM customers WHERE users_id = ?', [manager_id]);
    return results;
};
const addClient = async (secondname, name, lastname, phone, email, adress, manager_id) => {
    const [results] = await db.query(
        'INSERT INTO customers (last_name, first_name, second_name, phone, `e-mail`, adress, users_id) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [secondname, name, lastname, phone, email, adress, manager_id]
    );
    return results;
};
const getInsulations = async () => {
    const thicknessList = await getListInsulationThickness();
    let result = {};

    for (const row of thicknessList) {
        const [insulations] = await db.query(
            `SELECT mc.*
             FROM material_characteristics mc
             JOIN materials m ON mc.materials_id = m.id
             WHERE m.name = ? AND mc.thickness = ?`,
            ['Утеплитель', row.thickness]
        );

        result[row.thickness] = insulations; // Сохраняем массив утеплителей по толщине
    }

    return result;
}
const getListInsulationThickness = async () => {
    const [results] = await db.query(`SELECT DISTINCT mc.thickness
                                      FROM material_characteristics mc
                                               JOIN materials m ON mc.materials_id = m.id
                                      WHERE m.name = ?;
    `, ['Утеплитель']);
    return results;
}
const saveSourceData = async (clientId, data) => {
    const connection = await db.getConnection();
    try {
        await connection.beginTransaction();

        // 1. Insert into calculation - работает
        const [countResult] = await connection.query(
            `SELECT COUNT(*) AS count FROM calculation WHERE customer_id = ?`,
            [clientId]
        );
        const number = countResult[0].count + 1;

        const [calcResult] = await connection.execute(
            `INSERT INTO calculation (customer_id, address_object_constractions, number, created_date, calculation_state_id)
             VALUES (?, ?, ?, NOW(), ?)`,
            [clientId, data.address, number, 1]
        );

        const calculationId = calcResult.insertId;

        // 2. Loop through floors
        for (const floor of data.floors) {
            const [frameResult] = await connection.execute(
                `INSERT INTO structural_element_frame (
                    amount_floor, floor_number, floor_height, perimeter_of_external_walls,
                    base_area, external_wall_thickness, internal_wall_length, internal_wall_thickness,
                    OSB_external_wall, steam_waterproofing_external_wall, windscreen_extern_wall,
                    insulation_external_wall, overlap_thickness, OSB_thickness,
                    steam_waterproofing_thickness, windscreen_thickness, insulation_thickness, OSB_internal_wall,
                    calculation_id
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [
                    data.floors.length,
                    floor.floorNumber,
                    floor.height,
                    floor.perimeter,
                    floor.baseArea,
                    floor.wallThickness,
                    floor.innerWallLength,
                    floor.innerWallThickness,
                    floor.externalWallSheathing?.osb ?? null,
                    floor.externalWallSheathing?.vaporBarrier ?? null,
                    floor.externalWallSheathing?.windProtection ?? null,
                    floor.externalWallSheathing?.insulation ?? null,
                    floor.overlaps?.floorThickness ?? null,
                    floor.overlaps?.osb ?? null,
                    floor.overlaps?.vaporBarrier ?? null,
                    floor.overlaps?.windProtection ?? null,
                    floor.overlaps?.insulation ?? null,
                    floor.innerWallSheathing?.osb ?? null,
                    calculationId,
                ]
            );
            const frameId = frameResult.insertId;

            // Вставка окон и дверей
            async function insertOpenings(openingsArray, type) {
                for (const opening of openingsArray) {
                    const [openingResult] = await connection.execute(
                        `INSERT INTO openings (type, width, height) VALUES (?, ?, ?)`,
                        [type, opening.width ?? null, opening.height ?? null]
                    );

                    const openingId = openingResult.insertId;

                    await connection.execute(
                        `INSERT INTO openings_in_a_structural_element_frame (structural_element_frame_id, openings_id, amount)
                         VALUES (?, ?, ?)`,
                        [frameId, openingId, opening.count]
                    );
                }
            }

            await insertOpenings(floor.windows, 'window');
            await insertOpenings(floor.externalDoors, 'externalDoor');
            await insertOpenings(floor.internalDoors, 'internalDoor');
        }

        await connection.commit();
        console.log('Данные успешно добавлены.');
        return calculationId;
    } catch (err) {
        await connection.rollback();
        console.error('Ошибка во время вставки:', err);
    } finally {
        connection.release();
    }
};

const getClientById = async (clientId) => {
    const [results] = await db.query('SELECT * FROM customers WHERE id = ?', [clientId]);
    return results;
};

const getUserByClientId = async (clientId) => {
    const [results] = await db.query('SELECT u.first_name, u.last_name, s.status  FROM users u JOIN customers c ON u.id = c.users_id JOIN state s ON s.id = u.state_id WHERE c.id = ?;', [clientId]);
    return results;
};
const getCalculations = async (clientId) => {
    const [results] = await db.query(`
        SELECT 
            calculation.id AS calculation_id,
            calculation.customer_id,
            calculation.address_object_constractions,
            calculation.number,
            calculation.created_date,
            calculation.calculation_state_id,
            calculation_state.status
        FROM calculation 
        JOIN calculation_state ON calculation.calculation_state_id = calculation_state.id 
        WHERE calculation.customer_id = ?
    `, [clientId]);
    return results;
};
const getCalculationById = async (calculationId) => {
    const [results] = await db.query('SELECT * FROM calculation c join calculation_state cs on c.calculation_state_id = cs.id WHERE c.id = ?', [calculationId]);
    return results;
};
const getStructuralElementFrameByCalculationId = async (calculationId) => {
    //const [results] = await db.query('SELECT sef.*, o.type AS opening_type, o.width AS opening_width, o.height AS opening_height, oisef.amount AS opening_amount FROM structural_element_frame sef LEFT JOIN openings_in_a_structural_element_frame oisef ON sef.id = oisef.structural_element_frame_id LEFT JOIN openings o ON oisef.openings_id = o.id WHERE sef.calculation_id = 9', [calculationId]);

        const query = `
    SELECT 
      sef.id,
      sef.calculation_id,
      sef.amount_floor,
      sef.floor_number,
      sef.floor_height,
      sef.perimeter_of_external_walls,
      sef.base_area,
      sef.external_wall_thickness,
      sef.internal_wall_length,
      sef.internal_wall_thickness,
      sef.OSB_external_wall,
      sef.steam_waterproofing_external_wall,
      sef.windscreen_extern_wall,
      sef.insulation_external_wall,
      sef.overlap_thickness,
      sef.OSB_thickness,
      sef.steam_waterproofing_thickness,
      sef.windscreen_thickness,
      sef.insulation_thickness,
      sef.OSB_internal_wall,
    
      (
        SELECT JSON_ARRAYAGG(JSON_OBJECT(
          'id', o.id,
          'type', o.type,
          'width', o.width,
          'height', o.height,
          'amount', oisef.amount
        ))
        FROM openings_in_a_structural_element_frame oisef
        JOIN openings o ON o.id = oisef.openings_id
        WHERE oisef.structural_element_frame_id = sef.id AND o.type = 'window'
      ) AS windows,
    
      (
        SELECT JSON_ARRAYAGG(JSON_OBJECT(
          'id', o.id,
          'type', o.type,
          'width', o.width,
          'height', o.height,
          'amount', oisef.amount
        ))
        FROM openings_in_a_structural_element_frame oisef
        JOIN openings o ON o.id = oisef.openings_id
        WHERE oisef.structural_element_frame_id = sef.id AND o.type = 'externalDoor'
      ) AS externalDoors,
    
      (
        SELECT JSON_ARRAYAGG(JSON_OBJECT(
          'id', o.id,
          'type', o.type,
          'width', o.width,
          'height', o.height,
          'amount', oisef.amount
        ))
        FROM openings_in_a_structural_element_frame oisef
        JOIN openings o ON o.id = oisef.openings_id
        WHERE oisef.structural_element_frame_id = sef.id AND o.type = 'internalDoor'
      ) AS internalDoors
    
    FROM structural_element_frame sef
    WHERE sef.calculation_id = ?;
    `;
    const [rows] = await db.query(query, [calculationId]);

    const results = rows.map((row) => {
        let isInternalWallSheeting = false;
        let isExternalWallSheeting = false;
        let isOverlaps = false;

        if (row.OSB_internal_wall !== null)
            isInternalWallSheeting = true;
        if (row.OSB_external_wall !== null && row.steam_waterproofing_external_wall !== null &&
            row.windscreen_extern_wall !== null && row.insulation_external_wall !== null)
            isExternalWallSheeting = true;
        if (row.overlap_thickness !== null && row.OSB_thickness !== null &&
            row.steam_waterproofing_thickness !== null && row.windscreen_thickness !== null &&
            row.insulation_thickness !== null)
            isOverlaps = true;

        const options = { isInternalWallSheeting, isExternalWallSheeting, isOverlaps };

        return {
            ...row,
            windows: row.windows ?? [],
            externalDoors: row.externalDoors ?? [],
            internalDoors: row.internalDoors ?? [],
            options
        };
    });


    //console.log(results);

    return results;
}

const saveResults = async (result, calculationId) => {
    const connection = await db.getConnection(); // Получаем соединение

    const calculation = await getStructuralElementFrameByCalculationId(calculationId);

    try {
        await connection.beginTransaction(); // Начинаем транзакцию

        for (const [i, floor] of result.entries()) {
            const structural_element_frame_id = calculation[i].id;

            // Внешние стены
            await saveMaterialToResults(connection, 'Доска', floor.outerWalls.woodForOuterWallVolume, floor.outerWalls.woodThickness, 'externalWall', structural_element_frame_id);

            // далее опциональные материалы
            if(floor.options.isExternalWallSheeting){
                await saveMaterialToResults(connection, floor.outerWalls.insulationName, floor.outerWalls.insulationVolume, floor.outerWalls.insulationThickness, 'externalWall', structural_element_frame_id);
                await saveMaterialToResults(connection, 'OSB', floor.outerWalls.sqOSB, floor.outerWalls.OSBThickness, 'externalWall', structural_element_frame_id);
                await saveMaterialToResults(connection, floor.outerWalls.steamWaterProofName, floor.outerWalls.sqSteamWaterProofAndWindscreen, null, 'externalWall', structural_element_frame_id);
                await saveMaterialToResults(connection, floor.outerWalls.windscreenName, floor.outerWalls.sqSteamWaterProofAndWindscreen, null, 'externalWall', structural_element_frame_id);
            }

            // Внутренние стены
            await saveMaterialToResults(connection, 'Доска', floor.innerWalls.innerWallVolume, floor.innerWalls.innerWallThickness, 'internalWall', structural_element_frame_id);
            if(floor.options.isInternalWallSheeting){
                await saveMaterialToResults(connection, 'OSB', floor.innerWalls.sqOSBInnerWall, floor.innerWalls.OSBThickness, 'internalWall', structural_element_frame_id);
            }


            // Перекрытия
            if(floor.options.isOverlaps){
                await saveMaterialToResults(connection, 'Доска', floor.overlaps.woodVolume, floor.overlaps.woodThickness, 'overlaps', structural_element_frame_id);
                await saveMaterialToResults(connection, floor.overlaps.insulationName, floor.overlaps.insulationVolume, floor.overlaps.insulationThickness, 'overlaps', structural_element_frame_id);
                await saveMaterialToResults(connection, 'OSB', floor.overlaps.sqOSB, floor.overlaps.OSBThickness, 'overlaps', structural_element_frame_id);
                await saveMaterialToResults(connection, floor.overlaps.steamWaterProofName, floor.overlaps.sqSteamWaterProofAndWindscreen, null, 'overlaps', structural_element_frame_id);
                await saveMaterialToResults(connection, floor.overlaps.windscreenName, floor.overlaps.sqSteamWaterProofAndWindscreen, null, 'overlaps', structural_element_frame_id);
            }
        }

        await connection.commit(); // Фиксируем изменения
        console.log("Все записи успешно вставлены.");
        return calculationId;
    } catch (error) {
        await connection.rollback(); // Откат изменений в случае ошибки
        console.error("Ошибка при сохранении результатов, транзакция отменена:", error);
        throw error;
    } finally {
        connection.release(); // Освобождаем соединение
    }
};


async function getLatestPriceForMaterial(connection, name, width) {
    // запрос не учитывает длину доски
    let priceQuery = `
        SELECT pl.selling_price
        FROM price_lists pl
        JOIN material_characteristics mc ON pl.material_characteristics_id = mc.id
        WHERE mc.name = ?
    `;

    if (name === 'Доска') {
        priceQuery += ' AND mc.wedth = ?';
    } else if (width) {
        priceQuery += ' AND mc.thickness = ?';
    }

    priceQuery += `
        ORDER BY pl.date DESC
        LIMIT 1;
    `;


    try {
        const [rows] = await connection.query(priceQuery, [name, width]);
        return rows.length > 0 ? rows[0].selling_price : null;
    } catch (error) {
        console.error(`Ошибка при получении цены для ${name}:`, error);
        throw error;
    }
}

async function saveMaterialToResults(connection, name, amount, width, structuralType, structural_element_frame_id) {
    const price = await getLatestPriceForMaterial(connection, name, width);
    if (price === null) {
        throw new Error(`Цена для материала ${name}, ${width} не найдена.`);
    }

    const fullPrice = price * amount;
    let materialName;
    if (name === 'Доска'){
        materialName = structuralType === 'overlaps' ? `Доска 50*${width}*6000` : `Доска 50*${width}*3000`;
    } else if (name === 'OSB') {
        materialName = `${name} ${width} мм`;
    } else materialName = name;

    let query = `
        INSERT INTO results (material_characteristics_id, material, amount, price, measurement_unit_id, full_price,
                             structural_element_frame_id, structural_type)
        SELECT mc.id, ?, ?, ?, ?, ?, ?, ?
        FROM material_characteristics mc
        WHERE mc.name = ?
    `;
    if (name === 'Доска'){
        query += ' AND mc.wedth = ?'
        if (structuralType === 'overlaps')
            query += ' AND mc.length = 6000;'
        else query += ' AND mc.length = 3000;'
    } else if (name === 'OSB'){
        query += ' AND mc.thickness = ?;'
    }
    else query += ';'


    try {
        const [rows] = await connection.query(query, [materialName, amount, price, 3, fullPrice, structural_element_frame_id, structuralType, name, width]);
        console.log(`Запись успешно вставлена: ${materialName}`);
        return rows;
    } catch (error) {
        console.error('Ошибка при вставке материала:', materialName, error);
        throw error;
    }
}

const getResultsByCalculationId = async (calculationId) => {
    const query = `
        SELECT r.id, r.material, r.amount, r.price, mu.measurement_units_name, 
               r.full_price, r.structural_element_frame_id, r.structural_type, 
               sef.amount_floor, sef.floor_number 
        FROM results r JOIN measurement_units mu ON r.measurement_unit_id = mu.id
        JOIN structural_element_frame sef ON r.structural_element_frame_id = sef.id
        WHERE sef.calculation_id = ?;
    `;
    try {
        const [rows] = await db.query(query, [calculationId]);
        return rows;
    } catch (error) {
        console.error('Ошибка при получении результатов:', error);
        throw error;
    }
}
// ДОПИСАТЬ
const addCalculation = async (clientId, address) => {
    const [countResult] = await db.query(
        `SELECT COUNT(*) AS count FROM calculation WHERE customer_id = ?`,
        [clientId]
    );

    const number = countResult[0].count + 1;
    const [results] = await db.query(
        `INSERT INTO calculation (customer_id, address_object_constractions, number, created_date, calculation_state_id)
   VALUES (?, ?, ?, NOW(), ?)`,
        [clientId, address, number, 1]
    );

    return results;
}
const addStructuralElementFrame = async (calculationId, amountFloor, floorHeight,
                                         perimeterExtWalls, baseArea, externalWallsThickness,
                                         internalWallThickness, internalWallLength, OSBExternalWall,
                                         steamWaterProofingExternalWall, windscreenExternalWall,
                                         insulationExternalWall, overlapThickness, OSBThickness,
                                         steamWaterProofingThickness, windscreenThickness, insulationThickness,
                                         OSBInternalWall) => {
    // КОЛИЧЕСТВО ЭТАЖЕЙ = НОМЕРУ ЭТАЖА
    // ИСПРАВИТЬ В БУДУЩЕМ
    const [results] = await db.query(
        `INSERT INTO structural_element_frame (calculation_id, amount_floor, floor_number, floor_height, perimeter_of_external_walls, 
                                               base_area, external_wall_thickness, internal_wall_thickness, 
                                               internal_wall_length, OSB_external_wall, steam_waterproofing_external_wall, 
                                               windscreen_extern_wall, insulation_external_wall, overlap_thickness, 
                                               OSB_thickness, steam_waterproofing_thickness, windscreen_thickness, insulation_thickness, OSB_internal_wall) 
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`, [calculationId, amountFloor, amountFloor, floorHeight,
            perimeterExtWalls, baseArea, externalWallsThickness,
            internalWallThickness, internalWallLength, OSBExternalWall,
            steamWaterProofingExternalWall, windscreenExternalWall,
            insulationExternalWall, overlapThickness, OSBThickness,
            steamWaterProofingThickness, windscreenThickness, insulationThickness, OSBInternalWall]);

}
const saveCalculationAddress = async (calculationId, address) => {
    const [results] = await db.query('UPDATE calculation SET address_object_constractions = ? WHERE id = ?', [address, calculationId]);
    return results
}

module.exports = {
    login,
    addClient,
    getClients,
    getClientById,
    getUserByClientId,
    getInsulations,
    getCalculations,
    getCalculationById,
    getStructuralElementFrameByCalculationId,
    addStructuralElementFrame,
    addCalculation,
    saveCalculationAddress,
    saveSourceData,
    saveResults,
    getResultsByCalculationId
};