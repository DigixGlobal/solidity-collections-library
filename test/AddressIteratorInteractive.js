const a = require('awaiting');

const bN = web3.toBigNumber;
const ExampleController = artifacts.require('./ExampleController.sol');
const ExampleStorage = artifacts.require('./ExampleStorage.sol');
const ExampleInteractive = artifacts.require('./ExampleInteractive');
// web3.toAscii results in some padding \u0000 at the end,
// this function fixes this problem
// link to issue: https://github.com/ethereum/web3.js/issues/337
const myToAscii = function (input) { return web3.toAscii(input).replace(/\u0000/g, '') };

contract('AddressIteratorInteractive', function (addresses) {
  let exampleController;
  let exampleStorage;
  let exampleInteractive;

  const exampleAddresses = [
    "blah",
    "0xb1b8c0e568591f7b71f825be26087a82ddda17b2",
    "0x66ba92773feeef8cc0ddfdc8b6adc87ede1a0ec3",
    "0x9a8cf272691f844e243e7712ca6f3c0d5f6bc94b",
    "0x3c5ce67a06e4fb06022dce62737288bede746ffa",
    "0x7046f6f2125b7148cb96183d2f3ac19781a2dffc",
    "0xd2b90da1b96cbe2aa1b23172dd6d8d77903a92a8",
    "0xd2b90da1b96cbe2aa1b000000000000000000000"
  ]

  const emptyAddress = '0x0000000000000000000000000000000000000000';

  beforeEach(async function () {
    exampleStorage = await ExampleStorage.new();
    exampleController = await ExampleController.new(exampleStorage.address);
    exampleInteractive = await ExampleInteractive.new(exampleController.address);
  });

  // describe('list_adr_from_start', function () {
  //   it('[collection is not empty, 0<count<size of collection] returns correct items', async function () {
  //     const res = await exampleInteractive.list_bytes_collection_from_start(bN(6));
  //     assert.deepEqual(myToAscii(res[0]), 'test1');
  //     assert.deepEqual(myToAscii(res[1]), 'test2');
  //     assert.deepEqual(myToAscii(res[2]), 'test3');
  //     assert.deepEqual(myToAscii(res[3]), 'test4');
  //     assert.deepEqual(myToAscii(res[4]), 'test5');
  //     assert.deepEqual(myToAscii(res[5]), 'test6');
  //   });
  // });

  describe('list_addresses_from_start', function () {
    it('[collection is not empty, 0<count<=size of collection] returns correct items', async function () {
      const res = await exampleInteractive.list_addresses_collection_from_start.call(bN(6));
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
      const res = await exampleInteractive.list_addresses_collection_from_item.call(exampleAddresses[6], bN(0));
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


});
