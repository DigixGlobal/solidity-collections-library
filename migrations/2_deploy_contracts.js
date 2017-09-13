var DoublyLinkedList = artifacts.require("./DoublyLinkedList.sol");
var TestDoublyLinkedList = artifacts.require("./TestDoublyLinkedList.sol");
var TestLibraryUint = artifacts.require("./TestLibraryUint.sol");
var TestLibraryAddress = artifacts.require("./TestLibraryAddress.sol");
var TestLibraryBytes = artifacts.require("./TestLibraryBytes.sol");
var ExampleStorage = artifacts.require("./ExampleStorage.sol");
var ExampleController = artifacts.require("./ExampleController.sol");
var ExampleInteractive = artifacts.require("./ExampleInteractive.sol");


module.exports = function(deployer, network, accounts) {
  deployer.deploy(DoublyLinkedList).then(() => {
    deployer.link(DoublyLinkedList, TestDoublyLinkedList);
    deployer.link(DoublyLinkedList, TestLibraryUint);
    deployer.link(DoublyLinkedList, TestLibraryAddress);
    deployer.link(DoublyLinkedList, TestLibraryBytes);
    return deployer.link(DoublyLinkedList, ExampleStorage);
  }).then(() => {
    deployer.deploy(TestLibraryBytes);
    deployer.deploy(TestLibraryAddress);
    deployer.deploy(TestLibraryUint);
    deployer.deploy(ExampleStorage);
    return deployer.deploy(TestDoublyLinkedList);
  }).then(() => {
    return deployer.deploy(ExampleController, ExampleStorage.address);
  }).then(() => {
    return deployer.deploy(ExampleInteractive, ExampleController.address);
  });
};
