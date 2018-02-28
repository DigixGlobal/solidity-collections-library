const { bN, exampleAddresses, emptyAddress } = require('../testHelpers');

const ExampleStorage = artifacts.require('./ExampleStorage.sol');

contract('AddressIteratorStorage', function (addresses) {
  let exampleStorage;

  beforeEach(async function () {
    exampleStorage = await ExampleStorage.new();
  });

  describe('read_first_from_addresses', function () {
    it('[collection is not empty] returns correct first item', async function () {
      assert.deepEqual(await exampleStorage.read_first_in_addresses_collection.call(), exampleAddresses[1]);
    });
    it('[collection is empty] returns empty addresses_collec', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleStorage.read_first_in_addresses_collection.call(), emptyAddress);
    });
  });

  describe('read_last_from_addresses', function () {
    it('[collection is not empty] returns correct last item', async function () {
      assert.deepEqual(await exampleStorage.read_last_in_addresses_collection.call(), exampleAddresses[6]);
    });
    it('[collection is empty] returns empty addresses_collec', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleStorage.read_first_in_addresses_collection.call(), emptyAddress);
    });
  });

  describe('read_next_from_addresses', function () {
    it('[item is not last] returns correct next item', async function () {
      assert.deepEqual(await exampleStorage.read_next_in_addresses_collection.call(exampleAddresses[4]), exampleAddresses[5]);
    });
    it('[item is last] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_next_in_addresses_collection.call(exampleAddresses[6]), emptyAddress);
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_next_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleStorage.read_next_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
  });

  describe('read_previous_from_addresses', function () {
    it('[item is not first] returns correct previous item', async function () {
      assert.deepEqual(await exampleStorage.read_previous_in_addresses_collection.call(exampleAddresses[4]), exampleAddresses[3]);
    });
    it('[item is first] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_previous_in_addresses_collection.call(exampleAddresses[1]), emptyAddress);
    });
    it('[item does not exist] returns empty address', async function () {
      assert.deepEqual(await exampleStorage.read_previous_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
    it('[collection is empty] returns empty address', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleStorage.read_previous_in_addresses_collection.call(addresses[7]), emptyAddress);
    });
  });

  describe('read_total_addresses', function () {
    it('[collection is not empty] returns correct number of items', async function () {
      assert.deepEqual(await exampleStorage.read_total_in_addresses_collection.call(), bN(6));
    });
    it('[collection is empty] returns 0', async function () {
      await exampleStorage.remove_all_data_in_addresses_collection();
      assert.deepEqual(await exampleStorage.read_total_in_addresses_collection.call(), bN(0));
    });
  });

  describe('remove_item_from_addresses', function () {
    it('[item is first]: remove address, check total, previous', async function () {
      assert.deepEqual(await exampleStorage.remove_item_from_addresses_collection.call(exampleAddresses[1]), true);
      await exampleStorage.remove_item_from_addresses_collection(exampleAddresses[1]);
      assert.deepEqual(await exampleStorage.read_total_in_addresses_collection.call(), bN(5));
      assert.deepEqual(await exampleStorage.read_first_in_addresses_collection.call(), exampleAddresses[2]);
      assert.deepEqual(await exampleStorage.read_previous_in_addresses_collection.call(exampleAddresses[2]), emptyAddress);
    });
    it('[item is last]: remove address, check total, next', async function () {
      assert.deepEqual(await exampleStorage.remove_item_from_addresses_collection.call(exampleAddresses[6]), true);
      await exampleStorage.remove_item_from_addresses_collection(exampleAddresses[6]);
      assert.deepEqual(await exampleStorage.read_total_in_addresses_collection.call(), bN(5));
      assert.deepEqual(await exampleStorage.read_last_in_addresses_collection.call(), exampleAddresses[5]);
      assert.deepEqual(await exampleStorage.read_next_in_addresses_collection.call(exampleAddresses[5]), emptyAddress);
    });
    it('[item is not first/last]: remove address, check total, next and previous of neighbours', async function () {
      assert.deepEqual(await exampleStorage.remove_item_from_addresses_collection.call(exampleAddresses[3]), true);
      await exampleStorage.remove_item_from_addresses_collection(exampleAddresses[3]);
      assert.deepEqual(await exampleStorage.read_total_in_addresses_collection.call(), bN(5));
      assert.deepEqual(await exampleStorage.read_next_in_addresses_collection.call(exampleAddresses[2]), exampleAddresses[4]);
      assert.deepEqual(await exampleStorage.read_previous_in_addresses_collection.call(exampleAddresses[4]), exampleAddresses[2]);
    });
  });
});
