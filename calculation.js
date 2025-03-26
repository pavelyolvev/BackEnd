const queries = require('./queries');

function roundToFixed(num, places) {
    return Number((num).toFixed(places)); //
}

function saveSourceDataToDB(data) {

}
function recognizeAndCalculate(data) {
    //console.log(data);


    const results = [];

    for (let i = 0; i < data.floors.length; i++) {
        // Расчет проемов
        let sqWindows = 0;
        let woodWindows = 0;

        let sqExternalDoors = 0;
        let woodExternalDoors = 0;

        let sqInternalDoors = 0;
        let woodInternalDoors = 0;

        data.floors[i].windows.forEach((w) => {
            sqWindows += w.width * w.height * w.count;
            woodWindows += (w.width + w.height) * 2 * w.count;
        });

        data.floors[i].externalDoors.forEach((d) => {
            sqExternalDoors += d.width * d.height * d.count;
            woodExternalDoors += (d.width + d.height) * 2 * d.count;
        });

        data.floors[i].internalDoors.forEach((d) => {
            sqInternalDoors += d.width * d.height * d.count;
            woodInternalDoors += (d.width + d.height) * 2 * d.count;
        });

        const numOfFloors = i === 0 ? 2 : 1;

        const sqOuterWalls = data.floors[i].perimeter * data.floors[i].height;
        const sqInnerWalls = data.floors[i].innerWallLength * data.floors[i].height;

        const woodForOuterHolders = Math.ceil(data.floors[i].perimeter / 0.6 + 1);
        const woodForSq = data.floors[i].perimeter * 2 / 3;
        const woodForOpenings = Math.ceil((woodWindows + woodExternalDoors) / 3);
        const woodForOuterWall = woodForOuterHolders + woodForSq + woodForOpenings;
        const woodThickness = data.floors[i].wallThickness;
        const sqInsulationOuterWalls = roundToFixed(sqOuterWalls * 1.1 - (sqWindows + sqExternalDoors), 2);

        const woodForInnerWall = Math.ceil(data.floors[i].innerWallLength / 0.6);
        const woodForInnerWallOpenings = Math.ceil(woodInternalDoors / 3);
        const woodForInnerWallSum = woodForInnerWall + woodForInnerWallOpenings;

        const woodOverlap = Math.ceil(data.floors[i].baseArea * 0.7);
        const woodOverlapThickness = data.floors[i].overlaps.floorThickness;

        const resultForFloor = {
            baseData: {
                sqOuterWalls,
                sqInnerWalls,
            },
            outerWalls: {
                woodForOuterHolders,
                woodForSq,
                sqWindows,
                sqExternalDoors,
                sqInternalDoors,
                woodWindows,
                woodExternalDoors,
                woodInternalDoors,
                woodForOpenings,
                woodForOuterWall,
                woodThickness,
                woodForOuterWallVolume: roundToFixed(woodForOuterWall * 0.05 * 3 * woodThickness/1000, 2),
                sqOSB: roundToFixed(sqOuterWalls * 2 * 1.15, 2),
                sqSteamWaterProofAndWindscreen: roundToFixed(sqOuterWalls * 1.15, 2),
                sqInsulationOuterWalls,
                insulationThickness: woodThickness,
                insulationVolume: roundToFixed(sqInsulationOuterWalls * woodThickness/1000, 2),
            },
            innerWalls: {
                woodForInnerWall,
                woodForInnerWallOpenings,
                woodForInnerWallSum,
                innerWallThickness: data.floors[i].innerWallThickness,
                innerWallVolume: roundToFixed(woodForInnerWallSum * data.floors[i].innerWallThickness / 1000 * 3 * 0.05, 2),
                sqOSBInnerWall: roundToFixed(sqInnerWalls * 2 * 1.15, 2),
            },
            overlaps: {
                wood: woodOverlap,
                woodThickness: woodOverlapThickness,
                woodVolume: roundToFixed(woodOverlap * woodOverlapThickness / 1000 * 6 * 0.05, 2),
                sqOSB: roundToFixed(data.floors[i].baseArea * 2 * 1.15 * numOfFloors, 2),
                sqSteamWaterProofAndWindscreen: roundToFixed(data.floors[i].baseArea * 1.15, 2),
                sqInsulation: roundToFixed(data.floors[i].baseArea * numOfFloors * 1.1, 2),
                insulationThickness: woodOverlapThickness,
                insulationVolume: roundToFixed(data.floors[i].baseArea * numOfFloors * 1.1 * woodOverlapThickness / 1000, 2),
            },
        };

        results.push(resultForFloor);
    }
    console.log(results);
}


module.exports = {
    recognizeAndCalculate
};