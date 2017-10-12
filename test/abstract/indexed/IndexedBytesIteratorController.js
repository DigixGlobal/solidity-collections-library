const { myToAscii, bN } = require('../../testHelpers');

const ExampleIndexedController = artifacts.require('./ExampleIndexedController.sol');
const ExampleIndexedStorage = artifacts.require('./ExampleIndexedStorage.sol');

contract('IndexedBytesIteratorController', function () {
  let exampleIndexedController;
  let exampleIndexedStorage;

  beforeEach(async function () {
    exampleIndexedStorage = await ExampleIndexedStorage.new();
    exampleIndexedController = await ExampleIndexedController.new(exampleIndexedStorage.address);
  });

  describe('get_first_from_indexed_bytesarray', function () {
    it('[collection is not empty] returns correct first item', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_first_in_indexed_bytes_collection.call('a')), 'atest1');
    });
    it('[collection is empty] returns empty bytes_collection ""', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      assert.deepEqual(myToAscii(await exampleIndexedController.get_first_in_indexed_bytes_collection.call('a')), '');
    });
    it('[index does not exist] returns empty bytes', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_first_in_indexed_bytes_collection.call('blah')), '');
    });
  });

  describe('get_last_from_indexed_bytesarray', function () {
    it('[collection is not empty] returns correct last item', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_last_in_indexed_bytes_collection.call('a')), 'atest6');
    });
    it('[collection is empty] returns empty bytes_collection ""', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      assert.deepEqual(myToAscii(await exampleIndexedController.get_last_in_indexed_bytes_collection.call('a')), '');
    });
    it('[index does not exist] returns empty bytes', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_last_in_indexed_bytes_collection.call('blah')), '');
    });
  });

  describe('get_next_from_indexed_bytesarray', function () {
    it('[item is not last] returns correct next item', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_next_in_indexed_bytes_collection.call('a', 'atest4')), 'atest5');
    });
    it('[item is last] returns empty bytes32 ""', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_next_in_indexed_bytes_collection.call('a', 'atest6')), '');
    });
    it('[item does not exist] returns empty bytes32 ""', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_next_in_indexed_bytes_collection.call('a', 'atest_new')), '');
    });
    it('[collection is empty] returns empty bytes32 ""', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      assert.deepEqual(myToAscii(await exampleIndexedController.get_next_in_indexed_bytes_collection.call('a', 'atest_new')), '');
    });
    it('[index does not exist] returns empty bytes', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_next_in_indexed_bytes_collection.call('blah', 'atest1')), '');
    });
  });

  describe('get_previous_from_indexed_bytesarray', function () {
    it('[item is not first] returns correct previous item', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_previous_in_indexed_bytes_collection.call('a', 'atest4')), 'atest3');
    });
    it('[item is last] returns empty bytes32 ""', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_previous_in_indexed_bytes_collection.call('a', 'atest1')), '');
    });
    it('[item does not exist] returns empty bytes32 ""', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_previous_in_indexed_bytes_collection.call('a', 'atest_new')), '');
    });
    it('[collection is empty] returns empty bytes32 ""', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      assert.deepEqual(myToAscii(await exampleIndexedController.get_previous_in_indexed_bytes_collection.call('a', 'atest_new')), '');
    });
    it('[index does not exist] returns empty bytes', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedController.get_previous_in_indexed_bytes_collection.call('blah', 'atest1')), '');
    });
  });

  describe('get_total_indexed_bytesarray', function () {
    it('[collection is not empty] returns correct number of items', async function () {
      assert.deepEqual(await exampleIndexedController.get_total_in_indexed_bytes_collection.call('a'), bN(6));
    });
    it('[collection is empty] returns 0', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      assert.deepEqual(await exampleIndexedController.get_total_in_indexed_bytes_collection.call('a'), bN(0));
    });
    it('[index does not exist] returns empty bytes', async function () {
      assert.deepEqual(await exampleIndexedController.get_total_in_indexed_bytes_collection.call('blah'), bN(0));
    });
  });
});
