const { bN, exampleUints } = require('../testHelpers');

const ExampleStorage = artifacts.require('./ExampleStorage.sol');

contract('UintIteratorStorage', function (addresses) {
  let exampleStorage;

  beforeEach(async function () {
    exampleStorage = await ExampleStorage.new();
  });

  describe('read_first_from_uints_dll', function () {
    it('[collection is not empty] returns correct first item', async function () {
      assert.deepEqual(await exampleStorage.read_first_in_uints_collection.call(), exampleUints[1]);
    });
    it('[collection is empty] returns empty addresses_collec', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      assert.deepEqual(await exampleStorage.read_first_in_uints_collection.call(), bN(0));
    });
  });

  describe('read_last_from_uints_dll', function () {
    it('[collection is not empty] returns correct last item', async function () {
      assert.deepEqual(await exampleStorage.read_last_in_uints_collection.call(), exampleUints[6]);
    });
    it('[collection is empty] returns empty addresses_collec', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      assert.deepEqual(await exampleStorage.read_first_in_uints_collection.call(), bN(0));
    });
  });

  describe('read_next_from_uints_dll', function () {
    it('[item is not last] returns correct next item', async function () {
      assert.deepEqual(await exampleStorage.read_next_in_uints_collection.call(exampleUints[4]), exampleUints[5]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_next_in_uints_collection.call(exampleUints[6]), bN(0));
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_next_in_uints_collection.call(addresses[7]), bN(0));
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      assert.deepEqual(await exampleStorage.read_next_in_uints_collection.call(addresses[7]), bN(0));
    });
  });

  describe('read_previous_from_uints_dll', function () {
    it('[item is not first] returns correct previous item', async function () {
      assert.deepEqual(await exampleStorage.read_previous_in_uints_collection.call(exampleUints[4]), exampleUints[3]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_previous_in_uints_collection.call(exampleUints[1]), bN(0));
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_previous_in_uints_collection.call(addresses[7]), bN(0));
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      assert.deepEqual(await exampleStorage.read_previous_in_uints_collection.call(addresses[7]), bN(0));
    });
  });

  describe('read_uints_dll_total', function () {
    it('[collection is not empty] returns correct number of items', async function () {
      assert.deepEqual(await exampleStorage.read_total_in_uints_collection.call(), bN(6));
    });
    it('[collection is empty] returns 0', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      assert.deepEqual(await exampleStorage.read_total_in_uints_collection.call(), bN(0));
    });
  });
});
