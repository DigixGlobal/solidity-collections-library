const { myToAscii, bN } = require('../../testHelpers');

const ExampleIndexedStorage = artifacts.require('./ExampleIndexedStorage.sol');

contract('IndexedBytesIteratorStorage', function () {
  let exampleIndexedStorage;

  beforeEach(async function () {
    exampleIndexedStorage = await ExampleIndexedStorage.new();
  });

  describe('read_first_from_indexed_bytes_dll', function () {
    it('[collection is not empty] returns correct first item', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_first_in_indexed_bytes_collection.call('a')), 'atest1');
    });
    it('[collection is empty] returns empty bytes_collection ""', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_first_in_indexed_bytes_collection.call('a')), '');
    });
    it('[index does not exist] returns empty bytes', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_first_in_indexed_bytes_collection.call('blah')), '');
    });
  });

  describe('read_last_from_indexed_bytes_dll', function () {
    it('[collection is not empty] returns correct last item', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_last_in_indexed_bytes_collection.call('a')), 'atest6');
    });
    it('[collection is empty] returns empty bytes_collection ""', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_last_in_indexed_bytes_collection.call('a')), '');
    });
    it('[index does not exist] returns empty bytes', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_last_in_indexed_bytes_collection.call('blah')), '');
    });
  });

  describe('read_next_from_indexed_bytes_dll', function () {
    it('[item is not last] returns correct next item', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_next_in_indexed_bytes_collection.call('a', 'atest4')), 'atest5');
    });
    it('[item is last] returns empty bytes32 ""', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_next_in_indexed_bytes_collection.call('a', 'atest6')), '');
    });
    it('[item does not exist] returns empty bytes32 ""', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_next_in_indexed_bytes_collection.call('a', 'atest_new')), '');
    });
    it('[collection is empty] returns empty bytes32 ""', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_next_in_indexed_bytes_collection.call('a', 'atest_new')), '');
    });
    it('[index does not exist] returns empty bytes', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_next_in_indexed_bytes_collection.call('blah', 'atest1')), '');
    });
  });

  describe('read_previous_from_indexed_bytes_dll', function () {
    it('[item is not first] returns correct previous item', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_previous_in_indexed_bytes_collection.call('a', 'atest4')), 'atest3');
    });
    it('[item is last] returns empty bytes32 ""', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_previous_in_indexed_bytes_collection.call('a', 'atest1')), '');
    });
    it('[item does not exist] returns empty bytes32 ""', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_previous_in_indexed_bytes_collection.call('a', 'atest_new')), '');
    });
    it('[collection is empty] returns empty bytes32 ""', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_previous_in_indexed_bytes_collection.call('a', 'atest_new')), '');
    });
    it('[index does not exist] returns empty bytes', async function () {
      assert.deepEqual(myToAscii(await exampleIndexedStorage.read_previous_in_indexed_bytes_collection.call('blah', 'atest1')), '');
    });
  });

  describe('read_indexed_bytes_dll_total', function () {
    it('[collection is not empty] returns correct number of items', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_total_in_indexed_bytes_collection.call('a'), bN(6));
    });
    it('[collection is empty] returns 0', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      assert.deepEqual(await exampleIndexedStorage.read_total_in_indexed_bytes_collection.call('a'), bN(0));
    });
    it('[index does not exist] returns 0', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_total_in_indexed_bytes_collection.call('blah'), bN(0));
    });
  });
});
