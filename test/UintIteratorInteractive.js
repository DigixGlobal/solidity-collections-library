const { bN, exampleUints } = require('./testHelpers');

const ExampleController = artifacts.require('./ExampleController.sol');
const ExampleStorage = artifacts.require('./ExampleStorage.sol');
const ExampleInteractive = artifacts.require('./ExampleInteractive');

contract('UintIteratorInteractive', function () {
  let exampleController;
  let exampleStorage;
  let exampleInteractive;

  beforeEach(async function () {
    exampleStorage = await ExampleStorage.new();
    exampleController = await ExampleController.new(exampleStorage.address);
    exampleInteractive = await ExampleInteractive.new(exampleController.address);
  });

  describe('list_uints_from_start', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleInteractive.list_uints_collection_from_start.call(bN(6));
      assert.deepEqual(res[0], exampleUints[1]);
      assert.deepEqual(res[1], exampleUints[2]);
      assert.deepEqual(res[2], exampleUints[3]);
      assert.deepEqual(res[3], exampleUints[4]);
      assert.deepEqual(res[4], exampleUints[5]);
      assert.deepEqual(res[5], exampleUints[6]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleInteractive.list_uints_collection_from_start.call(bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleInteractive.list_uints_collection_from_start.call(bN(6));
      assert.deepEqual(res[0], exampleUints[1]);
      assert.deepEqual(res[1], exampleUints[2]);
      assert.deepEqual(res[2], exampleUints[3]);
      assert.deepEqual(res[3], exampleUints[4]);
      assert.deepEqual(res[4], exampleUints[5]);
      assert.deepEqual(res[5], exampleUints[6]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      const res = await exampleInteractive.list_uints_collection_from_start.call(bN(2));
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_uints_from_uint', function () {
    it('[item is not the last, count <= items remaining] returns correct items', async function () {
      const res = await exampleInteractive.list_uints_collection_from_item.call(exampleUints[3], bN(2));
      assert.deepEqual(res[0], exampleUints[4]);
      assert.deepEqual(res[1], exampleUints[5]);
      // assert.deepEqual(res[2], exampleUints[6]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the last, count > items remaining] returns all items remaining', async function () {
      const res = await exampleInteractive.list_uints_collection_from_item.call(exampleUints[4], bN(3));
      assert.deepEqual(res[0], exampleUints[5]);
      assert.deepEqual(res[1], exampleUints[6]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is the second last, count > 0] returns just the item', async function () {
      const res = await exampleInteractive.list_uints_collection_from_item.call(exampleUints[5], bN(3));
      assert.deepEqual(res[0], exampleUints[6]);
      assert.deepEqual(res.length, 1);
    });
    it('[item is the last, count > 0] returns empty array', async function () {
      const res = await exampleInteractive.list_uints_collection_from_item.call(exampleUints[6], bN(3));
      // assert.deepEqual(res[0], exampleUints[6]);
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleInteractive.list_uints_collection_from_item.call(exampleUints[4], bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleInteractive.list_uints_collection_from_item.call(bN(100), bN(1));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      const res = await exampleInteractive.list_uints_collection_from_item.call(exampleUints[5], bN(1));
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_uints_backwards_from_end', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleInteractive.list_uints_collection_backwards_from_end.call(bN(6));
      assert.deepEqual(res[0], exampleUints[6]);
      assert.deepEqual(res[1], exampleUints[5]);
      assert.deepEqual(res[2], exampleUints[4]);
      assert.deepEqual(res[3], exampleUints[3]);
      assert.deepEqual(res[4], exampleUints[2]);
      assert.deepEqual(res[5], exampleUints[1]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleInteractive.list_uints_collection_backwards_from_end.call(bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleInteractive.list_uints_collection_backwards_from_end.call(bN(6));
      assert.deepEqual(res[0], exampleUints[6]);
      assert.deepEqual(res[1], exampleUints[5]);
      assert.deepEqual(res[2], exampleUints[4]);
      assert.deepEqual(res[3], exampleUints[3]);
      assert.deepEqual(res[4], exampleUints[2]);
      assert.deepEqual(res[5], exampleUints[1]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      const res = await exampleInteractive.list_uints_collection_backwards_from_end.call(bN(2));
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_uints_backwards_from_uint', function () {
    it('[item is not the last, count <= items remaining] returns correct items', async function () {
      const res = await exampleInteractive.list_uints_collection_backwards_from_item.call(exampleUints[3], bN(2));
      assert.deepEqual(res[0], exampleUints[2]);
      assert.deepEqual(res[1], exampleUints[1]);
      // assert.deepEqual(res[2], exampleUints[6]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the first, count > items remaining] returns all items remaining', async function () {
      const res = await exampleInteractive.list_uints_collection_backwards_from_item.call(exampleUints[3], bN(3));
      assert.deepEqual(res[0], exampleUints[2]);
      assert.deepEqual(res[1], exampleUints[1]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is the second, count > 0] returns just the first item', async function () {
      const res = await exampleInteractive.list_uints_collection_backwards_from_item.call(exampleUints[2], bN(3));
      assert.deepEqual(res[0], exampleUints[1]);
      assert.deepEqual(res.length, 1);
    });
    it('[item is the first, count > 0] returns empty array', async function () {
      const res = await exampleInteractive.list_uints_collection_backwards_from_item.call(exampleUints[1], bN(3));
      // console.log('res = ', res);
      // assert.deepEqual(res[0], exampleUints[6]);
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleInteractive.list_uints_collection_backwards_from_item.call(exampleUints[6], bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleInteractive.list_uints_collection_backwards_from_item.call(bN(100), bN(1));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_uints_collection();
      const res = await exampleInteractive.list_uints_collection_backwards_from_item.call(exampleUints[5], bN(1));
      assert.deepEqual(res.length, 0);
    });
  });
});
