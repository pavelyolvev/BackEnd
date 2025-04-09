var express = require('express');
var router = express.Router();
const db = require('../db');
const queries = require('../queries');
const PDFDocument = require('pdfkit');
const puppeteer = require('puppeteer');
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
    const groupedMaterials = results.reduce((acc, res) => {
        if (!acc[res.floor_number]) {
            acc[res.floor_number] = { materials: [], total: 0 };
        }
        acc[res.floor_number].materials.push(res);
        acc[res.floor_number].total += res.full_price; // Считаем итог для этажа
        return acc;
    }, {});

    const totalSum = Object.values(groupedMaterials).reduce((sum, floor) => sum + floor.total, 0); // Общий итог

    const html = `
    <html>
    <head>
        <style>
            body { font-family: Arial, sans-serif; }
            h1, h2 { text-align: center; }
            table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
            th, td { border: 1px solid black; padding: 8px; text-align: left; }
            th { background-color: #f2f2f2; }
            .subcategory { font-weight: bold; background-color: #e6e6e6; }
            .total { font-weight: bold; background-color: #d9edf7; text-align: right; }
            p {font-size: 14px;}
            label {font-size: 14px;}
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
        ${structuralElements.map((el, i) => `
            <h2>Этаж ${el.floor_number}</h2>
            <div class="form-group">
                <label>Высота этажа:</label>
                <span>${el.floor_height}</span><span class="unit">м</span>
            </div>
            <div class="form-group">
                <label>Периметр внешних стен:</label>
                <span>${el.perimeter_of_external_walls}</span><span class="unit">м</span>
            </div>
            <div class="form-group">
                <label>Площадь основания:</label>
                <span>${el.base_area}</span><span class="unit">м²</span>
            </div>
            <div class="form-group">
                <label>Толщина внешних стен:</label>
                <span>${el.external_wall_thickness}</span><span class="unit">мм</span>
            </div>
            <div class="form-group">
                <label>Длина внутренних стен:</label>
                <span>${el.internal_wall_length}</span><span class="unit">м</span>
            </div>
            <div class="form-group">
                <label>Толщина внутренних стен:</label>
                <span>${el.internal_wall_thickness}</span><span class="unit">мм</span>
            </div>
            
            ${el.OSB_external_wall || el.steam_waterproofing_external_wall || el.windscreen_extern_wall || el.insulation_external_wall ? `
            <div class="form-group">
                <label>Внешние стены:</label>
                <ul>
                    ${el.OSB_external_wall ? `<li>ОСБ: ${el.OSB_external_wall} мм</li>` : ''}
                    ${el.steam_waterproofing_external_wall ? `<li>Парогидроизоляция: ${el.steam_waterproofing_external_wall}</li>` : ''}
                    ${el.windscreen_extern_wall ? `<li>Ветрозащита: ${el.windscreen_extern_wall}</li>` : ''}
                    ${el.insulation_external_wall ? `<li>Утеплитель: ${el.insulation_external_wall}</li>` : ''}
                </ul>
            </div>` : ''}

            ${el.OSB_internal_wall ? `
            <div class="form-group">
                <label>Внутренние стены:</label>
                <ul>
                    ${el.OSB_internal_wall ? `<li>ОСБ: ${el.OSB_internal_wall} мм</li>` : ''}
                </ul>
            </div>` : ''}
            ${Array.isArray(el.windows) && el.windows.length > 0 ? `
    <div class="form-group">
        <label>Окна:</label>
        <ul>
            ${el.windows.map(w => `
                <li>Ширина: ${Number(w.width).toFixed(2)} м, Высота: ${Number(w.height).toFixed(2)} м, Количество: ${w.amount}</li>
            `).join('')}
        </ul>
    </div>` : ''}

${Array.isArray(el.internalDoors) && el.internalDoors.length > 0 ? `
    <div class="form-group">
        <label>Внутренние двери:</label>
        <ul>
            ${el.internalDoors.map(d => `
                <li>Ширина: ${Number(d.width).toFixed(2)} м, Высота: ${Number(d.height).toFixed(2)} м, Количество: ${d.amount}</li>
            `).join('')}
        </ul>
    </div>` : ''}

