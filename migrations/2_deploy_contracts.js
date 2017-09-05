var LibraryDLL = artifacts.require("./LibraryDLL.sol");
var TestLibraryDLL = artifacts.require("./TestLibraryDLL.sol");
var TestLibraryUintDLL = artifacts.require("./TestLibraryUintDLL.sol");
var TestLibraryAddressDLL = artifacts.require("./TestLibraryAddressDLL.sol");
var TestLibraryBytesDLL = artifacts.require("./TestLibraryBytesDLL.sol");
var ExampleStorage = artifacts.require("./ExampleStorage.sol");
var ExampleController = artifacts.require("./ExampleController.sol");
var ExampleInteractive = artifacts.require("./ExampleInteractive.sol");


module.exports = function(deployer, network, accounts) {
  deployer.deploy(LibraryDLL).then(() => {
    deployer.link(LibraryDLL, TestLibraryDLL);
    deployer.link(LibraryDLL, TestLibraryUintDLL);
    deployer.link(LibraryDLL, TestLibraryAddressDLL);
    deployer.link(LibraryDLL, TestLibraryBytesDLL);
    return deployer.link(LibraryDLL, ExampleStorage);
  }).then(() => {
    deployer.deploy(TestLibraryBytesDLL);
    deployer.deploy(TestLibraryAddressDLL);
    deployer.deploy(TestLibraryUintDLL);
    deployer.deploy(ExampleStorage);
    return deployer.deploy(TestLibraryDLL);
  }).then(() => {
    return deployer.deploy(ExampleController, ExampleStorage.address);
  }).then(() => {
    return deployer.deploy(ExampleInteractive, ExampleController.address);
  });
};
