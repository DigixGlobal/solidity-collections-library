var DoublyLinkedList = artifacts.require("./DoublyLinkedList.sol");
var TestDoublyLinkedList = artifacts.require("./TestDoublyLinkedList.sol");
var TestLibraryUint = artifacts.require("./TestLibraryUint.sol");
var TestLibraryAddress = artifacts.require("./TestLibraryAddress.sol");
var TestLibraryBytes = artifacts.require("./TestLibraryBytes.sol");
var ExampleStorage = artifacts.require("./ExampleStorage.sol");
var ExampleController = artifacts.require("./ExampleController.sol");
var ExampleInteractive = artifacts.require("./ExampleInteractive.sol");

var ExampleIndexedStorage = artifacts.require("./ExampleIndexedStorage.sol");
var ExampleIndexedController = artifacts.require("./ExampleIndexedController.sol");
var ExampleIndexedInteractive = artifacts.require("./ExampleIndexedInteractive.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(DoublyLinkedList).then(() => {
    deployer.link(DoublyLinkedList, TestDoublyLinkedList);
    deployer.link(DoublyLinkedList, TestLibraryUint);
    deployer.link(DoublyLinkedList, TestLibraryAddress);
    return deployer.link(DoublyLinkedList, TestLibraryBytes);
  }).then(() => {
    deployer.link(DoublyLinkedList, ExampleIndexedStorage);
    return deployer.link(DoublyLinkedList, ExampleStorage);
  }).then(() => {
    deployer.deploy(TestLibraryBytes);
    deployer.deploy(TestLibraryAddress);
    return deployer.deploy(TestLibraryUint);
  }).then(() => {
    deployer.deploy(ExampleStorage);
    deployer.deploy(ExampleIndexedStorage);
    return deployer.deploy(TestDoublyLinkedList);
  }).then(() => {
    ExampleIndexedStorage.at(ExampleIndexedStorage.address).initialize();
    deployer.deploy(ExampleIndexedController, ExampleIndexedStorage.address);
    return deployer.deploy(ExampleController, ExampleStorage.address);
  }).then(() => {
    deployer.deploy(ExampleIndexedInteractive, ExampleIndexedController.address);
    return deployer.deploy(ExampleInteractive, ExampleController.address);
  });
};
