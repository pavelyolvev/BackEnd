const queries = require('./queries');

function recoginzeAndCalculate(data) {
    console.log(data);

    let sqOuterWalls =[]
    let sqInnerWalls =[]

    let woodForOuterHolders =[] // Количество досок на внешние стойки
    let woodForSq =[] // Количество досок для основания
    let woodForOpenings =[] // Количество досок на проемы

    let woodForOuterWall = []
    let woodThickness = []
    let woodForOuterWallVolume = []

    let sqOSB = []
    let sqSteamWaterProofAndWindscreen = []
    let sqInsulationOuterWalls = []
    let insulationThickness = []
    let insulationVolume = []

    let woodForinnerWall = []
    let woodForinnerWallOpenings = []
    let woodForinnerWallSum = []
    let innerWallThickness = []

    let innerWallVolume = []
    let sqOSBInnerWall = []



    // Расчет для отдельных этажей

    for(let i = 0; i < data.floors.length; i++) {

// Общие данные
        //
        // data.floors.length - количество этажей по ТЗ. Как будто неправильно
        //
        sqOuterWalls[i] = data.floors[i].walls.perimeter * data.floors[i].walls.height * data.floors.length;
        sqInnerWalls[i] = data.floors[i].walls.innerWallLength * data.floors[i].walls.height  * data.floors.length;
        //
        //
        //
// Внешние стены
        woodForOuterHolders[i] = Math.ceil(data.floors[i].walls.perimeter/0.6 + 1);
        woodForSq[i] = data.floors[i].walls.perimeter*2/3;

// Расчет проемов
        let sqWindows=0;
        let woodWindows=0;

        let sqExternalDoors=0;
        let woodExternalDoors=0;

        let sqInternalDoors=0;
        let woodInternalDoors=0;
//площадь окон, дверей и внутренних проемов
        for (let j = 0; j < data.floors[i].windows.length; j++) {
            sqWindows += data.floors[i].windows[j].width * data.floors[i].windows[j].height * data.floors[i].windows[j].count;
            woodWindows += (data.floors[i].windows[j]+data.floors[i].windows[j].height)*2*data.floors[i].windows[j].count;
        }
        for (let j = 0; j < data.floors[i].externalDoors.length; j++) {
            sqExternalDoors += data.floors[i].externalDoors[j].width * data.floors[i].externalDoors[j].height * data.floors[i].externalDoors[j].count;
            woodExternalDoors += (data.floors[i].externalDoors[j]+data.floors[i].externalDoors[j].height)*2*data.floors[i].externalDoors[j].count;
        }
        for (let j = 0; j < data.floors[i].internalDoors.length; j++) {
            sqInternalDoors += data.floors[i].internalDoors[j].width * data.floors[i].internalDoors[j].height * data.floors[i].internalDoors[j].count;
            woodInternalDoors += (data.floors[i].internalDoors[j]+data.floors[i].internalDoors[j].height)*2*data.floors[i].internalDoors[j].count;
        }
        woodForOpenings[i] = Math.ceil((woodWindows + woodExternalDoors)/3);

        woodForOuterWall[i] = woodForOuterHolders[i] + woodForSq[i] + woodForOpenings[i] // Итого досок на внешние стены

        woodThickness[i] = data.floors[i].wallThickness; // Толщина досок на внешние стены
        woodForOuterWallVolume[i] = woodForOuterWall[i] * 0.05 * 3 * woodThickness[i]; // Объем досок на внешние стены

        sqOSB[i] = sqOuterWalls[i] * 2 * 1.15; // Площадь OSB для внешних стен и внутренних стен

        sqSteamWaterProofAndWindscreen[i] = sqOuterWalls[i] * 1.15; // Площадь парогидроизоляции и ветрозащиты для внешних стен

        sqInsulationOuterWalls[i] = sqOuterWalls[i] * 1.1 - (sqWindows + sqExternalDoors); // Площадь утеплителя для внешних стен

        insulationThickness[i] = woodThickness[i]; // Толщина утеплителя равна толщине досок

        insulationVolume[i] = sqInsulationOuterWalls[i] * insulationThickness[i]/1000; // Объем утеплителя

// Внутренние стены

        woodForinnerWall[i] = Math.ceil(data.floors[i].innerWallLength/0.6); // Количество досок на внутренние стены

        woodForinnerWallOpenings[i] = Math.ceil(woodInternalDoors/3); // Количество досок на внутренние проемы

        woodForinnerWallSum[i] = woodForinnerWall[i] + woodForinnerWallOpenings[i]; // Итого досок на внутренние стены

        innerWallThickness[i] = data.floors[i].innerWallThickness; // Толщина досок на внутренние стены

        innerWallVolume[i] = woodForinnerWallSum[i] * innerWallThickness[i]/1000 * 3 * 0.05; // Объем досок на внутренние стены

        sqOSBInnerWall[i] = sqInnerWalls[i] * 2 * 1.15; // Площадь OSB для внутренних стен
    }



}

module.exports = {
    recoginzeAndCalculate
};