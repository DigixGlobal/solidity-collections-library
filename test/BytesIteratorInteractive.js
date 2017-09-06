const a = require('awaiting');

const bN = web3.toBigNumber;
const ExampleController = artifacts.require('./ExampleController.sol');
const ExampleStorage = artifacts.require('./ExampleStorage.sol');
const ExampleInteractive = artifacts.require('./ExampleInteractive');
// web3.toAscii results in some padding \u0000 at the end,
// this function fixes this problem
// link to issue: https://github.com/ethereum/web3.js/issues/337
const myToAscii = function (input) { return web3.toAscii(input).replace(/\u0000/g, '') };

contract('ByteIteratorInteractive', function () {
  let exampleController;
  let exampleStorage;
  let exampleInteractive;

  beforeEach(async function () {
    exampleStorage = await ExampleStorage.new();
    exampleController = await ExampleController.new(exampleStorage.address);
    exampleInteractive = await ExampleInteractive.new(exampleController.address);
  });


  describe('list_bytes_from_start', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleInteractive.list_bytes_collection_from_start.call(bN(6));
      assert.deepEqual(myToAscii(res[0]), 'test1');
      assert.deepEqual(myToAscii(res[1]), 'test2');
      assert.deepEqual(myToAscii(res[2]), 'test3');
      assert.deepEqual(myToAscii(res[3]), 'test4');
      assert.deepEqual(myToAscii(res[4]), 'test5');
      assert.deepEqual(myToAscii(res[5]), 'test6');
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection_from_start.call(bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleInteractive.list_bytes_collection_from_start.call(bN(6));
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
      const res = await exampleInteractive.list_bytes_collection_from_start.call(bN(2));
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_bytes_from_address', function () {
    it('[item is not the last, count <= items remaining] returns correct items', async function () {
      const res = await exampleInteractive.list_bytes_collection_from_item.call('test3', bN(2));
      assert.deepEqual(myToAscii(res[0]), 'test4');
      assert.deepEqual(myToAscii(res[1]), 'test5');
      // assert.deepEqual(res[2], 'test6');
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the last, count > items remaining] returns all items remaining', async function () {
      const res = await exampleInteractive.list_bytes_collection_from_item.call('test4', bN(3));
      assert.deepEqual(myToAscii(res[0]), 'test5');
      assert.deepEqual(myToAscii(res[1]), 'test6');
      assert.deepEqual(res.length, 2);
    });
    it('[item is the second last, count > 0] returns just the item', async function () {
      const res = await exampleInteractive.list_bytes_collection_from_item.call('test5', bN(3));
      assert.deepEqual(myToAscii(res[0]), 'test6');
      assert.deepEqual(res.length, 1);
    });
    it('[item is the last, count > 0] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection_from_item.call('test6', bN(3));
      // assert.deepEqual(res[0], 'test6');
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection_from_item.call('test6', bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleInteractive.list_bytes_collection_from_item.call('test_new', bN(1));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_bytes_collection();
      const res = await exampleInteractive.list_bytes_collection_from_item.call('test5', bN(1));
      assert.deepEqual(res.length, 0);
    });
  });


});
