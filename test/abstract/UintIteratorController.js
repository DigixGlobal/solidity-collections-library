const { bN, exampleUints } = require('../testHelpers');

const ExampleController = artifacts.require('./ExampleController.sol');
const ExampleStorage = artifacts.require('./ExampleStorage.sol');

contract('AddressIteratorController', function () {
  let exampleController;
  let exampleStorage;

  beforeEach(async function () {
    exampleStorage = await ExampleStorage.new();
    exampleController = await ExampleController.new(exampleStorage.address);
  });

  describe('get_first_from_uints', function () {
    it('[collection is not empty] returns correct first item', async function () {
      assert.deepEqual(await exampleController.get_first_in_uints_collection.call(), exampleUints[1]);
    });
    it('[collection is empty] returns empty uints_collec', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      assert.deepEqual(await exampleController.get_first_in_uints_collection.call(), bN(0));
    });
  });

  describe('get_last_from_uints', function () {
    it('[collection is not empty] returns correct last item', async function () {
      assert.deepEqual(await exampleController.get_last_in_uints_collection.call(), exampleUints[6]);
    });
    it('[collection is empty] returns empty uints_collec', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      assert.deepEqual(await exampleController.get_first_in_uints_collection.call(), bN(0));
    });
  });

  describe('get_next_from_uints', function () {
    it('[item is not last] returns correct next item', async function () {
      assert.deepEqual(await exampleController.get_next_in_uints_collection.call(exampleUints[4]), exampleUints[5]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleController.get_next_in_uints_collection.call(exampleUints[6]), bN(0));
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleController.get_next_in_uints_collection.call(bN(100)), bN(0));
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      assert.deepEqual(await exampleController.get_next_in_uints_collection.call(bN(100)), bN(0));
    });
  });

  describe('get_previous_from_uints', function () {
    it('[item is not first] returns correct previous item', async function () {
      assert.deepEqual(await exampleController.get_previous_in_uints_collection.call(exampleUints[4]), exampleUints[3]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleController.get_previous_in_uints_collection.call(exampleUints[1]), bN(0));
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleController.get_previous_in_uints_collection.call(bN(100)), bN(0));
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      assert.deepEqual(await exampleController.get_previous_in_uints_collection.call(bN(100)), bN(0));
    });
  });

  describe('get_total_uints', function () {
    it('[collection is not empty] returns correct number of items', async function () {
      assert.deepEqual(await exampleController.get_total_in_uints_collection.call(), bN(6));
    });
    it('[collection is empty] returns 0', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      assert.deepEqual(await exampleController.get_total_in_uints_collection.call(), bN(0));
    });
  });

  describe('remove_item_from_uints', function () {
    it('[uint is first] remove uint, check total, first and previous of first', async function () {
      assert.deepEqual(await exampleController.remove_item_from_uints_collection.call(exampleUints[1]), true);
      await exampleController.remove_item_from_uints_collection(exampleUints[1]);
      assert.deepEqual(await exampleController.get_first_in_uints_collection.call(), exampleUints[2]);
      assert.deepEqual(await exampleController.get_total_in_uints_collection.call(), bN(5));
      assert.deepEqual(await exampleController.get_previous_in_uints_collection.call(exampleUints[2]), bN(0));
    });
    it('[uint is last] remove uint, check total, last and next of last', async function () {
      assert.deepEqual(await exampleController.remove_item_from_uints_collection.call(exampleUints[6]), true);
      await exampleController.remove_item_from_uints_collection(exampleUints[6]);
      assert.deepEqual(await exampleController.get_last_in_uints_collection.call(), exampleUints[5]);
      assert.deepEqual(await exampleController.get_total_in_uints_collection.call(), bN(5));
      assert.deepEqual(await exampleController.get_next_in_uints_collection.call(exampleUints[5]), bN(0));
    });
    it('[uint is not first/last] remove uint, check total, previous and next of neighbours', async function () {
      assert.deepEqual(await exampleController.remove_item_from_uints_collection.call(exampleUints[3]), true);
      await exampleController.remove_item_from_uints_collection(exampleUints[3]);
      assert.deepEqual(await exampleController.get_total_in_uints_collection.call(), bN(5));
      assert.deepEqual(await exampleController.get_next_in_uints_collection.call(exampleUints[2]), exampleUints[4]);
      assert.deepEqual(await exampleController.get_previous_in_uints_collection.call(exampleUints[4]), exampleUints[2]);
    });
  });
});
