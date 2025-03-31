var express = require('express');
var router = express.Router();
const db = require('../db');
const queries = require('../queries');
const PDFDocument = require('pdfkit');
const pdf = require('html-pdf');
const fs = require('fs');
const path = require('path');

/* GET home page. */
router.get('/getCarcasFloors/:calculationId', async function (req, res, next) {
    const calculationId = parseInt(req.params.calculationId);
    const floorsData = await queries.getStructuralElementFrameByCalculationId(calculationId);
    res.json();
});
router.get('/result/getDocument/:clientId/:calculationId', async (req, res) => {
    try {
        const calculationId = parseInt(req.params.calculationId);
        const clientId = req.params.clientId;

        // Получаем данные из БД
        const client = await queries.getClientById(clientId);
        const calculation = await queries.getCalculationById(calculationId);
        const structuralElement = await queries.getStructuralElementFrameByCalculationId(calculationId);
        const results = await queries.getResultsByCalculationId(calculationId);

        // Генерация PDF
        const filePath = await generateContractPDF(client[0], calculation[0], structuralElement, results);

        // Отправляем файл пользователю
        res.download(filePath, (err) => {
            if (err) {
                console.error("Ошибка при отправке файла:", err);
                return res.status(500).json({ success: false, message: "Ошибка при отправке файла" });
            }
            // 🧹 Удаляем файл через 30 секунд после скачивания
            setTimeout(() => fs.unlinkSync(filePath), 30000);
        });

    } catch (error) {
        console.error("Ошибка при создании PDF:", error);
        res.status(500).json({ success: false, message: "Ошибка при создании договора" });
    }
});

async function generateContractPDF(client, calculation, structuralElements, results) {
    const html = `
        <html>
        <head>
            <style>
                body { font-family: Arial, sans-serif; }
                h1, h2 { text-align: center; }
                table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
                th, td { border: 1px solid black; padding: 8px; text-align: left; }
                th { background-color: #f2f2f2; }
            </style>
        </head>
        <body>
            <h1>ДОГОВОР</h1>
            <h2>Клиент</h2>
            <p><strong>ФИО:</strong> ${client.first_name} ${client.second_name} ${client.last_name}</p>
            <p><strong>Телефон:</strong> ${client.phone}</p>
            <p><strong>Email:</strong> ${client['e-mail']}</p>
            <p><strong>Адрес:</strong> ${client.adress}</p>
            
            <h2>Объект строительства</h2>
            <p><strong>Адрес:</strong> ${calculation.address_object_constractions}</p>
            <p><strong>Дата создания:</strong> ${calculation.created_date}</p>
            <p><strong>Статус:</strong> ${calculation.status}</p>
            
            <h2>Каркас</h2>
            <table>
                <tr>
                    <th>Этаж</th>
                    <th>Периметр стен (м)</th>
                    <th>Площадь основания (м2)</th>
                    <th>Толщина внешних стен (мм)</th>
                    <th>Толщина перекрытий (мм)</th>
                </tr>
                ${structuralElements.map(el => `
                    <tr>
                        <td>${el.floor_number}</td>
                        <td>${el.perimeter_of_external_walls}</td>
                        <td>${el.base_area}</td>
                        <td>${el.external_wall_thickness}</td>
                        <td>${el.overlap_thickness}</td>
                    </tr>
                `).join('')}
            </table>
            
            <h2>Материалы</h2>
            <table>
                <tr>
                    <th>Материал</th>
                    <th>Количество</th>
                    <th>Единицы измерения</th>
                    <th>Цена за единицу (руб.)</th>
                    <th>Итоговая стоимость (руб.)</th>
                </tr>
                ${results.map(res => `
                    <tr>
                        <td>${res.material}</td>
                        <td>${res.amount}</td>
                        <td>${res.measurement_units_name}</td>
                        <td>${res.price}</td>
                        <td>${res.full_price}</td>
                    </tr>
                `).join('')}
            </table>
        </body>
        </html>
    `;

    const contractsDir = path.join(__dirname, '../contracts');
    if (!fs.existsSync(contractsDir)) {
        fs.mkdirSync(contractsDir, { recursive: true });
    }

    const filePath = path.join(contractsDir, `contract_${Date.now()}.pdf`);

    return new Promise((resolve, reject) => {
        pdf.create(html).toFile(filePath, (err, res) => {
            if (err) {
                console.error("Ошибка при создании PDF:", err);
                reject(err);
            } else {
                console.log("PDF создан:", res.filename);
                resolve(res.filename);
            }
        });
    });
}


module.exports = router;
