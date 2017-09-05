const a = require('awaiting');

const bN = web3.toBigNumber;
// const LibraryAddressDLL = artifacts.require('./LibraryAddressDLL.sol');
const TestLibraryAddressDLL = artifacts.require('./TestLibraryAddressDLL.sol');

// web3.toAscii results in some padding \u0000 at the end,
// this function fixes this problem
// link to issue: https://github.com/ethereum/web3.js/issues/337
const myToAscii = function (input) { return web3.toAscii(input).replace(/\u0000/g, '') };

const testAddresses = [
  '0x817229b2d1cb37bf23b20185d59aff8595e52401',
  '0x249b1bf054d2b2643a0e38948aa92ccb6c2ccd7e',
  '0x1cd24e853af2027df542551f393b1bd0db2f1a03',
  '0x54e3872db39fc3a1fa018688bff59dd6409b0a23',
  '0x4db089d50f72996895dc4224c8c6fae0f104bc1d',
  '0x74cd5f20ee949189bdc83f7f6088063eb7fdcc86',
  '0xa1fada6e4f11770a672ca678d6290b311f53c256',
  '0xd52a101f5e10559846d58ca2a1f99689f05ddc36',
  '0xf7efab25c05198f7888ba162cd529ef6c24775ec',
  '0x9015c93a07f81d751d596c2b1f1eadb681d101ff',
  '0xee65d96c59f7e619b82c80044968441fa2294cd5',
  '0x3ff03f2a39b25a20c28eb29bb73af71d837529dd',
  '0x94a80f9361f2057583596ce21b21c3e68ebebf75',
  '0x8b70a78e11d94c6aef5f7421ce960f1092cebf06',
  '0x40ed0f182df5158a1087ecbb80261c981c36bbf7',
  '0xdb733de562cbe4d2c9352b0c308ab7e5fd1f2815',
  '0x6b0fe0e38924b303dcd6d43d8761d58b706c4527',
  '0x3d6cd190653ab276f67712366fa89b9aefb1011d',
  '0x3221c89a8c6e2c8854a8eddcbb197312657de2f2',
  '0xf903ac86e05120384dc1a447f284b9f207880e86'
];
const emptyAddress = '0x0000000000000000000000000000000000000000';

