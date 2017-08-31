var LibraryDLL = artifacts.require("./LibraryDLL.sol");
var TestLibraryDLL = artifacts.require("./TestLibraryDLL.sol");
var TestLibraryUintDLL = artifacts.require("./TestLibraryUintDLL.sol");
var TestLibraryAddressDLL = artifacts.require("./TestLibraryAddressDLL.sol");
var TestLibraryBytesDLL = artifacts.require("./TestLibraryBytesDLL.sol");


module.exports = function(deployer, network, accounts) {
  deployer.deploy(LibraryDLL);
  deployer.link(LibraryDLL, TestLibraryDLL);
  deployer.link(LibraryDLL, TestLibraryUintDLL);
  deployer.link(LibraryDLL, TestLibraryAddressDLL);
  deployer.link(LibraryDLL, TestLibraryBytesDLL);
  deployer.deploy(TestLibraryBytesDLL);
  deployer.deploy(TestLibraryAddressDLL);
  deployer.deploy(TestLibraryUintDLL);
  deployer.deploy(TestLibraryDLL);
};
