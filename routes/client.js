var express = require('express');
var router = express.Router();
const db = require('../db');
const queries = require('../queries');

/* GET home page. */
router.get('/', async function (req, res, next) {
    try {
        const clients = await queries.getClients(1);  // Передаем manager_id, например, 1
        res.render('client', { title: 'client', clients });
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }
});
router.get('/:id', async function (req, res, next) {
    const clientId = req.params.id;

    try {
        const [client] = await queries.getClientById(clientId);
        const calculations = await queries.getCalculations(clientId);

        console.log(calculations);

        if (client) {
            res.render('clientCard', {title: 'Информация о клиенте', client, calculations});
        } else {
            res.status(404).send('Клиент не найден');
        }
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }
});

router.get('/:id/:calculationId/:structure', async function (req, res, next) {
    const clientId = req.params.id;
    const calculationId = req.params.calculationId;
    //const structure = req.params.structure;
    const structure = 'carcas';

    try {
        const [client] = await queries.getClientById(clientId);
        const [calculation] = await queries.getCalculationById(calculationId);
        const [structureFrame] = await queries.getStructuralElementFrameByCalculationId(calculationId);

        if (client) {
            if(structureFrame){
                res.render(structure, {title: 'Редактирование структуры', client, calculation, structureFrame, operation:'update'});
            } else {
                res.render(structure, {title: 'Создание структуры', client, calculation, operation:'add'});
            }

        } else {
            res.status(404).send('Клиент или расчет не найден');
        }
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }
});
router.post('/:id/:calculationId/:structure/add', async function (req, res, next) {
    try{
        const calculationId = req.params.calculationId;
        const {amountFloor, floorHeight,
            perimeterExtWalls, baseArea, externalWallsThickness,
            internalWallThickness, internalWallLength, OSBExternalWall,
            steamWaterProofingExternalWall, windscreenExternalWall,
            insulationExternalWall, overlapThickness, OSBThickness,
            steamWaterProofingThickness, windscreenThickness, insulationThickness,
            OSBInternalWall} = req.body;

        const result = await queries.addStructuralElementFrame(calculationId, amountFloor, floorHeight,
            perimeterExtWalls, baseArea, externalWallsThickness,
            internalWallThickness, internalWallLength, OSBExternalWall,
            steamWaterProofingExternalWall, windscreenExternalWall,
            insulationExternalWall, overlapThickness, OSBThickness,
            steamWaterProofingThickness, windscreenThickness, insulationThickness,
            OSBInternalWall);

        if (result.affectedRows > 0) {  // Если была добавлена хотя бы одна строка
            res.json({ success: true, message: 'Структурный элемент успешно добавлен!' });
        } else {
            res.json({ success: false, message: 'Не удалось добавить структурный элемент.' });
        }
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }
});
router.post('/:id/:calculationId/updateAddress', async function (req, res, next) {

    try{
        const calculationId = req.params.calculationId;
        const clientId = req.params.id;
        const {address} = req.body;
        console.log(address);
        const result = await queries.saveCalculationAddress(calculationId, address);

        if (result.affectedRows > 0) {  // Если была добавлена хотя бы одна строка
            res.json({ success: true, message: 'Адрес обновлен!' });
        } else {
            res.json({ success: false, message: 'Не удалось обновить адрес.' });
        }
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }
});
router.post('/add', async (req, res) => {
    try{
        const {lastName, firstName, middleName, phone, email, address, managerId} = req.body;

        const result = await queries.addClient(lastName, firstName, middleName, phone, email, address, managerId);

        if (result.affectedRows > 0) {  // Если была добавлена хотя бы одна строка
            res.json({ success: true, message: 'Клиент успешно добавлен!' });
        } else {
            res.json({ success: false, message: 'Не удалось добавить клиента.' });
        }
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }

});
router.post('/:id/calculation/add', async (req, res) => {
    try{
        const clientId = req.params.id;

        const result = await queries.addCalculation(clientId, "Введите адрес");


        if (result.affectedRows > 0) {  // Если была добавлена хотя бы одна строка
            res.json({ success: true, result });
        } else {
            res.json({ success: false, message: 'Не удалось добавить клиента.' });
        }
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }

});

module.exports = router;