contract('LibraryAddressDLL', function (addresses) {
  let testLibraryAddressDLL;

  let resetDataBeforeTest = async function () {
    testLibraryAddressDLL = await TestLibraryAddressDLL.new();
    await testLibraryAddressDLL.setup_data_for_testing();
  }

  beforeEach(resetDataBeforeTest);

  describe('find', function () {
    beforeEach(resetDataBeforeTest);
    it('returns correct index if item is found', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_find.call(testAddresses[4]), bN(4));
    });
    it('returns 0 if item is not found', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_find.call(testAddresses[0]), bN(0));
    });
    it('returns 0 if data is empty (no items at all)', async function () {
      await testLibraryAddressDLL.setup_reset_data();
      assert.deepEqual(await testLibraryAddressDLL.test_find.call(testAddresses[0]), bN(0));
    });
  });

  describe('get', function () {
    beforeEach(resetDataBeforeTest);
    it('returns correct item if index is valid', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_get.call(bN(6)),testAddresses[6]);
      assert.deepEqual(await testLibraryAddressDLL.test_get.call(bN(4)),testAddresses[4]);
    });
    it('returns empty address(0) if index is already deleted', async function () {
      await testLibraryAddressDLL.test_remove(bN(3));
      assert.deepEqual(await testLibraryAddressDLL.test_get.call(bN(3)),emptyAddress);
    });
    it('returns empty address(0) if index is 0 (invalid)', async function() {
      assert.deepEqual(await testLibraryAddressDLL.test_get.call(bN(0)),emptyAddress);
    });
    it('returns empty address(0) if index is more than last_index (invalid)', async function() {
      assert.deepEqual(await testLibraryAddressDLL.test_get.call(bN(7)),emptyAddress);
    });
  });

  describe('append', function () {
    beforeEach(resetDataBeforeTest);
    it('[item already exists]: returns false', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_append.call(testAddresses[4]),false);
    });
    it('[item is new, collection is not empty]: last_index and count are updated correctly,', async function() {
      assert.deepEqual(await testLibraryAddressDLL.test_append.call(testAddresses[7]),true);
      await testLibraryAddressDLL.test_append(testAddresses[7]);
      assert.deepEqual(await testLibraryAddressDLL.test_check_last_index.call(),bN(7));
      assert.deepEqual(await testLibraryAddressDLL.test_check_count.call(),bN(7));
    });
    it('[item is new]: item added is at last_index, items content and pointers are correct', async function() {
      await testLibraryAddressDLL.test_append(testAddresses[8]);
      //make sure we just added to index 7
      assert.deepEqual(await testLibraryAddressDLL.test_get.call(bN(7)),testAddresses[8]);
      //(last item).previous_index should be 6 now;
      assert.deepEqual(await testLibraryAddressDLL.test_item_previous_index.call(bN(7)),bN(6));
      // //(last item).next_index should be 0
      assert.deepEqual(await testLibraryAddressDLL.test_item_next_index.call(bN(7)),bN(0));
    });
    it('[item is new, collection is empty]: first_index, last_index and count are set to 1,', async function() {
      await testLibraryAddressDLL.setup_reset_data();
      await testLibraryAddressDLL.test_append(testAddresses[9]);
      assert.deepEqual(await testLibraryAddressDLL.test_check_first_index.call(),bN(1));
      assert.deepEqual(await testLibraryAddressDLL.test_check_last_index.call(),bN(1));
      assert.deepEqual(await testLibraryAddressDLL.test_check_count.call(),bN(1));
    });
  });

  describe('remove', function () {
    beforeEach(resetDataBeforeTest);
    it('[index = 1]: removes the first item, first_index changes correctly, (new first item).previous_index = 0, count is updated, returns true', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_remove.call(bN(1)),true);
      await testLibraryAddressDLL.test_remove(bN(1));
      assert.deepEqual(await testLibraryAddressDLL.test_check_first_index.call(),bN(2));
      assert.deepEqual(await testLibraryAddressDLL.test_item_previous_index.call(bN(2)),bN(0));
      assert.deepEqual(await testLibraryAddressDLL.test_check_count.call(),bN(5));
    });
    it('[index = last_index]: removes the last item, last_index changes correctly, (new last item).next_index = 0, count is updated, returns true', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_remove.call(bN(6)),true);
      await testLibraryAddressDLL.test_remove(bN(6));
      assert.deepEqual(await testLibraryAddressDLL.test_check_last_index.call(),bN(5));
      assert.deepEqual(await testLibraryAddressDLL.test_item_next_index.call(bN(5)),bN(0));
      assert.deepEqual(await testLibraryAddressDLL.test_check_count.call(),bN(5));
    });
    it('[1 < index < last_index]: removes correct item, previous_index and next_index of surrouding items are updated correctly, count is updated, returns true', async function() {
      assert.deepEqual(await testLibraryAddressDLL.test_remove.call(bN(4)),true);
      await testLibraryAddressDLL.test_remove(bN(4));
      assert.deepEqual(await testLibraryAddressDLL.test_item_next_index.call(bN(3)),bN(5));
      assert.deepEqual(await testLibraryAddressDLL.test_item_previous_index.call(bN(5)),bN(3));
      assert.deepEqual(await testLibraryAddressDLL.test_check_count.call(),bN(5));
    });
    it('[index is already removed]: doesnt do anything, count is the same, returns false', async function() {
      await testLibraryAddressDLL.test_remove(bN(4));
      assert.deepEqual(await testLibraryAddressDLL.test_remove.call(bN(4)),false);
      await testLibraryAddressDLL.test_remove(bN(4));
      assert.deepEqual(await testLibraryAddressDLL.test_check_count.call(),bN(5));
    });
    it('[index=0 - invalid]: no item should be removed, count is unchanged, returns false', async function() {
      assert.deepEqual(await testLibraryAddressDLL.test_remove.call(bN(0)),false);
      await testLibraryAddressDLL.test_remove(bN(0));
      assert.deepEqual(await testLibraryAddressDLL.test_check_count.call(),bN(6));
    });
    it('[index>last_index - invalid]: no item should be removed, count is unchanged, returns false', async function() {
      assert.deepEqual(await testLibraryAddressDLL.test_remove.call(bN(7)),false);
      await testLibraryAddressDLL.test_remove(bN(7));
      assert.deepEqual(await testLibraryAddressDLL.test_check_count.call(),bN(6));
    });
  });

  describe('remove_item', function () {
    beforeEach(resetDataBeforeTest);
    it('[item exists]: remove the item, count decrements by 1, returns true', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_remove_item.call(testAddresses[2]),true);
      await testLibraryAddressDLL.test_remove_item(testAddresses[2]);
      assert.deepEqual(await testLibraryAddressDLL.test_check_count.call(),bN(5));
      assert.deepEqual(await testLibraryAddressDLL.test_find.call(testAddresses[2]), bN(0));
    });
    it('[item does not exist]: count is the same, returns false', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_remove_item.call(testAddresses[10]),false);
      await testLibraryAddressDLL.test_remove_item(testAddresses[10]);
      assert.deepEqual(await testLibraryAddressDLL.test_check_count.call(),bN(6));
    });
  });

  describe('total', function () {
    beforeEach(resetDataBeforeTest);
    it('[collection is not empty]: returns correct count', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_total.call(),bN(6));
    });
    it('[collection is empty]: returns 0', async function () {
      await testLibraryAddressDLL.setup_reset_data();
      assert.deepEqual(await testLibraryAddressDLL.test_total.call(),bN(0));
    });
  });

  describe('start', function () {
    beforeEach(resetDataBeforeTest);
    it('[collection is not empty]: returns correct first_index', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_start.call(),bN(1));
    });
    it('[collection is empty]: returns 0', async function () {
      await testLibraryAddressDLL.setup_reset_data();
      assert.deepEqual(await testLibraryAddressDLL.test_start.call(),bN(0));
    });
  });

  describe('start_item', function () {
    beforeEach(resetDataBeforeTest);
    it('[collection is not empty]: returns correct item', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_start_item.call(),testAddresses[1]);
    });
    it('[collection is empty]: returns empty address(0)', async function () {
      await testLibraryAddressDLL.setup_reset_data();
      assert.deepEqual(await testLibraryAddressDLL.test_start_item.call(),emptyAddress);
    });
  });

  describe('end', function () {
    beforeEach(resetDataBeforeTest);
    it('[collection is not empty]: returns correct last_index', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_end.call(),bN(6));
    });
    it('[collection is empty]: returns 0', async function () {
      await testLibraryAddressDLL.setup_reset_data();
      assert.deepEqual(await testLibraryAddressDLL.test_end.call(),bN(0));
    });
  });

  describe('end_item', function () {
    beforeEach(resetDataBeforeTest);
    it('[collection is not empty]: returns correct item', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_end_item.call(),testAddresses[6]);
    });
    it('[collection is empty]: returns empty address(0)', async function () {
      await testLibraryAddressDLL.setup_reset_data();
      assert.deepEqual(await testLibraryAddressDLL.test_end_item.call(),emptyAddress);
    });
  });

  describe('valid', function () {
    beforeEach(resetDataBeforeTest);
    it('[index = 0]: returns false', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_valid.call(bN(0)),false);
    });
    it('[index > last_index]: returns false', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_valid.call(bN(7)),false);
    });
    it('[0< index < last_index]: returns true', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_valid.call(bN(3)),true);
    });
  });

  describe('valid_item', function () {
    beforeEach(resetDataBeforeTest);
    it('[item is in the collection]: returns true', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_valid_item.call(testAddresses[2]),true);
    });
    it('[item is not in the collection]: returns false', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_valid_item.call(testAddresses[11]),false);
    });
  });

  describe('previous', function () {
    beforeEach(resetDataBeforeTest);
    it('[first_index < index <= last_index]: returns correct previous index', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_previous.call(bN(4)),bN(3));
    });
    it('[index = first_index]: returns 0', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_previous.call(bN(1)),bN(0));
    });
    it('[index < first_index (invalid) ]: returns 0', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_previous.call(bN(0)),bN(0));
    });
    it('[index > last_index  (invalid) ]: returns 0', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_previous.call(bN(7)),bN(0));
    });
  });

  describe('previous_item', function () {
    beforeEach(resetDataBeforeTest);
    it('[item is in the collection, not the first]: returns correct previous item', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_previous_item.call(testAddresses[5]),testAddresses[4]);
    });
    it('[item is the first in the collection]: returns empty address(0)', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_previous_item.call(testAddresses[1]),emptyAddress);
    });
    it('[item is not in the collection]: returns empty address(0)', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_previous_item.call(testAddresses[12]),emptyAddress);
    });
  });

  describe('next', function () {
    beforeEach(resetDataBeforeTest);
    it('[first_index <= index < last_index]: returns correct next index', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_next.call(bN(4)),bN(5));
    });
    it('[index = last_index]: returns 0', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_next.call(bN(6)),bN(0));
    });
    it('[index < first_index (invalid) ]: returns 0', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_next.call(bN(0)),bN(0));
    });
    it('[index > last_index  (invalid) ]: returns 0', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_next.call(bN(7)),bN(0));
    });
  });

  describe('next_item', function () {
    beforeEach(resetDataBeforeTest);
    it('[item is in the collection, not the last]: returns correct next item', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_next_item.call(testAddresses[5]),testAddresses[6]);
    });
    it('[item is the last in the collection]: returns empty address(0)', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_next_item.call(testAddresses[6]),emptyAddress);
    });
    it('[item is not in the collection]: returns empty address(0)', async function () {
      assert.deepEqual(await testLibraryAddressDLL.test_next_item.call(testAddresses[13]),emptyAddress);
    });
  });



  // describe('test', function () {
  //   // it('throws when address is null', async function () {
  //   //   assert.ok(await a.failure(mockLibraryAddressDLL.test_not_null_address.call(nullAddress)));
  //   //   // console.log("test_null_address", await mockLibraryAddressDLL.test_not_null_address.call(nullAddress));
  //   // });
  //   it('test log', async function () {
  //     // const tx1 = await testLibraryAddressDLL.test();
  //     console.log('result from test:');
  //     const res = await testLibraryAddressDLL.test.call();
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
  //     assert.ok(await a.failure(mockLibraryAddressDLL.test_if_null_address.call(addresses[0])));
  //   });
  //   it('does not throw when address is null', async function () {
  //     assert.equal(await mockLibraryAddressDLL.test_if_null_address.call(nullAddress), true);
  //   });
  // });
});
