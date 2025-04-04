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
const isClientOfManager = async (userId, clientId) => {
    const [results] = await db.query('SELECT * FROM customers WHERE id = ? AND users_id = ?', [clientId, userId]);
    return results.length > 0;
}
const addClient = async (secondname, name, lastname, phone, email, adress, manager_id) => {
    const [results] = await db.query(
        'INSERT INTO customers (last_name, first_name, second_name, phone, `e-mail`, adress, users_id) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [secondname, name, lastname, phone, email, adress, manager_id]
    );
    return results;
};
const updateClient = async (clientId, data) =>{
    const [results] = await db.query('UPDATE customers SET last_name = ?, first_name = ?, second_name = ?, phone = ?, `e-mail` = ?, adress = ? WHERE id = ?', [data.lastName, data.firstName, data.middleName, data.phone, data.email, data.address, clientId]);
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
            `SELECT number AS lastNumber FROM calculation WHERE customer_id = ? ORDER BY number DESC LIMIT 1`,
            [clientId]
        );
        let number;
        if (countResult.length === 0) {
            number = 1;
        } else number = countResult[0].lastNumber + 1;

        const [calcResult] = await connection.execute(
            `INSERT INTO calculation (customer_id, address_object_constractions, number, created_date, calculation_state_id)
             VALUES (?, ?, ?, NOW(), ?)`,
            [clientId, data.address, number, 1]
        );

        const calculationId = calcResult.insertId;

        // 2. Loop through floors
        await saveFloorsData(connection, data, calculationId);

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
async function saveFloorsData(connection, data, calculationId) {
    for (const floor of data.floors) {
        console.log(floor);
        const [frameResult] = await connection.execute(
            `INSERT INTO structural_element_frame (amount_floor, floor_number, floor_height,
                                                   perimeter_of_external_walls,
                                                   base_area, external_wall_thickness, internal_wall_length,
                                                   internal_wall_thickness,
                                                   OSB_external_wall, steam_waterproofing_external_wall,
                                                   windscreen_extern_wall,
                                                   insulation_external_wall, overlap_thickness, OSB_thickness,
                                                   steam_waterproofing_thickness, windscreen_thickness,
                                                   insulation_thickness, OSB_internal_wall,
                                                   calculation_id)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [
                data.floors.length,
                floor.floor_number,
                floor.floor_height,
                floor.perimeter_of_external_walls,
                floor.base_area,
                floor.external_wall_thickness,
                floor.internal_wall_length,
                floor.internal_wall_thickness,
                floor.OSB_external_wall ?? null,
                floor.steam_waterproofing_external_wall ?? null,
                floor.windscreen_extern_wall ?? null,
                floor.insulation_external_wall ?? null,
                floor.overlap_thickness ?? null,
                floor.OSB_thickness ?? null,
                floor.steam_waterproofing_thickness ?? null,
                floor.windscreen_thickness ?? null,
                floor.insulation_thickness ?? null,
                floor.OSB_internal_wall ?? null,
                calculationId,
            ]
        );
        const frameId = frameResult.insertId;

        // Вставка окон и дверей
        async function insertOpenings(openingsArray, type) {
            for (const opening of openingsArray) {
                const [openingResult] = await connection.execute(
                    `INSERT INTO openings (type, width, height)
                     VALUES (?, ?, ?)`,
                    [type, opening.width ?? null, opening.height ?? null]
                );

                const openingId = openingResult.insertId;

                await connection.execute(
                    `INSERT INTO openings_in_a_structural_element_frame (structural_element_frame_id, openings_id, amount)
                     VALUES (?, ?, ?)`,
                    [frameId, openingId, opening.amount]
                );
            }
        }

        await insertOpenings(floor.windows, 'window');
        await insertOpenings(floor.externalDoors, 'externalDoor');
        await insertOpenings(floor.internalDoors, 'internalDoor');
    }
}
const updateSourceData = async (calculationId, data) => {
    console.log('Обновляем данные...');
    const connection = await db.getConnection();
    try {
        await connection.beginTransaction();

        // Удаляем все связанные записи
        await connection.execute(
            `DELETE FROM openings_in_a_structural_element_frame 
         WHERE structural_element_frame_id IN (
             SELECT id FROM structural_element_frame WHERE calculation_id = ?
         )`,
            [calculationId]
        );

        await connection.execute(
            `DELETE FROM openings 
         WHERE id IN (
             SELECT openings_id FROM openings_in_a_structural_element_frame 
             WHERE structural_element_frame_id IN (
                 SELECT id FROM structural_element_frame WHERE calculation_id = ?
             )
         )`,
            [calculationId]
        );

        await connection.execute(
            `DELETE FROM structural_element_frame WHERE calculation_id = ?`,
            [calculationId]
        );

        await saveFloorsData(connection, data, calculationId)

        await connection.commit();
        console.log('Данные обновлены успешно...');
        return true;
    } catch (err) {
        await connection.rollback();
        console.error('Ошибка во время обновления:', err);
        return false;
    } finally {
        connection.release();
    }
}
const getClientById = async (clientId) => {
    const [results] = await db.query('SELECT *, `e-mail` AS email FROM customers WHERE id = ?', [clientId]);
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
            DATE_FORMAT(calculation.created_date, \'%d/%m/%Y\') AS created_date,
            calculation.calculation_state_id,
            calculation_state.status
        FROM calculation 
        JOIN calculation_state ON calculation.calculation_state_id = calculation_state.id 
        WHERE calculation.customer_id = ?
    `, [clientId]);
    return results;
};
const duplicateCalculationById = async (clientId, calculationId) => {
    const connection = await db.getConnection();
    try {
        await connection.beginTransaction(); // Начинаем транзакцию

        // 1️⃣ Получаем данные текущего расчета
        const [originalCalculation] = await connection.query(
            `SELECT address_object_constractions, number FROM calculation WHERE id = ?`,
            [calculationId]
        );

        if (originalCalculation.length === 0) {
            throw new Error('Расчет не найден');
        }

        // 2️⃣ Получаем все каркасы, привязанные к расчету
        // const [frames] = await connection.query(
        //     `SELECT * FROM structural_element_frame WHERE calculation_id = ?`,
        //     [calculationId]
        // );

        const frames = await getStructuralElementFrameByCalculationId(calculationId);
        // 3️⃣ Формируем объект `data` в формате `saveSourceData`
        let data = {
            address: originalCalculation[0].address_object_constractions,
            floors: [],
        };

        for (const frame of frames) {
            // Получаем окна и двери для текущего каркаса
            const [openingsLinks] = await connection.query(
                `SELECT o.id, o.type, o.width, o.height, osef.amount 
                 FROM openings_in_a_structural_element_frame osef
                 JOIN openings o ON osef.openings_id = o.id
                 WHERE osef.structural_element_frame_id = ?`,
                [frame.id]
            );

            let windows = [];
            let externalDoors = [];
            let internalDoors = [];

            for (const opening of openingsLinks) {
                if (opening.type === 'window') windows.push({ width: opening.width, height: opening.height, amount: opening.amount });
                if (opening.type === 'externalDoor') externalDoors.push({ width: opening.width, height: opening.height, amount: opening.amount });
                if (opening.type === 'internalDoor') internalDoors.push({ width: opening.width, height: opening.height, amount: opening.amount });
            }

            data.floors.push({
                floor_number: frame.floor_number,
                floor_height: frame.floor_height,
                perimeter_of_external_walls: frame.perimeter_of_external_walls,
                base_area: frame.base_area,
                external_wall_thickness: frame.external_wall_thickness,
                internal_wall_length: frame.internal_wall_length,
                internal_wall_thickness: frame.internal_wall_thickness,
                OSB_external_wall: frame.OSB_external_wall,
                steam_waterproofing_external_wall: frame.steam_waterproofing_external_wall,
                windscreen_extern_wall: frame.windscreen_extern_wall,
                insulation_external_wall: frame.insulation_external_wall,
                overlap_thickness: frame.overlap_thickness,
                OSB_thickness: frame.OSB_thickness,
                steam_waterproofing_thickness: frame.steam_waterproofing_thickness,
                windscreen_thickness: frame.windscreen_thickness,
                insulation_thickness: frame.insulation_thickness,
                OSB_internal_wall: frame.OSB_internal_wall,
                windows,
                externalDoors,
                internalDoors,
            });
        }

        // 4️⃣ Используем `saveSourceData`, чтобы создать копию
        const newCalculationId = await saveSourceData(clientId, data);

        await connection.commit(); // Фиксируем изменения
        console.log('Расчет успешно дублирован.');
        return newCalculationId;
    } catch (err) {
        await connection.rollback();
        console.error('Ошибка во время дублирования:', err);
        return false;
    } finally {
        connection.release();
    }
};


const updateCalculationState = async (calculationId, newStateId) => {
    const [results] = await db.query('UPDATE calculation SET calculation_state_id = ? WHERE id = ?', [newStateId, calculationId]);
    return results;
}
const checkCalculationDate = async (clientId) => {
    const connection = await db.getConnection(); // Получаем соединение
    try {
        await connection.beginTransaction(); // Начинаем транзакцию

        // Обновляем все расчеты, созданные более 10 дней назад и находящиеся в статусе "актуальный" (calculation_state_id = 1)
        const [result] = await connection.execute(`
            UPDATE calculation
            SET calculation_state_id = 2
            WHERE customer_id = ?
            AND calculation_state_id = 1
            AND created_date <= NOW() - INTERVAL 10 DAY
        `, [clientId]);

        await connection.commit(); // Фиксируем изменения
        console.log(`Расчеты успешно обновлены.`);
    } catch (error) {
        await connection.rollback(); // Откат изменений в случае ошибки
        console.error("Ошибка при обновлении статусов расчетов:", error);
        throw error;
    } finally {
        connection.release(); // Освобождаем соединение
    }
}
const getCalculationById = async (calculationId) => {
    const [results] = await db.query('SELECT c.id, c.customer_id, c.address_object_constractions, c.number, DATE_FORMAT(c.created_date, \'%d/%m/%Y\') AS created_date, cs.status FROM calculation c join calculation_state cs on c.calculation_state_id = cs.id WHERE c.id = ?', [calculationId]);
    return results;
};
const updateCalculationDate = async (calculationId) => {
    const [results] = await db.query('UPDATE calculation SET calculation_state_id = 1, created_date = NOW() WHERE id = ?', [calculationId]);
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
const updateResults = async (result, calculationId, sefIds) => {
    console.log('Обновляем результаты...');
    const connection = await db.getConnection(); // Получаем соединение
    try {
        await connection.beginTransaction(); // Начинаем транзакцию

        console.log(calculationId)
        sefIds.forEach(async (sefId) => {
            await connection.execute(
                `DELETE FROM results WHERE structural_element_frame_id = ?`,
                [sefId]
            );
        });


        await saveResults(result, calculationId, connection);

        await connection.commit(); // Сохраняем изменения в базе данных
        console.log('Результаты обновлены успешно...');
    } catch (error) {
        await connection.rollback(); // Откат изменений в случае ошибки
        console.error("Ошибка при обновлении результатов, транзакция отменена:", error);
        throw error;
    } finally {
        connection.release(); // Освобождаем соединение
    }
}
const saveResults = async (result, calculationId, connected = null) => {

    let connection;
    if (connected == null)
        connection = await db.getConnection(); // Получаем соединение
    else connection = connected;

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
const deleteCustomer = async (clientId) => {
    const connection = await db.getConnection(); // Получаем соединение
    try {
        await connection.beginTransaction();

        const result = await getCalculations(clientId);
        console.log(`Найдено расчетов для клиента ${clientId}:`, result.length);

        for (const [i, calculation] of result.entries()) {
            console.log(`Удаление расчета с ID: ${calculation.calculation_id}`);
            await deleteCalculationById(calculation.calculation_id, connection);
        }
        await connection.query(`DELETE FROM customers WHERE id = ?`, [clientId]);

        await connection.commit();
        console.log(`Клиент с ID ${clientId} успешно удален`);
        return true;
    } catch (error) {
        await connection.rollback();
        console.error("Ошибка при удалении клиента:", error);
        throw error;
    } finally {
        connection.release();
    }
}
const deleteCalculationById = async (calculationId, connected = null) => {
    let connection;
    if (connected == null)
        connection = await db.getConnection(); // Получаем соединение
    else connection = connected;
    try {
        await connection.beginTransaction();

        // Удаление результатов расчета
        await connection.query(`
            DELETE FROM results 
            WHERE structural_element_frame_id IN (
                SELECT id FROM structural_element_frame WHERE calculation_id = ?
            )`, [calculationId]);

        // Удаление связей между openings и structural_element_frame
        await connection.query(`
            DELETE FROM openings_in_a_structural_element_frame 
            WHERE structural_element_frame_id IN (
                SELECT id FROM structural_element_frame WHERE calculation_id = ?
            )`, [calculationId]);

        // Удаление записей openings, если они не используются в других расчетах
        await connection.query(`
            DELETE FROM openings 
            WHERE id NOT IN (SELECT openings_id FROM openings_in_a_structural_element_frame)`);

        // Удаление структурных элементов (каркаса)
        await connection.query(`DELETE FROM structural_element_frame WHERE calculation_id = ?`, [calculationId]);

        // Удаление самого расчета
        await connection.query(`DELETE FROM calculation WHERE id = ?`, [calculationId]);

        await connection.commit();
        console.log(`Расчет с ID ${calculationId} успешно удален`);
        return true;
    } catch (error) {
        await connection.rollback();
        console.error("Ошибка при удалении расчета:", error);
        throw error;
    } finally {
        connection.release();
    }
};
const updateResultsPrices = async (sefIds) => {
    const connection = await db.getConnection(); // Получаем соединение
    try {
        await connection.beginTransaction(); // Начинаем транзакцию

        for (const sefId of sefIds) {
            // Получаем ВСЕ material_characteristics_id для sefId
            const [rows] = await connection.execute(
                `SELECT id, material_characteristics_id FROM results WHERE structural_element_frame_id = ?`,
                [sefId]
            );

            if (rows.length === 0) continue; // Если нет данных, пропускаем

            for (const row of rows) {
                const { id, material_characteristics_id } = row;

                // Получаем актуальную цену
                const latestPrice = await getLatestPriceForMaterialByMCId(connection, material_characteristics_id);
                if (latestPrice === null) {
                    console.warn(`Не найдена цена для material_characteristics_id: ${material_characteristics_id}`);
                    continue;
                }

                // Обновляем price и full_price КОНКРЕТНОЙ строки results
                await connection.execute(
                    `UPDATE results 
                     SET price = ?, 
                         full_price = amount * ? 
                     WHERE id = ?`,
                    [latestPrice, latestPrice, id]
                );
            }
        }

        await connection.commit(); // Фиксируем изменения
        console.log("Все цены у записей успешно обновлены.");
        return true;
    } catch (error) {
        await connection.rollback(); // Откат изменений в случае ошибки
        console.error("Ошибка при обновлении цен, транзакция отменена:", error);
        throw error;
    } finally {
        connection.release(); // Освобождаем соединение
    }
};


async function getLatestPriceForMaterialByMCId(connection, MCId){
    let priceQuery = `
        SELECT pl.selling_price
        FROM price_lists pl
        JOIN material_characteristics mc ON pl.material_characteristics_id = mc.id
        WHERE mc.id = ? ORDER BY pl.date DESC
            LIMIT 1;
    `;

    try {
        const [rows] = await connection.query(priceQuery, [MCId]);
        return rows.length > 0 ? rows[0].selling_price : null;
    } catch (error) {
        console.error(`Ошибка при получении цены для ${MCId}:`, error);
        throw error;
    }
}

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
        SELECT mc.id, ?, ?, ?, mc.measurement_unit_id, ?, ?, ?
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
        const [rows] = await connection.query(query, [materialName, amount, price, fullPrice, structural_element_frame_id, structuralType, name, width]);
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
const checkClientExists = async (clientId, phone, email) => {
    const [result] = await db.query(
        `SELECT id, phone, \`e-mail\` AS email FROM customers WHERE phone = ? OR \`e-mail\` = ?`,
        [phone, email]
    );

    if (!result.length) return null;

    for (const client of result) {
        // Если clientId передан и это тот же клиент — пропускаем
        if (clientId !== null && client.id === clientId) continue;

        if (client.phone === phone) return 'phone';
        if (client.email === email) return 'email';
    }

    return null;
};


module.exports = {
    login,
    addClient,
    updateClient,
    getClients,
    checkClientExists,
    isClientOfManager,
    getClientById,
    getUserByClientId,
    getInsulations,
    getCalculations,
    getCalculationById,
    duplicateCalculationById,
    updateCalculationDate,
    updateCalculationState,
    checkCalculationDate,
    deleteCalculationById,
    deleteCustomer,
    getStructuralElementFrameByCalculationId,
    addStructuralElementFrame,
    addCalculation,
    saveCalculationAddress,
    saveSourceData,
    updateSourceData,
    saveResults,
    updateResults,
    updateResultsPrices,
    getResultsByCalculationId
};