var express = require('express');
var router = express.Router();
const db = require('../db');
const queries = require('../queries');

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('login', { title: 'Login' });
});
router.post('/', async (req, res) => {

    const { login, password } = req.body;
    const results = await queries.login(login, password);
    console.log(results);
    if (results.length > 0) {
        req.session.manager_id = results[0].id; // Сохраняем manager_id в сессию
        res.json({ success: true, message: 'Успешный вход', user: results[0] });
    } else {
        res.json({ success: false, message: 'Неверный логин или пароль' });
    }


});

module.exports = router;
