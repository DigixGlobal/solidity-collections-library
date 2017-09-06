const a = require('awaiting');

const bN = web3.toBigNumber;
const ExampleStorage = artifacts.require('./ExampleStorage.sol');

// web3.toAscii results in some padding \u0000 at the end,
// this function fixes this problem
// link to issue: https://github.com/ethereum/web3.js/issues/337
const myToAscii = function (input) { return web3.toAscii(input).replace(/\u0000/g, '') };

contract('AddressIteratorStorage', function (addresses) {
  let exampleStorage;

  const exampleAddresses = [
    "blah",
    "0xb1b8c0e568591f7b71f825be26087a82ddda17b2",
    "0x66ba92773feeef8cc0ddfdc8b6adc87ede1a0ec3",
    "0x9a8cf272691f844e243e7712ca6f3c0d5f6bc94b",
    "0x3c5ce67a06e4fb06022dce62737288bede746ffa",
    "0x7046f6f2125b7148cb96183d2f3ac19781a2dffc",
    "0xd2b90da1b96cbe2aa1b23172dd6d8d77903a92a8",
    "0xd2b90da1b96cbe2aa1b000000000000000000000"
  ]

  const emptyAddress = '0x0000000000000000000000000000000000000000';

  beforeEach(async function () {
    exampleStorage = await ExampleStorage.new();
  });

  describe('read_first_from_addresses_dll', function () {
    it('[collection is not empty] returns correct first item', async function () {
      assert.deepEqual(await exampleStorage.read_first_in_addresses_collection.call(), exampleAddresses[1]);
    });
    it('[collection is empty] returns empty addresses_collec', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleStorage.read_first_in_addresses_collection.call(), emptyAddress);
    });
  });

  describe('read_last_from_addresses_dll', function () {
    it('[collection is not empty] returns correct last item', async function () {
      assert.deepEqual(await exampleStorage.read_last_in_addresses_collection.call(), exampleAddresses[6]);
    });
    it('[collection is empty] returns empty addresses_collec', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleStorage.read_first_in_addresses_collection.call(), emptyAddress);
    });
  });

  describe('read_next_from_addresses_dll', function () {
    it('[item is not last] returns correct next item', async function () {
      assert.deepEqual(await exampleStorage.read_next_in_addresses_collection.call(exampleAddresses[4]), exampleAddresses[5]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_next_in_addresses_collection.call(exampleAddresses[6]), emptyAddress);
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_next_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleStorage.read_next_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
  });

  describe('read_previous_from_addresses_dll', function () {
    it('[item is not first] returns correct previous item', async function () {
      assert.deepEqual(await exampleStorage.read_previous_in_addresses_collection.call(exampleAddresses[4]), exampleAddresses[3]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_previous_in_addresses_collection.call(exampleAddresses[1]), emptyAddress);
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_previous_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleStorage.read_previous_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
  });

  describe('read_addresses_dll_total', function () {
    it('[collection is not empty] returns correct number of items', async function () {
      assert.deepEqual(await exampleStorage.read_total_in_addresses_collection.call(), bN(6));
    });
    it('[collection is empty] returns 0', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleStorage.read_total_in_addresses_collection.call(), bN(0));
    });
  });
});
