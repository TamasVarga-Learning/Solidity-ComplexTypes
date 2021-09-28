const path = require('path');
const solc = require('solc');
const fs = require('fs-extra');

const solFileName = 'ComplexTypeExample.sol';

// delete build folder
const buildPath = path.resolve(__dirname, 'build');
fs.removeSync(buildPath);

// read contract file
const solFilePath = path.resolve(__dirname, 'contracts', solFileName);
const source = fs.readFileSync(solFilePath, 'utf8');

var input = {
    language: 'Solidity',
    sources: {
        'ComplexTypeExample.sol' : {
            content: source
        }
    },
    settings: {
        outputSelection: {
            '*': {
                '*': [ '*' ]
            }
        }
    }
};

// compile contracts
const jsonResult = solc.compile(JSON.stringify(input));
var compileResult = JSON.parse(jsonResult);
console.log(compileResult);

const contracts = compileResult.contracts;
console.log(contracts);

// write output to build folder
fs.ensureDirSync(buildPath);

for (let contract in contracts) {
    fs.outputJsonSync(
        path.resolve(buildPath, contract.replace(':', '') + '.json'),
        contracts[contract]
    );
}
