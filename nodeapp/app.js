// requires
var fs = require ('fs');
var prompt = require('prompt');
var erisC = require('eris-contracts');

// NOTE. On Windows/OSX do not use localhost. find the
// url of your chain with:
// docker-machine ls
// and find the docker machine name you are using (usually default or eris).
// for example, if the URL returned by docker-machine is tcp://192.168.99.100:2376
// then your erisdbURL should be http://192.168.99.100:1337/rpc
var erisdbURL = "http://localhost:1337/rpc";

// get the abi and deployed data squared away
var contractData = require('../contracts/epm.json');
var storageRegistryAddress = contractData["contractRegistry"];
var registryAbi = JSON.parse(fs.readFileSync("../contracts/abi/" + storageRegistryAddress));

// properly instantiate the contract objects manager using the erisdb URL
// and the account data (which is a temporary hack)
var accountData = require('./accounts.json');
var contractsManager = erisC.newContractManagerDev(erisdbURL, accountData.simplechain_full_000);

// properly instantiate the contract objects using the abi and address
var storageContract = contractsManager.newContractFactory(registryAbi).at(storageRegistryAddress);

// display the current value of idi's contract by calling
// the `get` function of idi's contract
function getValue(callback) {
  idisContract.get(function(error, result){
    if (error) { throw error }
    console.log("Idi's number is:\t\t\t" + result.toNumber());
    callback();
  });
}

// prompt the user to change the value of idi's contract
function changeValue() {
  prompt.message = "What number should Idi make it?";
  prompt.delimiter = "\t";
  prompt.start();
  prompt.get(['value'], function (error, result) {
    if (error) { throw error }
    setValue(result.value)
  });
}

// using eris-contracts call the `set` function of idi's
// contract using the value which was recieved from the
// changeValue prompt
function setValue(value) {
  idisContract.set(value, function(error, result){
    if (error) { throw error }
    getValue(function(){});
  });
}

// run
// getValue(changeValue);

function getContractList(){
    prompt.message = "query for an address";
    prompt.start();
    // prompt.get(['address'], function (error, result){
    //     if(error) {throw error}
    storageContract.getContracts("9CE900C6ADF49E56E3DA1D5FAF99D04BA2C8AE49", function(error, result){
        if(error) {throw error}
        debugger;
        console.log(result);
        });
    storageContract.getContracts("B8ED299251251867BAB64B0748D4DDFE4BEC1F72", function(error, result){
        if(error) {throw error}
        debugger;
        console.log(result);
    });
    storageContract.getContracts("00DB2E1787AC62E7F3225D1F3C0142B939E05696", function(error, result){
        if(error) {throw error}
        debugger;
        console.log(result)
    });
    // });
}

getContractList();

