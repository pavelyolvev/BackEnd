var express = require('express');
var router = express.Router();
const db = require('../db');
const queries = require('../queries');

/* GET home page. */
router.get('/getCarcasFloors/:calculationId', async function (req, res, next) {
    const calculationId = parseInt(req.params.calculationId);
    const floorsData = await queries.getStructuralElementFrameByCalculationId(calculationId);
    res.json();
});


module.exports = router;
