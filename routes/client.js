var express = require('express');
var router = express.Router();
const db = require('../db');
const queries = require('../queries');
const calculation = require('../calculation');


/* GET home page. */
router.get('/', async function (req, res, next) {
    try {
        if (!req.session.manager_id) {
            return res.status(401).send('Не авторизован');
        }

        const clients = await queries.getClients(req.session.manager_id);
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
        await queries.checkCalculationDate(clientId);

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
router.post('/:id/update', async function (req, res, next) {
    const clientId = req.params.id;

    const data = req.body;
    try {
        const result = await queries.updateClient(clientId, data);

        if (result.affectedRows > 0) {
            res.json({ success: true, message: 'Данные клиента успешно обновлены.' });
        } else {
            res.json({ success: false, message: 'Не удалось обновить данные клиента.' });
        }
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }
});
router.get('/:id/duplicateCalculation/:calculationId', async function (req, res, next) {
    const clientId = req.params.id;
    const calculationId = req.params.calculationId;

    try {
        const duplicatedCalcId = await queries.duplicateCalculationById(clientId, calculationId);


        if (duplicatedCalcId) {
            const result = await calculation.recognizeAndCalculate(calculationId);
            await queries.saveResults(result, duplicatedCalcId);
            res.json({ success: true, message: 'Расчет успешно дублирован.' });
        } else {
            res.json({ success: false, message: 'Не удалось дублировать расчет.' });
        }
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }
});

router.get('/:id/deleteCustomer', async function (req, res, next) {
    const clientId = req.params.id;

    try {
        const result = await queries.deleteCustomer(clientId);

        if (result) {
            res.json({ success: true, message: 'Клиент успешно удален.' });
        } else {
            res.json({ success: false, message: 'Не удалось удалить клиента.' });
        }
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }
});
router.get('/:id/deleteCalculation/:calculationId', async function (req, res, next) {
    const clientId = req.params.id;
    const calculationId = req.params.calculationId;

    try {
        const result = await queries.deleteCalculationById(calculationId);

        if (result) {
            res.json({ success: true, message: 'Расчет успешно удален.' });
        } else {
            res.json({ success: false, message: 'Не удалось удалить расчет.' });
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
        const insulation = await queries.getInsulations();
        const floorsData = await queries.getStructuralElementFrameByCalculationId(calculationId);

        console.log(floorsData);
        if (client) {
            if(floorsData.length !== 0){
                res.render(structure, {title: 'Редактирование структуры', client, calculation, insulation, floorsData: floorsData, operation:'update'});
            } else {
                res.render(structure, {title: 'Создание структуры', client, calculation, insulation,floorsData: floorsData, operation:'add'});
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

router.get('/:id/:calculationId/:structure/result', async function (req, res, next) {
    const clientId = req.params.id;
    const calculationId = req.params.calculationId;

    try {
        const [client] = await queries.getClientById(clientId);
        const [user] = await queries.getUserByClientId(clientId);
        await queries.checkCalculationDate(clientId);
        const [calculation] = await queries.getCalculationById(calculationId);

        const results = await queries.getResultsByCalculationId(calculationId);
        res.render('calculation', {client, calculation, results, user});
    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }
});

router.post('/:id/:calculationId/:structure/result/actualize', async function (req, res, next) {
    const clientId = req.params.id;
    const calculationId = req.params.calculationId;

    try {
        const [client] = await queries.getClientById(clientId);
        const [user] = await queries.getUserByClientId(clientId);
        const [calculation] = await queries.getCalculationById(calculationId);
        const results = await queries.getResultsByCalculationId(calculationId);

        const sefIds = [];
        const sefData = await queries.getStructuralElementFrameByCalculationId(calculationId)
        sefData.forEach((element, index) => {
            sefIds.push(element.id);
        });

        const result = await queries.updateResultsPrices(sefIds);
        const result2 = await queries.updateCalculationDate(calculationId);
        if(result && result2)
            res.json({ success: true, message: 'Актуализация прошла успешно!' });
        else res.json({ success: false, message: 'не удалось актуализировать.' });

    } catch (err) {
        console.error('Ошибка:', err);
        res.status(500).send('Ошибка сервера');
    }
});
router.post('/:id/:calculationId/:structure/result/setDocumentStatus', async function (req, res, next) {
    const clientId = req.params.id;
    const calculationId = req.params.calculationId;

    try {
        const result = await queries.updateCalculationState(calculationId, 3);
        if(result)
            res.json({ success: true, message: 'Обновление статуса прошло успешно!' });
        else res.json({ success: false, message: 'не удалось обновить статус.' });
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
router.post('/:id/:calculationId/saveCarcasData', async function (req, res, next) {

    try{
        let calculationId = req.params.calculationId;
        const clientId = req.params.id;
        const data = req.body;
        console.log(data);
        let saveResult;
        let dataBefore;
        const sefIds = [];
        if(calculationId === 'new'){
            calculationId = await queries.saveSourceData(clientId, data);

        } else {
            dataBefore = await queries.getStructuralElementFrameByCalculationId(calculationId)
            dataBefore.forEach((element, index) => {
                sefIds.push(element.id);
            });
            // Реализовать обновление данных
            saveResult  = await queries.updateSourceData(calculationId, data);

            if(!saveResult) {
                return res.json({success: false, message: 'Не удалось обновить исходные данные'});
            }
        }
        const addressResult = await queries.saveCalculationAddress(calculationId, data.address);
        const savedResults = await queries.getResultsByCalculationId(calculationId);
        const result = await calculation.recognizeAndCalculate(calculationId);
        console.log(result);

        //const result = calculation.recognizeAndCalculate(data);
        if (result){
            try {
                if(saveResult){
                    await queries.updateResults(result, calculationId, sefIds);
                } else await queries.saveResults(result, calculationId);
                res.json({ success: true, calculationId: calculationId, clientId });
            } catch (error) {
                console.error('Ошибка:', error);
                res.status(500).send('Ошибка сервера');
            }

        }


        //const result = await queries.saveCalculationAddress(calculationId, address);

        // if (result.affectedRows > 0) {  // Если была добавлена хотя бы одна строка
        //     res.json({ success: true, message: 'Адрес обновлен!' });
        // } else {
        //     res.json({ success: false, message: 'Не удалось обновить адрес.' });
        // }
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
