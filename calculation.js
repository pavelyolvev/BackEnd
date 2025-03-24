const queries = require('./queries');

function recognizeAndCalculate(data) {
    console.log(data);

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

        const sqOuterWalls = data.floors[i].perimeter * data.floors[i].height * data.floors.length;
        const sqInnerWalls = data.floors[i].innerWallLength * data.floors[i].height * data.floors.length;

        const woodForOuterHolders = Math.ceil(data.floors[i].perimeter / 0.6 + 1);
        const woodForSq = data.floors[i].perimeter * 2 / 3;
        const woodForOpenings = Math.ceil((woodWindows + woodExternalDoors) / 3);
        const woodForOuterWall = woodForOuterHolders + woodForSq + woodForOpenings;
        const woodThickness = data.floors[i].wallThickness;
        const sqInsulationOuterWalls = sqOuterWalls * 1.1 - (sqWindows + sqExternalDoors);

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
                woodForOuterWallVolume: woodForOuterWall * 0.05 * 3 * woodThickness/1000,
                sqOSB: sqOuterWalls * 2 * 1.15,
                sqSteamWaterProofAndWindscreen: sqOuterWalls * 1.15,
                sqInsulationOuterWalls,
                insulationThickness: woodThickness,
                insulationVolume: sqInsulationOuterWalls * woodThickness/1000,
            },
            innerWalls: {
                woodForInnerWall,
                woodForInnerWallOpenings,
                woodForInnerWallSum,
                innerWallThickness: data.floors[i].innerWallThickness,
                innerWallVolume: woodForInnerWallSum * data.floors[i].innerWallThickness / 1000 * 3 * 0.05,
                sqOSBInnerWall: sqInnerWalls * 2 * 1.15,
            },
            overlaps: {
                wood: woodOverlap,
                woodThickness: woodOverlapThickness,
                woodVolume: woodOverlap * woodOverlapThickness / 1000 * 6 * 0.05,
                sqOSB: data.floors[i].baseArea * 2 * 1.15 * numOfFloors,
                sqSteamWaterProofAndWindscreen: data.floors[i].baseArea * 1.15,
                sqInsulation: data.floors[i].baseArea * numOfFloors * 1.1,
                insulationThickness: woodOverlapThickness,
                insulationVolume: data.floors[i].baseArea * numOfFloors * 1.1 * woodOverlapThickness / 1000,
            },
        };

        results.push(resultForFloor);
    }
    console.log(results);
}


module.exports = {
    recognizeAndCalculate
};