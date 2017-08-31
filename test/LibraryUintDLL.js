const a = require('awaiting');

const bN = web3.toBigNumber;
// const LibraryUintDLL = artifacts.require('./LibraryUintDLL.sol');
const TestLibraryUintDLL = artifacts.require('./TestLibraryUintDLL.sol');

// web3.toAscii results in some padding \u0000 at the end,
// this function fixes this problem
// link to issue: https://github.com/ethereum/web3.js/issues/337
const myToAscii = function (input) { return web3.toAscii(input).replace(/\u0000/g, '') };

contract('LibraryUintDLL', function (addresses) {
  let testLibraryUintDLL;

  before(async function () {
    testLibraryUintDLL = await TestLibraryUintDLL.new();
  });

  describe('find', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('returns correct index if item is found', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_find.call(bN(104)), bN(4));
    });
    it('returns 0 if item is not found', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_find.call(bN(104001)), bN(0));
    });
    it('returns 0 if data is empty (no items at all)', async function () {
      await testLibraryUintDLL.setup_reset_data();
      assert.deepEqual(await testLibraryUintDLL.test_find.call(bN(104001)), bN(0));
    });
  });

  describe('get', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('returns correct item if index is valid', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_get.call(bN(6)),bN(106));
      assert.deepEqual(await testLibraryUintDLL.test_get.call(bN(4)),bN(104));
    });
    it('returns empty uint256(0) if index is already deleted', async function () {
      await testLibraryUintDLL.test_remove(bN(3));
      assert.deepEqual(await testLibraryUintDLL.test_get.call(bN(3)),bN(0));
    });
    it('returns empty uint256(0) if index is 0 (invalid)', async function() {
      assert.deepEqual(await testLibraryUintDLL.test_get.call(bN(0)),bN(0));
    });
    it('returns empty uint256(0) if index is more than last_index (invalid)', async function() {
      assert.deepEqual(await testLibraryUintDLL.test_get.call(bN(7)),bN(0));
    });
  });

  describe('append', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[item already exists]: returns false', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_append.call(bN(104)),false);
    });
    it('[item is new, collection is not empty]: last_index and count are updated correctly,', async function() {
      assert.deepEqual(await testLibraryUintDLL.test_append.call(bN(104002)),true);
      await testLibraryUintDLL.test_append(bN(104002));
      assert.deepEqual(await testLibraryUintDLL.test_check_last_index.call(),bN(7));
      assert.deepEqual(await testLibraryUintDLL.test_check_count.call(),bN(7));
    });
    it('[item is new]: item added is at last_index, items content and pointers are correct', async function() {
      await testLibraryUintDLL.setup_data_for_testing();
      await testLibraryUintDLL.test_append(bN(104003));
      //make sure we just added to index 7
      assert.deepEqual(await testLibraryUintDLL.test_get.call(bN(7)),bN(104003));
      //(last item).previous_index should be 6 now;
      assert.deepEqual(await testLibraryUintDLL.test_item_previous_index.call(bN(7)),bN(6));
      // //(last item).next_index should be 0
      assert.deepEqual(await testLibraryUintDLL.test_item_next_index.call(bN(7)),bN(0));
    });
    it('[item is new, collection is empty]: first_index, last_index and count are set to 1,', async function() {
      await testLibraryUintDLL.setup_reset_data();
      await testLibraryUintDLL.test_append(bN(104004));
      assert.deepEqual(await testLibraryUintDLL.test_check_first_index.call(),bN(1));
      assert.deepEqual(await testLibraryUintDLL.test_check_last_index.call(),bN(1));
      assert.deepEqual(await testLibraryUintDLL.test_check_count.call(),bN(1));
    });
  });

  describe('remove', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[index = 1]: removes the first item, first_index changes correctly, (new first item).previous_index = 0, count is updated, returns true', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_remove.call(bN(1)),true);
      await testLibraryUintDLL.test_remove(bN(1));
      assert.deepEqual(await testLibraryUintDLL.test_check_first_index.call(),bN(2));
      assert.deepEqual(await testLibraryUintDLL.test_item_previous_index.call(bN(2)),bN(0));
      assert.deepEqual(await testLibraryUintDLL.test_check_count.call(),bN(5));
    });
    it('[index = last_index]: removes the last item, last_index changes correctly, (new last item).next_index = 0, count is updated, returns true', async function () {
      await testLibraryUintDLL.setup_data_for_testing();
      assert.deepEqual(await testLibraryUintDLL.test_remove.call(bN(6)),true);
      await testLibraryUintDLL.test_remove(bN(6));
      assert.deepEqual(await testLibraryUintDLL.test_check_last_index.call(),bN(5));
      assert.deepEqual(await testLibraryUintDLL.test_item_next_index.call(bN(5)),bN(0));
      assert.deepEqual(await testLibraryUintDLL.test_check_count.call(),bN(5));
    });
    it('[1 < index < last_index]: removes correct item, previous_index and next_index of surrouding items are updated correctly, count is updated, returns true', async function() {
      await testLibraryUintDLL.setup_data_for_testing();
      assert.deepEqual(await testLibraryUintDLL.test_remove.call(bN(4)),true);
      await testLibraryUintDLL.test_remove(bN(4));
      assert.deepEqual(await testLibraryUintDLL.test_item_next_index.call(bN(3)),bN(5));
      assert.deepEqual(await testLibraryUintDLL.test_item_previous_index.call(bN(5)),bN(3));
      assert.deepEqual(await testLibraryUintDLL.test_check_count.call(),bN(5));
    });
    it('[index is already removed]: doesnt do anything, count is the same, returns false', async function() {
      await testLibraryUintDLL.setup_data_for_testing();
      await testLibraryUintDLL.test_remove(bN(4));
      assert.deepEqual(await testLibraryUintDLL.test_remove.call(bN(4)),false);
      await testLibraryUintDLL.test_remove(bN(4));
      assert.deepEqual(await testLibraryUintDLL.test_check_count.call(),bN(5));
    });
    it('[index=0 - invalid]: no item should be removed, count is unchanged, returns false', async function() {
      await testLibraryUintDLL.setup_data_for_testing();
      assert.deepEqual(await testLibraryUintDLL.test_remove.call(bN(0)),false);
      await testLibraryUintDLL.test_remove(bN(0));
      assert.deepEqual(await testLibraryUintDLL.test_check_count.call(),bN(6));
    });
    it('[index>last_index - invalid]: no item should be removed, count is unchanged, returns false', async function() {
      await testLibraryUintDLL.setup_data_for_testing();
      assert.deepEqual(await testLibraryUintDLL.test_remove.call(bN(7)),false);
      await testLibraryUintDLL.test_remove(bN(7));
      assert.deepEqual(await testLibraryUintDLL.test_check_count.call(),bN(6));
    });
  });

  describe('remove_item', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[item exists]: remove the item, count decrements by 1, returns true', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_remove_item.call(bN(102)),true);
      await testLibraryUintDLL.test_remove_item(bN(102));
      assert.deepEqual(await testLibraryUintDLL.test_check_count.call(),bN(5));
      assert.deepEqual(await testLibraryUintDLL.test_find.call(bN(102)), bN(0));
    });
    it('[item does not exist]: count is the same, returns false', async function () {
      await testLibraryUintDLL.setup_data_for_testing();
      assert.deepEqual(await testLibraryUintDLL.test_remove_item.call(bN(105001)),false);
      await testLibraryUintDLL.test_remove_item(bN(105001));
      assert.deepEqual(await testLibraryUintDLL.test_check_count.call(),bN(6));
    });
  });

  describe('total', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[collection is not empty]: returns correct count', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_total.call(),bN(6));
    });
    it('[collection is empty]: returns 0', async function () {
      await testLibraryUintDLL.setup_reset_data();
      assert.deepEqual(await testLibraryUintDLL.test_total.call(),bN(0));
    });
  });

  describe('start', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[collection is not empty]: returns correct first_index', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_start.call(),bN(1));
    });
    it('[collection is empty]: returns 0', async function () {
      await testLibraryUintDLL.setup_reset_data();
      assert.deepEqual(await testLibraryUintDLL.test_start.call(),bN(0));
    });
  });

  describe('start_item', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[collection is not empty]: returns correct item', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_start_item.call(),bN(101));
    });
    it('[collection is empty]: returns empty uint256(0)', async function () {
      await testLibraryUintDLL.setup_reset_data();
      assert.deepEqual(await testLibraryUintDLL.test_start_item.call(),bN(0));
    });
  });

  describe('end', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[collection is not empty]: returns correct last_index', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_end.call(),bN(6));
    });
    it('[collection is empty]: returns 0', async function () {
      await testLibraryUintDLL.setup_reset_data();
      assert.deepEqual(await testLibraryUintDLL.test_end.call(),bN(0));
    });
  });

  describe('end_item', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[collection is not empty]: returns correct item', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_end_item.call(),bN(106));
    });
    it('[collection is empty]: returns empty uint256(0)', async function () {
      await testLibraryUintDLL.setup_reset_data();
      assert.deepEqual(await testLibraryUintDLL.test_end_item.call(),bN(0));
    });
  });

  describe('valid', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[index = 0]: returns false', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_valid.call(bN(0)),false);
    });
    it('[index > last_index]: returns false', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_valid.call(bN(7)),false);
    });
    it('[0< index < last_index]: returns true', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_valid.call(bN(3)),true);
    });
  });

  describe('valid_item', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[item is in the collection]: returns true', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_valid_item.call(bN(102)),true);
    });
    it('[item is not in the collection]: returns false', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_valid_item.call(bN(107001)),false);
    });
  });

  describe('previous', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[first_index < index <= last_index]: returns correct previous index', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_previous.call(bN(4)),bN(3));
    });
    it('[index = first_index]: returns 0', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_previous.call(bN(1)),bN(0));
    });
    it('[index < first_index (invalid) ]: returns 0', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_previous.call(bN(0)),bN(0));
    });
    it('[index > last_index  (invalid) ]: returns 0', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_previous.call(bN(7)),bN(0));
    });
  });

  describe('previous_item', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[item is in the collection, not the first]: returns correct previous item', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_previous_item.call(bN(105)),bN(104));
    });
    it('[item is the first in the collection]: returns empty uint256(0)', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_previous_item.call(bN(101)),bN(0));
    });
    it('[item is not in the collection]: returns empty uint256(0)', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_previous_item.call(bN(108002)),bN(0));
    });
  });

  describe('next', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[first_index <= index < last_index]: returns correct next index', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_next.call(bN(4)),bN(5));
    });
    it('[index = last_index]: returns 0', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_next.call(bN(6)),bN(0));
    });
    it('[index < first_index (invalid) ]: returns 0', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_next.call(bN(0)),bN(0));
    });
    it('[index > last_index  (invalid) ]: returns 0', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_next.call(bN(7)),bN(0));
    });
  });

  describe('next_item', function () {
    before(async function () {
      await testLibraryUintDLL.setup_data_for_testing();
    });
    it('[item is in the collection, not the last]: returns correct next item', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_next_item.call(bN(105)),bN(106));
    });
    it('[item is the last in the collection]: returns empty uint256(0)', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_next_item.call(bN(106)),bN(0));
    });
    it('[item is not in the collection]: returns empty uint256(0)', async function () {
      assert.deepEqual(await testLibraryUintDLL.test_next_item.call(bN(110001)),bN(0));
    });
  });
  //
  // describe('test', function () {
  //   // it('throws when address is null', async function () {
  //   //   assert.ok(await a.failure(mockLibraryUintDLL.test_not_null_address.call(nullAddress)));
  //   //   // console.log("test_null_address", await mockLibraryUintDLL.test_not_null_address.call(nullAddress));
  //   // });
  //   it('test log', async function () {
  //     // const tx1 = await testLibraryUintDLL.test();
  //     console.log('result from test:');
  //     const res = await testLibraryUintDLL.test.call();
  //     for (var i=0;i<res.length;i++) console.log(res[i].toNumber());
  //
  //
  //     // const topics = web3.eth.getTransactionReceipt(tx1.tx).logs[0].data;
  //     //
  //     // const topics2 = web3.eth.getTransactionReceipt(tx1.tx).logs[0].topics;
  //     // console.log(web3.toAscii(topics));
  //     // for (var i=0;i<topics2.length;i++) console.log(web3.toAscii(topics2[i]));
  //     assert.equal(true, true);
  //   });
  // });


  //
  // describe('if_null_address', function () {
  //   it('throws when address is not null', async function () {
  //     assert.ok(await a.failure(mockLibraryUintDLL.test_if_null_address.call(addresses[0])));
  //   });
  //   it('does not throw when address is null', async function () {
  //     assert.equal(await mockLibraryUintDLL.test_if_null_address.call(nullAddress), true);
  //   });
  // });
});
