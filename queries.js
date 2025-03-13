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

module.exports = {
    login,
    addClient,
    getClients,
    getClientById
};