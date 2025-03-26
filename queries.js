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
    const [results] = await db.query('SELECT * FROM structural_element_frame WHERE calculation_id = ?', [calculationId]);
    return results
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
    getCalculations,
    getCalculationById,
    getStructuralElementFrameByCalculationId,
    addStructuralElementFrame,
    addCalculation,
    saveCalculationAddress,
    saveSourceData
};