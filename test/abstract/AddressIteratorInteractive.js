const { bN, exampleAddresses } = require('../testHelpers');

const ExampleController = artifacts.require('./ExampleController.sol');
const ExampleStorage = artifacts.require('./ExampleStorage.sol');
const ExampleInteractive = artifacts.require('./ExampleInteractive');

contract('AddressIteratorInteractive', function () {
  let exampleController;
  let exampleStorage;
  let exampleInteractive;

  beforeEach(async function () {
    exampleStorage = await ExampleStorage.new();
    exampleController = await ExampleController.new(exampleStorage.address);
    exampleInteractive = await ExampleInteractive.new(exampleController.address);
  });

  describe('list_addresses_from_start', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleInteractive.list_addresses_collection_from_start.call(bN(6));
      console.log(res);
      assert.deepEqual(res[0], exampleAddresses[1]);
      assert.deepEqual(res[1], exampleAddresses[2]);
      assert.deepEqual(res[2], exampleAddresses[3]);
      assert.deepEqual(res[3], exampleAddresses[4]);
      assert.deepEqual(res[4], exampleAddresses[5]);
      assert.deepEqual(res[5], exampleAddresses[6]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleInteractive.list_addresses_collection_from_start.call(bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleInteractive.list_addresses_collection_from_start.call(bN(6));
      assert.deepEqual(res[0], exampleAddresses[1]);
      assert.deepEqual(res[1], exampleAddresses[2]);
      assert.deepEqual(res[2], exampleAddresses[3]);
      assert.deepEqual(res[3], exampleAddresses[4]);
      assert.deepEqual(res[4], exampleAddresses[5]);
      assert.deepEqual(res[5], exampleAddresses[6]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      const res = await exampleInteractive.list_addresses_collection_from_start.call(bN(2));
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_addresses_from_address', function () {
    it('[item is not the last, count <= items remaining] returns correct items', async function () {
      const res = await exampleInteractive.list_addresses_collection_from_item.call(exampleAddresses[3], bN(2));
      assert.deepEqual(res[0], exampleAddresses[4]);
      assert.deepEqual(res[1], exampleAddresses[5]);
      // assert.deepEqual(res[2], exampleAddresses[6]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the last, count > items remaining] returns all items remaining', async function () {
      const res = await exampleInteractive.list_addresses_collection_from_item.call(exampleAddresses[4], bN(3));
      assert.deepEqual(res[0], exampleAddresses[5]);
      assert.deepEqual(res[1], exampleAddresses[6]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is the second last, count > 0] returns just the item', async function () {
      const res = await exampleInteractive.list_addresses_collection_from_item.call(exampleAddresses[5], bN(3));
      assert.deepEqual(res[0], exampleAddresses[6]);
      assert.deepEqual(res.length, 1);
    });
    it('[item is the last, count > 0] returns empty array', async function () {
      const res = await exampleInteractive.list_addresses_collection_from_item.call(exampleAddresses[6], bN(3));
      // assert.deepEqual(res[0], exampleAddresses[6]);
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleInteractive.list_addresses_collection_from_item.call(exampleAddresses[4], bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleInteractive.list_addresses_collection_from_item.call(exampleAddresses[7], bN(1));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      const res = await exampleInteractive.list_addresses_collection_from_item.call(exampleAddresses[5], bN(1));
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_addresses_backwards_from_end', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleInteractive.list_addresses_collection_backwards_from_end.call(bN(6));
      assert.deepEqual(res[0], exampleAddresses[6]);
      assert.deepEqual(res[1], exampleAddresses[5]);
      assert.deepEqual(res[2], exampleAddresses[4]);
      assert.deepEqual(res[3], exampleAddresses[3]);
      assert.deepEqual(res[4], exampleAddresses[2]);
      assert.deepEqual(res[5], exampleAddresses[1]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is not empty, count=0] returns empty array', async function () {
      const res = await exampleInteractive.list_addresses_collection_backwards_from_end.call(bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is not empty, count>size of collection] returns all the items', async function () {
      const res = await exampleInteractive.list_addresses_collection_backwards_from_end.call(bN(6));
      assert.deepEqual(res[0], exampleAddresses[6]);
      assert.deepEqual(res[1], exampleAddresses[5]);
      assert.deepEqual(res[2], exampleAddresses[4]);
      assert.deepEqual(res[3], exampleAddresses[3]);
      assert.deepEqual(res[4], exampleAddresses[2]);
      assert.deepEqual(res[5], exampleAddresses[1]);
      assert.deepEqual(res.length, 6);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      const res = await exampleInteractive.list_addresses_collection_backwards_from_end.call(bN(2));
      assert.deepEqual(res.length, 0);
    });
  });

  describe('list_addresses_backwards_from_address', function () {
    it('[item is not the last, count <= items remaining] returns correct items', async function () {
      const res = await exampleInteractive.list_addresses_collection_backwards_from_item.call(exampleAddresses[3], bN(2));
      assert.deepEqual(res[0], exampleAddresses[2]);
      assert.deepEqual(res[1], exampleAddresses[1]);
      // assert.deepEqual(res[2], exampleAddresses[6]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is not the first, count > items remaining] returns all items remaining', async function () {
      const res = await exampleInteractive.list_addresses_collection_backwards_from_item.call(exampleAddresses[3], bN(3));
      assert.deepEqual(res[0], exampleAddresses[2]);
      assert.deepEqual(res[1], exampleAddresses[1]);
      assert.deepEqual(res.length, 2);
    });
    it('[item is the second, count > 0] returns just the first item', async function () {
      const res = await exampleInteractive.list_addresses_collection_backwards_from_item.call(exampleAddresses[2], bN(3));
      assert.deepEqual(res[0], exampleAddresses[1]);
      assert.deepEqual(res.length, 1);
    });
    it('[item is the first, count > 0] returns empty array', async function () {
      const res = await exampleInteractive.list_addresses_collection_backwards_from_item.call(exampleAddresses[1], bN(3));
      // console.log('res = ', res);
      // assert.deepEqual(res[0], exampleAddresses[6]);
      assert.deepEqual(res.length, 0);
    });
    it('[count = 0] returns empty array', async function () {
      const res = await exampleInteractive.list_addresses_collection_backwards_from_item.call(exampleAddresses[6], bN(0));
      assert.deepEqual(res.length, 0);
    });
    it('[item does not exist] returns empty array', async function () {
      const res = await exampleInteractive.list_addresses_collection_backwards_from_item.call(exampleAddresses[7], bN(1));
      assert.deepEqual(res.length, 0);
    });
    it('[collection is empty] returns empty array', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      const res = await exampleInteractive.list_addresses_collection_backwards_from_item.call(exampleAddresses[5], bN(1));
      assert.deepEqual(res.length, 0);
    });
  });
});
