const { bN, exampleAddresses, emptyAddress } = require('../../testHelpers');

const ExampleIndexedStorage = artifacts.require('./ExampleIndexedStorage.sol');

contract('IndexedAddressIteratorStorage', function (addresses) {
  let exampleIndexedStorage;

  beforeEach(async function () {
    exampleIndexedStorage = await ExampleIndexedStorage.new();
  });

  describe('read_first_from_indexed_addresses', function () {
    it('[collection is not empty] returns correct first item', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_first_in_indexed_addresses_collection.call('a'), exampleAddresses[1]);
    });
    it('[collection is empty] returns empty addresses', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_addresses_collection('a');
      assert.deepEqual(await exampleIndexedStorage.read_first_in_indexed_addresses_collection.call('a'), emptyAddress);
    });
    it('[index does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_first_in_indexed_addresses_collection.call('blah'), emptyAddress);
    });
  });

  describe('read_last_from_indexed_addresses', function () {
    it('[collection is not empty] returns correct last item', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_last_in_indexed_addresses_collection.call('a'), exampleAddresses[6]);
    });
    it('[collection is empty] returns empty addresses', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_addresses_collection('a');
      assert.deepEqual(await exampleIndexedStorage.read_last_in_indexed_addresses_collection.call('a'), emptyAddress);
    });
    it('[index does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_last_in_indexed_addresses_collection.call('blah'), emptyAddress);
    });
  });

  describe('read_next_from_indexed_addresses', function () {
    it('[item is not last] returns correct next item', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_next_in_indexed_addresses_collection.call('a', exampleAddresses[4]), exampleAddresses[5]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_next_in_indexed_addresses_collection.call('a', exampleAddresses[6]), emptyAddress);
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_next_in_indexed_addresses_collection.call('a', addresses[7]), emptyAddress);
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_addresses_collection('a');
      assert.deepEqual(await exampleIndexedStorage.read_next_in_indexed_addresses_collection.call('a', addresses[7]), emptyAddress);
    });
    it('[index does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_next_in_indexed_addresses_collection.call('blah', exampleAddresses[1]), emptyAddress);
    });
  });

  describe('read_previous_from_indexed_addresses', function () {
    it('[item is not first] returns correct previous item', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_previous_in_indexed_addresses_collection.call('a', exampleAddresses[4]), exampleAddresses[3]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_previous_in_indexed_addresses_collection.call('a', exampleAddresses[1]), emptyAddress);
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_previous_in_indexed_addresses_collection.call('a', addresses[7]), emptyAddress);
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_addresses_collection('a');
      assert.deepEqual(await exampleIndexedStorage.read_previous_in_indexed_addresses_collection.call('a', addresses[7]), emptyAddress);
    });
    it('[index does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_previous_in_indexed_addresses_collection.call('blah', exampleAddresses[1]), emptyAddress);
    });
  });

  describe('read_total_indexed_addresses', function () {
    it('[collection is not empty] returns correct number of items', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_total_in_indexed_addresses_collection.call('a'), bN(6));
    });
    it('[collection is empty] returns 0', async function () {
      await exampleIndexedStorage.remove_all_data_in_indexed_addresses_collection('a');
      assert.deepEqual(await exampleIndexedStorage.read_total_in_indexed_addresses_collection.call('a'), bN(0));
    });
    it('[index does not exist] returns 0', async function () {
      assert.deepEqual(await exampleIndexedStorage.read_total_in_indexed_addresses_collection.call('blah'), bN(0));
    });
  });
});
