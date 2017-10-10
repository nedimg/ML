const PapaParse = require('papaparse');
const fs = require('fs');

const typeMappings = {
    'area': 1,
    'areaStacked': 2,
    'areaStep': 3,
    'bar': 4,
    'barPacked': 5,
    'barStacked': 6,
    'bubble': 7,
    'column': 8,
    'columnPacked': 9,
    'columnStacked': 10,
    'donut': 11,
    'dualAxis': 12,
    'grid': 13,
    'line': 14,
    'lineStep': 15,
    'pie': 16,
    'pyramid': 17,
    'scatter': 18,
    'scatterLine': 19,
    'spline': 20,
    'stockArea': 21,
    'stockColumn': 22,
    'stockDualAxis': 23,
    'stockLine': 24,
    'stockSpline': 25,
}

const parseCompletedCallback = results => {
    const { data, errors } = results;
    if (results.errors && results.errors.length) {
        console.error(results.errors[0]);
        return;
    }

    data.forEach(row => row.type = typeMappings[row.type]);
    const index60 = Math.floor(data.length * 0.6);
    const index80 = Math.floor(data.length * 0.8);
    
    const trainingSet = data.slice(0, index60);
    const validationSet = data.slice(index60, index80);
    const testSet = data.slice(index80, data.length);

    if (trainingSet.length + validationSet.length + testSet.length !== data.length) {
        console.error('Splitting datasets into test, cross validation and training check failed!');
        return;
    }

    fs.writeFileSync('./output_full.csv', PapaParse.unparse(data));
    fs.writeFileSync('./output_training.csv', PapaParse.unparse(trainingSet, { header: false }));
    fs.writeFileSync('./output_validation.csv', PapaParse.unparse(validationSet, { header: false }));
    fs.writeFileSync('./output_test.csv', PapaParse.unparse(testSet, { header: false }));
    console.info('DONE! bye bye...');
    process.exit();
};

PapaParse.parse(fs.createReadStream('charts.csv'), {
    header: true,
    complete: parseCompletedCallback,
    error: e => { console.error('An error occured:', e); process.exit();  },
});

/*
47 | area
56 | areaStacked
11 | areaStep
367 | bar
96 | barPacked
113 | barStacked
 8 | bubble
867 | column
403 | columnPacked
171 | columnStacked
19 | donut
108 | dualAxis
641 | grid
829 | line
 5 | lineStep
355 | pie
63 | pyramid
125 | scatter
26 | scatterLine
34 | spline
 9 | stockArea
17 | stockColumn
30 | stockDualAxis
267 | stockLine
18 | stockSpline
*/