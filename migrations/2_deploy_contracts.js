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
  return deployer.deploy(DoublyLinkedList).then(async() => {
  await deployer.link(DoublyLinkedList, TestDoublyLinkedList);
  await deployer.link(DoublyLinkedList, TestLibraryUint);
  await deployer.link(DoublyLinkedList, TestLibraryAddress);
  await deployer.link(DoublyLinkedList, TestLibraryBytes);
  await deployer.link(DoublyLinkedList, ExampleIndexedStorage);
  await deployer.link(DoublyLinkedList, ExampleStorage);
  await deployer.deploy(TestLibraryBytes);
  await deployer.deploy(TestLibraryAddress);
  await deployer.deploy(TestLibraryUint);
  await deployer.deploy(ExampleStorage);
  await deployer.deploy(ExampleIndexedStorage);
  await deployer.deploy(TestDoublyLinkedList);
  await ExampleIndexedStorage.at(ExampleIndexedStorage.address).initialize();
  await deployer.deploy(ExampleIndexedController, ExampleIndexedStorage.address);
  await deployer.deploy(ExampleController, ExampleStorage.address);
  await deployer.deploy(ExampleIndexedInteractive, ExampleIndexedController.address);
  return await deployer.deploy(ExampleInteractive, ExampleController.address);
  });
};
