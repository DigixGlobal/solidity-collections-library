const { myToAscii, bN } = require('../../testHelpers');

const ExampleIndexedController = artifacts.require('./ExampleIndexedController.sol');
const ExampleIndexedStorage = artifacts.require('./ExampleIndexedStorage.sol');
const ExampleIndexedInteractive = artifacts.require('./ExampleIndexedInteractive');

contract('IndexedBytesIteratorInteractive', function () {
  let exampleIndexedController;
  let exampleIndexedStorage;
  let exampleIndexedInteractive;

  beforeEach(async function () {
    exampleIndexedStorage = await ExampleIndexedStorage.new();
    exampleIndexedController = await ExampleIndexedController.new(exampleIndexedStorage.address);
    exampleIndexedInteractive = await ExampleIndexedInteractive.new(exampleIndexedController.address);
  });


  describe('list_indexed_bytes (from start)', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection.call('a', bN(6), true);
      assert.deepEqual(myToAscii(res[0]), 'atest1');
      assert.deepEqual(myToAscii(res[1]), 'atest2');
      assert.deepEqual(myToAscii(res[2]), 'atest3');
      assert.deepEqual(myToAscii(res[3]), 'atest4');
      assert.deepEqual(myToAscii(res[4]), 'atest5');
      assert.deepEqual(myToAscii(res[5]), 'atest6');
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection.call('a', bN(0), true);
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection.call('a', bN(7), true);
      assert.deepEqual(myToAscii(res[0]), 'atest1');
      assert.deepEqual(myToAscii(res[1]), 'atest2');
      assert.deepEqual(myToAscii(res[2]), 'atest3');
      assert.deepEqual(myToAscii(res[3]), 'atest4');
      assert.deepEqual(myToAscii(res[4]), 'atest5');
      assert.deepEqual(myToAscii(res[5]), 'atest6');
      assert.deepEqual(res.length, 6);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection.call('a', bN(2), true);
      assert.deepEqual(res.length, 0);
    });
    it('[index does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection.call('blah', bN(2), true);
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_indexed_bytes_from (from start)', function () {
    it('[item is not the last, count <= items remaining] returns correct items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest3', bN(2), true);
      assert.deepEqual(myToAscii(res[0]), 'atest4');
      assert.deepEqual(myToAscii(res[1]), 'atest5');
      // assert.deepEqual(res[2], 'atest6');
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the last, count > items remaining] returns all items remaining', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest4', bN(3), true);
      assert.deepEqual(myToAscii(res[0]), 'atest5');
      assert.deepEqual(myToAscii(res[1]), 'atest6');
      assert.deepEqual(res.length, 2);
    });
    it('[item is the second last, count > 0] returns just the item', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest5', bN(3), true);
      assert.deepEqual(myToAscii(res[0]), 'atest6');
      assert.deepEqual(res.length, 1);
    });
    it('[item is the last, count > 0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest6', bN(3), true);
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest3', bN(0), true);
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest_new', bN(1), true);
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest5', bN(1), true);
      assert.deepEqual(res.length, 0);
    });
    it('[index does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('blah', 'atest1', bN(1), true);
      assert.deepEqual(res.length, 0);
    });
  });


  describe('list_indexed_bytes (from end)', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection.call('a', bN(6), false);
      assert.deepEqual(myToAscii(res[0]), 'atest6');
      assert.deepEqual(myToAscii(res[1]), 'atest5');
      assert.deepEqual(myToAscii(res[2]), 'atest4');
      assert.deepEqual(myToAscii(res[3]), 'atest3');
      assert.deepEqual(myToAscii(res[4]), 'atest2');
      assert.deepEqual(myToAscii(res[5]), 'atest1');
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection.call('a', bN(0), false);
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection.call('a', bN(7), false);
      assert.deepEqual(myToAscii(res[0]), 'atest6');
      assert.deepEqual(myToAscii(res[1]), 'atest5');
      assert.deepEqual(myToAscii(res[2]), 'atest4');
      assert.deepEqual(myToAscii(res[3]), 'atest3');
      assert.deepEqual(myToAscii(res[4]), 'atest2');
      assert.deepEqual(myToAscii(res[5]), 'atest1');
      assert.deepEqual(res.length, 6);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection.call('a', bN(2), false);
      assert.deepEqual(res.length, 0);
    });
    it('[index does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection.call('blah', bN(1), false);
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_indexed_bytes_from (from end)', function () {
    it('[item is not the first, count <= items remaining] returns correct items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest3', bN(2), false);
      assert.deepEqual(myToAscii(res[0]), 'atest2');
      assert.deepEqual(myToAscii(res[1]), 'atest1');
      // assert.deepEqual(res[2], 'atest6');
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the first, count > items remaining] returns all items remaining', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest4', bN(4), false);
      assert.deepEqual(myToAscii(res[0]), 'atest3');
      assert.deepEqual(myToAscii(res[1]), 'atest2');
      assert.deepEqual(myToAscii(res[2]), 'atest1');
      assert.deepEqual(res.length, 3);
    });
    it('[item is the second, count > 0] returns just the first item', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest2', bN(3), false);
      assert.deepEqual(myToAscii(res[0]), 'atest1');
      assert.deepEqual(res.length, 1);
    });
    it('[item is the first, count > 0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest1', bN(1), false);
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest3', bN(0), false);
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest_new', bN(1), false);
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_bytes_collection('a');
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('a', 'atest5', bN(1), false);
      assert.deepEqual(res.length, 0);
    });
    it('[index does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_bytes_collection_from.call('blah', 'atest5', bN(1), false);
      assert.deepEqual(res.length, 0);
    });
  });
});
