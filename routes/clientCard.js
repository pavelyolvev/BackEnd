var express = require('express');
var router = express.Router();
const db = require('../db');
const queries = require('../queries');

/* GET home page. */
// router.get('/:id', async function (req, res, next) {
//     const clientId = req.params.id;
//
//     try {
//         const [client] = await queries.getClientById(clientId);
//
//         if (client) {
//             res.render('clientCard', {title: 'Информация о клиенте', client});
//         } else {
//             res.status(404).send('Клиент не найден');
//         }
//     } catch (err) {
//         console.error('Ошибка:', err);
//         res.status(500).send('Ошибка сервера');
//     }
// });
router.post('/', async (req, res) => {


});

module.exports = router;
