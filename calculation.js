const queries = require('./queries');

function roundToFixed(num, places) {
    return Number((num).toFixed(places)); //
}

function saveSourceDataToDB(data) {

}
async function recognizeAndCalculate(calculationId) {
    const data = await queries.getStructuralElementFrameByCalculationId(calculationId);
    console.log(data);

    const results = data.map((floor) => {
        let sqWindows = 0, woodWindows = 0;
        let sqExternalDoors = 0, woodExternalDoors = 0;
        let sqInternalDoors = 0, woodInternalDoors = 0;

        let isInternalWallSheeting = false;
        let isExternalWallSheeting = false;
        let isOverlaps = false;


        if (floor.OSB_internal_wall !== null)
            isInternalWallSheeting = true;
        if (floor.OSB_external_wall !== null && floor.steam_waterproofing_external_wall !== null &&
            floor.windscreen_extern_wall !== null && floor.insulation_external_wall !== null)
            isExternalWallSheeting = true;
        if (floor.overlap_thickness !== null && floor.OSB_thickness !== null &&
            floor.steam_waterproofing_thickness !== null && floor.windscreen_thickness !== null &&
            floor.insulation_thickness !== null)
            isOverlaps = true;
        const options = {isInternalWallSheeting, isExternalWallSheeting, isOverlaps};

        floor.windows.forEach((w) => {
            sqWindows += w.width * w.height * w.amount;
            woodWindows += (w.width + w.height) * 2 * w.amount;
        });

        floor.externalDoors.forEach((d) => {
            sqExternalDoors += d.width * d.height * d.amount;
            woodExternalDoors += (d.width + d.height) * 2 * d.amount;
        });

        floor.internalDoors.forEach((d) => {
            sqInternalDoors += d.width * d.height * d.amount;
            woodInternalDoors += (d.width + d.height) * 2 * d.amount;
        });

        const numOfFloors = floor.floor_number === 1 ? 2 : 1;
        const sqOuterWalls = floor.perimeter_of_external_walls * floor.base_area / 56;
        const sqInnerWalls = floor.internal_wall_length * floor.base_area / 56;

        const woodForOuterHolders = Math.ceil(floor.perimeter_of_external_walls / 0.6 + 1);
        const woodForSq = floor.perimeter_of_external_walls * 2 / 3;
        const woodForOpenings = Math.ceil((woodWindows + woodExternalDoors) / 3);
        const woodForOuterWall = woodForOuterHolders + woodForSq + woodForOpenings;
        const woodThickness = floor.external_wall_thickness;
        const sqInsulationOuterWalls = roundToFixed(sqOuterWalls * 1.1 - (sqWindows + sqExternalDoors), 2);

        const woodForInnerWall = Math.ceil(floor.internal_wall_length / 0.6);
        const woodForInnerWallOpenings = Math.ceil(woodInternalDoors / 3);
        const woodForInnerWallSum = woodForInnerWall + woodForInnerWallOpenings;

        const woodOverlap = Math.ceil(floor.base_area * 0.7);
        const woodOverlapThickness = parseInt(floor.overlap_thickness);

        return {
            options,
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
                woodForOuterWallVolume: roundToFixed(woodForOuterWall * 0.05 * 3 * woodThickness / 1000, 2),
                sqOSB: roundToFixed(sqOuterWalls * 2 * 1.15, 2),
                steamWaterProofName: floor.steam_waterproofing_external_wall,
                windscreenName: floor.windscreen_extern_wall,
                sqSteamWaterProofAndWindscreen: roundToFixed(sqOuterWalls * 1.15, 2),
                sqInsulationOuterWalls,
                insulationName: floor.insulation_external_wall,
                OSBThickness: floor.OSB_external_wall,
                insulationThickness: woodThickness,
                insulationVolume: roundToFixed(sqInsulationOuterWalls * woodThickness / 1000, 2),
            },
            innerWalls: {
                woodForInnerWall,
                woodForInnerWallOpenings,
                woodForInnerWallSum,
                innerWallThickness: floor.internal_wall_thickness,
                innerWallVolume: roundToFixed(woodForInnerWallSum * floor.internal_wall_thickness / 1000 * 3 * 0.05, 2),
                sqOSBInnerWall: roundToFixed(sqInnerWalls * 2 * 1.15, 2),
                OSBThickness: floor.OSB_internal_wall,
            },
            overlaps: {
                wood: woodOverlap,
                woodThickness: woodOverlapThickness,
                insulationName: floor.insulation_thickness,
                OSBThickness: floor.OSB_thickness,
                steamWaterProofName: floor.steam_waterproofing_thickness,
                windscreenName: floor.windscreen_thickness,
                woodVolume: roundToFixed(woodOverlap * woodOverlapThickness / 1000 * 6 * 0.05, 2),
                sqOSB: roundToFixed(floor.base_area * 2 * 1.15 * numOfFloors, 2),
                sqSteamWaterProofAndWindscreen: roundToFixed(floor.base_area * 1.15, 2),
                sqInsulation: roundToFixed(floor.base_area * numOfFloors * 1.1, 2),
                insulationThickness: woodOverlapThickness,
                insulationVolume: roundToFixed(floor.base_area * numOfFloors * 1.1 * woodOverlapThickness / 1000, 2),
            },
        };
    });

    console.log(results);
    return results;
}

module.exports = {
    recognizeAndCalculate
};