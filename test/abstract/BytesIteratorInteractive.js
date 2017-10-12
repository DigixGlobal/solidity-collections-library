const { myToAscii, bN } = require('../testHelpers');

const ExampleController = artifacts.require('./ExampleController.sol');
const ExampleStorage = artifacts.require('./ExampleStorage.sol');
const ExampleInteractive = artifacts.require('./ExampleInteractive');

contract('ByteIteratorInteractive', function () {
  let exampleController;
  let exampleStorage;
  let exampleInteractive;

  beforeEach(async function () {
    exampleStorage = await ExampleStorage.new();
    exampleController = await ExampleController.new(exampleStorage.address);
    exampleInteractive = await ExampleInteractive.new(exampleController.address);
  });


  describe('list_bytesarray (from start)', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleInteractive.list_bytes_collection.call(bN(6), true);
      assert.deepEqual(myToAscii(res[0]), 'test1');
      assert.deepEqual(myToAscii(res[1]), 'test2');
      assert.deepEqual(myToAscii(res[2]), 'test3');
      assert.deepEqual(myToAscii(res[3]), 'test4');
      assert.deepEqual(myToAscii(res[4]), 'test5');
      assert.deepEqual(myToAscii(res[5]), 'test6');
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection.call(bN(0), true);
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleInteractive.list_bytes_collection.call(bN(7), true);
      assert.deepEqual(myToAscii(res[0]), 'test1');
      assert.deepEqual(myToAscii(res[1]), 'test2');
      assert.deepEqual(myToAscii(res[2]), 'test3');
      assert.deepEqual(myToAscii(res[3]), 'test4');
      assert.deepEqual(myToAscii(res[4]), 'test5');
      assert.deepEqual(myToAscii(res[5]), 'test6');
      assert.deepEqual(res.length, 6);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_bytes_collection();
      const res = await exampleInteractive.list_bytes_collection.call(bN(2), true);
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_bytesarray_from (from start)', function () {
    it('[item is not the last, count <= items remaining] returns correct items', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test3', bN(2), true);
      assert.deepEqual(myToAscii(res[0]), 'test4');
      assert.deepEqual(myToAscii(res[1]), 'test5');
      // assert.deepEqual(res[2], 'test6');
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the last, count > items remaining] returns all items remaining', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test4', bN(3), true);
      assert.deepEqual(myToAscii(res[0]), 'test5');
      assert.deepEqual(myToAscii(res[1]), 'test6');
      assert.deepEqual(res.length, 2);
    });
    it('[item is the second last, count > 0] returns just the item', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test5', bN(3), true);
      assert.deepEqual(myToAscii(res[0]), 'test6');
      assert.deepEqual(res.length, 1);
    });
    it('[item is the last, count > 0] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test6', bN(3), true);
      // assert.deepEqual(res[0], 'test6');
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test3', bN(0), true);
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test_new', bN(1), true);
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_bytes_collection();
      const res = await exampleInteractive.list_bytes_collection_from.call('test5', bN(1), true);
      assert.deepEqual(res.length, 0);
    });
  });


  describe('list_bytesarray (from end)', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleInteractive.list_bytes_collection.call(bN(6), false);
      assert.deepEqual(myToAscii(res[0]), 'test6');
      assert.deepEqual(myToAscii(res[1]), 'test5');
      assert.deepEqual(myToAscii(res[2]), 'test4');
      assert.deepEqual(myToAscii(res[3]), 'test3');
      assert.deepEqual(myToAscii(res[4]), 'test2');
      assert.deepEqual(myToAscii(res[5]), 'test1');
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection.call(bN(0), false);
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleInteractive.list_bytes_collection.call(bN(7), false);
      assert.deepEqual(myToAscii(res[0]), 'test6');
      assert.deepEqual(myToAscii(res[1]), 'test5');
      assert.deepEqual(myToAscii(res[2]), 'test4');
      assert.deepEqual(myToAscii(res[3]), 'test3');
      assert.deepEqual(myToAscii(res[4]), 'test2');
      assert.deepEqual(myToAscii(res[5]), 'test1');
      assert.deepEqual(res.length, 6);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_bytes_collection();
      const res = await exampleInteractive.list_bytes_collection.call(bN(2), false);
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_bytesarray_from (from end)', function () {
    it('[item is not the first, count <= items remaining] returns correct items', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test3', bN(2), false);
      assert.deepEqual(myToAscii(res[0]), 'test2');
      assert.deepEqual(myToAscii(res[1]), 'test1');
      // assert.deepEqual(res[2], 'test6');
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the first, count > items remaining] returns all items remaining', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test4', bN(4), false);
      assert.deepEqual(myToAscii(res[0]), 'test3');
      assert.deepEqual(myToAscii(res[1]), 'test2');
      assert.deepEqual(myToAscii(res[2]), 'test1');
      assert.deepEqual(res.length, 3);
    });
    it('[item is the second, count > 0] returns just the first item', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test2', bN(3), false);
      assert.deepEqual(myToAscii(res[0]), 'test1');
      assert.deepEqual(res.length, 1);
    });
    it('[item is the first, count > 0] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test1', bN(1), false);
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test3', bN(0), false);
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection_from.call('test_new', bN(1), false);
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_bytes_collection();
      const res = await exampleInteractive.list_bytes_collection_from.call('test5', bN(1), false);
      assert.deepEqual(res.length, 0);
    });
  });
});
