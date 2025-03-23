const queries = require('./queries');

function recoginzeAndCalculate(data) {
    console.log(data);

    let sqOuterWalls =[]
    let sqInnerWalls =[]

    let woodForOuterHolders =[] // Количество досок на внешние стойки
    let woodForSq =[] // Количество досок для основания
    let woodForOpenings =[] // Количество досок на проемы

    let woodForOuterWall


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


    }

    // Расчет проемов
    let windows=0;
    let externalDoors=0;
    let internalDoors=0;

    for (let i = 0; i < data.windows.length; i++) {
        windows += data.windows[i].width * data.windows[i].height * data.windows[i].count;
    }
    for (let i = 0; i < data.externalDoors.length; i++) {
        externalDoors += data.externalDoors[i].width * data.externalDoors[i].height * data.externalDoors[i].count;
    }
    for (let i = 0; i < data.internalDoors.length; i++) {
        internalDoors += data.internalDoors[i].width * data.internalDoors[i].height * data.internalDoors[i].count;
    }
    woodForOpenings[0] = Math.ceil((windows+externalDoors+internalDoors)/3);


}

module.exports = {
    recoginzeAndCalculate
};