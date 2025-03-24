const queries = require('./queries');

function recoginzeAndCalculate(data) {
    console.log(data);

    const results = [] // Результаты для каждого этажа отдельно

    for (let i = 0; i < data.floors.length; i++) {


// Расчет проемов
        let sqWindows=0;
        let woodWindows=0;

        let sqExternalDoors=0;
        let woodExternalDoors=0;

        let sqInternalDoors=0;
        let woodInternalDoors=0;
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

        let numOfFloors;
        if (i === 0){
            numOfFloors = 2; // Пол и потолок для первого этажа
        } else
            numOfFloors = 1; // Только потолок для остальных этажей
        const resultForFloor = {
            // Общие данные
            //
            // data.floors.length - количество этажей по ТЗ. Как будто неправильно
            //
            baseData: {
                sqOuterWalls: data.floors[i].perimeter * data.floors[i].height * data.floors.length,
                sqInnerWalls: data.floors[i].innerWallLength * data.floors[i].height * data.floors.length,
            },
            //
            //
            //
            // Внешние стены
            outerWalls:{
                woodForOuterHolders: Math.ceil(data.floors[i].perimeter/0.6 + 1),
                woodForSq: data.floors[i].perimeter*2/3,
                sqWindows: sqWindows,
                sqExternalDoors: sqExternalDoors,
                sqInternalDoors: sqInternalDoors,
                woodWindows: woodWindows,
                woodExternalDoors: woodExternalDoors,
                woodInternalDoors: woodInternalDoors,

//площадь окон, дверей и внутренних проемов
                woodForOpenings: Math.ceil((woodWindows + woodExternalDoors)/3),
                woodForOuterWall: this.woodForOuterHolders + this.woodForSq + this.woodForOpenings, // Итого досок на внешние стены
                woodThickness: data.floors[i].wallThickness, // Толщина досок на внешние стены
                woodForOuterWallVolume: this.woodForOuterWall * 0.05 * 3 * this.woodThickness, // Объем досок на внешние стены
                sqOSB: this.sqOuterWalls * 2 * 1.15, // Площадь OSB для внешних стен и внутренних стен
                sqSteamWaterProofAndWindscreen: this.sqOuterWalls * 1.15, // Площадь парогидроизоляции и ветрозащиты для внешних стен
                sqInsulationOuterWalls: this.sqOuterWalls * 1.1 - (sqWindows + sqExternalDoors), // Площадь утеплителя для внешних стен
                insulationThickness: this.woodThickness, // Толщина утеплителя равна толщине досок
                insulationVolume: this.sqInsulationOuterWalls * this.insulationThickness/1000, // Объем утеплителя

            },

// Внутренние стены
            innerWalls: {
                woodForInnerWall: Math.ceil(data.floors[i].innerWallLength/0.6), // Количество досок на внутренние стены
                woodForInnerWallOpenings: Math.ceil(woodInternalDoors/3), // Количество досок на внутренние проемы
                woodForInnerWallSum: this.woodForInnerWall + this.woodForInnerWallOpenings, // Итого досок на внутренние стены
                innerWallThickness: data.floors[i].innerWallThickness, // Толщина досок на внутренние стены
                innerWallVolume: this.woodForInnerWallSum * this.innerWallThickness/1000 * 3 * 0.05, // Объем досок на внутренние стены
                sqOSBInnerWall: this.sqInnerWalls * 2 * 1.15, // Площадь OSB для внутренних стен

            },

// Перекрытия
            overlaps:{
                wood: Math.ceil(data.floors[i].baseArea * 0.7),
                woodThickness: data.floors[i].overlaps.floorThickness,
                woodVolume: this.wood * this.woodThickness/1000 * 6 * 0.05, // Объем досок для перекрытия
                sqOSB: data.floors[i].baseArea * 2 * 1.15 * numOfFloors,
                sqSteamWaterProofAndWindscreen: data.floors[i].baseArea * 1.15,
                sqInsulation: data.floors[i].baseArea * numOfFloors * 1.1,
                insulationThickness: data.floors[i].overlaps.floorThickness,
                insulationVolume: this.sqInsulation * this.insulationThickness/1000, // Объем утеплителя
            }
        }

    }
}

module.exports = {
    recoginzeAndCalculate
};