${Array.isArray(el.externalDoors) && el.externalDoors.length > 0 ? `
    <div class="form-group">
        <label>Внешние двери:</label>
        <ul>
            ${el.externalDoors.map(d => `
                <li>Ширина: ${Number(d.width).toFixed(2)} м, Высота: ${Number(d.height).toFixed(2)} м, Количество: ${d.amount}</li>
            `).join('')}
        </ul>
    </div>` : ''}

            
            
            
            ${el.overlap_thickness ? `
            <div class="form-group">
                <label>Перекрытия:</label>
                <ul>
                    ${el.overlap_thickness ? `<li>Толщина перекрытий: ${el.overlap_thickness} мм</li>` : ''}
                    ${el.OSB_thickness ? `<li>ОСБ: ${el.OSB_thickness} мм</li>` : ''}
                    ${el.steam_waterproofing_thickness ? `<li>Парогидроизоляция: ${el.steam_waterproofing_thickness}</li>` : ''}
                    ${el.windscreen_thickness ? `<li>Ветрозащита: ${el.windscreen_thickness}</li>` : ''}
                    ${el.insulation_thickness ? `<li>Утеплитель: ${el.insulation_thickness}</li>` : ''}
                </ul>
            </div>` : ''}
            
            <br>
        `).join('')}
        
        <h2>Материалы</h2>
        <table>
            <tr>
                <th>Этаж</th>
                <th>Группа</th>
                <th>Материал</th>
                <th>Количество</th>
                <th>Единицы измерения</th>
                <th>Цена за единицу (руб.)</th>
                <th>Итоговая стоимость (руб.)</th>
            </tr>
            ${Object.entries(groupedMaterials).map(([floor, data]) => `
                <tr class="subcategory">
                    <td colspan="7">Этаж ${floor}</td>
                </tr>
                ${['externalWall', 'internalWall', 'overlaps'].map(type => {
        const typeMaterials = data.materials.filter(res => res.structural_type === type);
        if (typeMaterials.length === 0) return '';
        return `
                        <tr class="subcategory">
                            <td></td>
                            <td colspan="6">
                                ${type === 'externalWall' ? 'Обшивка внешних стен'
            : type === 'internalWall' ? 'Обшивка внутренних стен'
                : 'Перекрытия'}
                            </td>
                        </tr>
                        ${typeMaterials.map(res => `
                            <tr>
                                <td></td>
                                <td></td>
                                <td>${res.material}</td>
                                <td>${res.amount}</td>
                                <td>${res.measurement_units_name}</td>
                                <td>${res.price}</td>
                                <td>${res.full_price}</td>
                            </tr>
                        `).join('')}
                    `;
    }).join('')}
                <tr class="total">
                    <td colspan="6"><strong>Итог по этажу ${floor}:</strong></td>
                    <td><strong>${data.total} руб.</strong></td>
                </tr>
            `).join('')}
            <tr class="total">
                <td colspan="6"><strong>Общая итоговая стоимость:</strong></td>
                <td><strong>${totalSum} руб.</strong></td>
            </tr>
        </table>
    </body>
    </html>
`;




    const contractsDir = path.join(__dirname, '../contracts');
    if (!fs.existsSync(contractsDir)) fs.mkdirSync(contractsDir, { recursive: true });

    const filePath = path.join(contractsDir, `contract_${Date.now()}.pdf`);

    try {
        const browser = await puppeteer.launch({
            headless: 'new',
            args: ['--no-sandbox', '--disable-setuid-sandbox']
        });
        const page = await browser.newPage();
        await page.setContent(html, { waitUntil: 'networkidle0' });
        await page.pdf({ path: filePath, format: 'A4', printBackground: true });
        await browser.close();

        console.log('PDF создан:', filePath);
        return filePath;
    } catch (err) {
        console.error('Ошибка при создании PDF:', err);
        throw err;
    }
}


module.exports = router;
