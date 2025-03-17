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
const getClientById = async (clientId) => {
    const [results] = await db.query('SELECT * FROM customers WHERE id = ?', [clientId]);
    return results;
};
const getCalculations = async (clientId) => {
    const [results] = await db.query('SELECT * FROM calculation c join calculation_state cs on c.calculation_state_id = cs.id WHERE customer_id = ?', [clientId]);
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

module.exports = {
    login,
    addClient,
    getClients,
    getClientById,
    getCalculations,
    getCalculationById,
    getStructuralElementFrameByCalculationId,
    addStructuralElementFrame,
    addCalculation
};