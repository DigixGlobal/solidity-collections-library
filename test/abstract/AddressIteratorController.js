const { bN, exampleAddresses, emptyAddress } = require('../testHelpers');

const ExampleController = artifacts.require('./ExampleController.sol');
const ExampleStorage = artifacts.require('./ExampleStorage.sol');

contract('AddressIteratorController', function (addresses) {
  let exampleController;
  let exampleStorage;

  beforeEach(async function () {
    exampleStorage = await ExampleStorage.new();
    exampleController = await ExampleController.new(exampleStorage.address);
  });

  describe('get_first_from_addresses_dll', function () {
    it('[collection is not empty] returns correct first item', async function () {
      assert.deepEqual(await exampleController.get_first_in_addresses_collection.call(), exampleAddresses[1]);
    });
    it('[collection is empty] returns empty addresses_collec', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleController.get_first_in_addresses_collection.call(), emptyAddress);
    });
  });

  describe('get_last_from_addresses_dll', function () {
    it('[collection is not empty] returns correct last item', async function () {
      assert.deepEqual(await exampleController.get_last_in_addresses_collection.call(), exampleAddresses[6]);
    });
    it('[collection is empty] returns empty addresses_collec', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleController.get_first_in_addresses_collection.call(), emptyAddress);
    });
  });

  describe('get_next_from_addresses_dll', function () {
    it('[item is not last] returns correct next item', async function () {
      assert.deepEqual(await exampleController.get_next_in_addresses_collection.call(exampleAddresses[4]), exampleAddresses[5]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleController.get_next_in_addresses_collection.call(exampleAddresses[6]), emptyAddress);
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleController.get_next_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleController.get_next_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
  });

  describe('get_previous_from_addresses_dll', function () {
    it('[item is not first] returns correct previous item', async function () {
      assert.deepEqual(await exampleController.get_previous_in_addresses_collection.call(exampleAddresses[4]), exampleAddresses[3]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleController.get_previous_in_addresses_collection.call(exampleAddresses[1]), emptyAddress);
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleController.get_previous_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleController.get_previous_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
  });

  describe('get_addresses_dll_total', function () {
    it('[collection is not empty] returns correct number of items', async function () {
      assert.deepEqual(await exampleController.get_total_in_addresses_collection.call(), bN(6));
    });
    it('[collection is empty] returns 0', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleController.get_total_in_addresses_collection.call(), bN(0));
    });
  });
});
