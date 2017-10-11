const { bN, exampleUints } = require('../../testHelpers');

const ExampleIndexedController = artifacts.require('./ExampleIndexedController.sol');
const ExampleIndexedStorage = artifacts.require('./ExampleIndexedStorage.sol');
const ExampleIndexedInteractive = artifacts.require('./ExampleIndexedInteractive');

contract('IndexedUintIteratorInteractive', function () {
  let exampleIndexedController;
  let exampleIndexedStorage;
  let exampleIndexedInteractive;

  beforeEach(async function () {
    exampleIndexedStorage = await ExampleIndexedStorage.new();
    exampleIndexedController = await ExampleIndexedController.new(exampleIndexedStorage.address);
    exampleIndexedInteractive = await ExampleIndexedInteractive.new(exampleIndexedController.address);
  });

  describe('list_indexed_uints_from_start', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_start.call('a', bN(6));
      assert.deepEqual(res[0], exampleUints[1]);
      assert.deepEqual(res[1], exampleUints[2]);
      assert.deepEqual(res[2], exampleUints[3]);
      assert.deepEqual(res[3], exampleUints[4]);
      assert.deepEqual(res[4], exampleUints[5]);
      assert.deepEqual(res[5], exampleUints[6]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_start.call('a', bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_start.call('a', bN(6));
      assert.deepEqual(res[0], exampleUints[1]);
      assert.deepEqual(res[1], exampleUints[2]);
      assert.deepEqual(res[2], exampleUints[3]);
      assert.deepEqual(res[3], exampleUints[4]);
      assert.deepEqual(res[4], exampleUints[5]);
      assert.deepEqual(res[5], exampleUints[6]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_uints_collection('a');
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_start.call('a', bN(2));
      assert.deepEqual(res.length, 0);
    });
    it('[index does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_start.call('blah', bN(2));
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_indexed_uints_from_uint', function () {
    it('[item is not the last, count <= items remaining] returns correct items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_item.call('a', exampleUints[3], bN(2));
      assert.deepEqual(res[0], exampleUints[4]);
      assert.deepEqual(res[1], exampleUints[5]);
      // assert.deepEqual(res[2], exampleUints[6]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the last, count > items remaining] returns all items remaining', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_item.call('a', exampleUints[4], bN(3));
      assert.deepEqual(res[0], exampleUints[5]);
      assert.deepEqual(res[1], exampleUints[6]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is the second last, count > 0] returns just the item', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_item.call('a', exampleUints[5], bN(3));
      assert.deepEqual(res[0], exampleUints[6]);
      assert.deepEqual(res.length, 1);
    });
    it('[item is the last, count > 0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_item.call('a', exampleUints[6], bN(3));
      // assert.deepEqual(res[0], exampleUints[6]);
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_item.call('a', exampleUints[4], bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_item.call('a', bN(100), bN(1));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_uints_collection('a');
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_item.call('a', exampleUints[5], bN(1));
      assert.deepEqual(res.length, 0);
    });
    it('[index does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_from_item.call('blah', exampleUints[1], bN(1));
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_indexed_uints_backwards_from_end', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_end.call('a', bN(6));
      assert.deepEqual(res[0], exampleUints[6]);
      assert.deepEqual(res[1], exampleUints[5]);
      assert.deepEqual(res[2], exampleUints[4]);
      assert.deepEqual(res[3], exampleUints[3]);
      assert.deepEqual(res[4], exampleUints[2]);
      assert.deepEqual(res[5], exampleUints[1]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_end.call('a', bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_end.call('a', bN(6));
      assert.deepEqual(res[0], exampleUints[6]);
      assert.deepEqual(res[1], exampleUints[5]);
      assert.deepEqual(res[2], exampleUints[4]);
      assert.deepEqual(res[3], exampleUints[3]);
      assert.deepEqual(res[4], exampleUints[2]);
      assert.deepEqual(res[5], exampleUints[1]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_uints_collection('a');
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_end.call('a', bN(2));
      assert.deepEqual(res.length, 0);
    });
    it('[index does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_end.call('blah', bN(1));
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_indexed_uints_backwards_from_uint', function () {
    it('[item is not the last, count <= items remaining] returns correct items', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_item.call('a', exampleUints[3], bN(2));
      assert.deepEqual(res[0], exampleUints[2]);
      assert.deepEqual(res[1], exampleUints[1]);
      // assert.deepEqual(res[2], exampleUints[6]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the first, count > items remaining] returns all items remaining', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_item.call('a', exampleUints[3], bN(3));
      assert.deepEqual(res[0], exampleUints[2]);
      assert.deepEqual(res[1], exampleUints[1]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is the second, count > 0] returns just the first item', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_item.call('a', exampleUints[2], bN(3));
      assert.deepEqual(res[0], exampleUints[1]);
      assert.deepEqual(res.length, 1);
    });
    it('[item is the first, count > 0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_item.call('a', exampleUints[1], bN(3));
      // console.log('res = ', res);
      // assert.deepEqual(res[0], exampleUints[6]);
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_item.call('a', exampleUints[6], bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_item.call('a', bN(100), bN(1));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_uints_collection('a');
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_item.call('a', exampleUints[5], bN(1));
      assert.deepEqual(res.length, 0);
    });
    it('[index does not exist] returns empty array', async function () {
      const res = await exampleIndexedInteractive.list_indexed_uints_collection_backwards_from_item.call('blah', exampleUints[5], bN(1));
      assert.deepEqual(res.length, 0);
    });
  });
});
