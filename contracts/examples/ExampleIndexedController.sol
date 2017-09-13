pragma solidity ^0.4.16;

import "../abstract/IndexedBytesIteratorController.sol";
import "../abstract/IndexedAddressIteratorController.sol";
import "../abstract/IndexedUintIteratorController.sol";
import "./ExampleIndexedStorage.sol";

contract ExampleIndexedController is IndexedBytesIteratorController, IndexedAddressIteratorController, IndexedUintIteratorController {

  address public storage_contract;

  function ExampleIndexedController(address _storage) {
    storage_contract = _storage;
  }

  function example_storage()
           internal
           constant
           returns (ExampleIndexedStorage _contract)
  {
    _contract = ExampleIndexedStorage(storage_contract);
  }

  function get_first_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_first_from_indexed_bytes_dll(example_storage().read_first_in_indexed_bytes_collection, _collection_index);
  }

  function get_last_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_last_from_indexed_bytes_dll(example_storage().read_last_in_indexed_bytes_collection, _collection_index);
  }

  function get_next_in_indexed_bytes_collection(bytes32 _collection_index, bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_next_from_indexed_bytes_dll(example_storage().read_next_in_indexed_bytes_collection, _collection_index, _current_item);
  }

  function get_previous_in_indexed_bytes_collection(bytes32 _collection_index, bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_previous_from_indexed_bytes_dll(example_storage().read_previous_in_indexed_bytes_collection, _collection_index, _current_item);
  }

  function get_total_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = get_total_in_indexed_bytes_dll(example_storage().read_total_in_indexed_bytes_collection, _collection_index);
  }

  function get_first_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (address _item)
  {
    _item = get_first_from_indexed_addresses_dll(example_storage().read_first_in_indexed_addresses_collection, _collection_index);
  }

  function get_last_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (address _item)
  {
    _item = get_last_from_indexed_addresses_dll(example_storage().read_last_in_indexed_addresses_collection, _collection_index);
  }

  function get_next_in_indexed_addresses_collection(bytes32 _collection_index, address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = get_next_from_indexed_addresses_dll(example_storage().read_next_in_indexed_addresses_collection, _collection_index, _current_item);
  }

  function get_previous_in_indexed_addresses_collection(bytes32 _collection_index, address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = get_previous_from_indexed_addresses_dll(example_storage().read_previous_in_indexed_addresses_collection, _collection_index, _current_item);
  }

  function get_total_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = get_total_in_indexed_addresses_dll(example_storage().read_total_in_indexed_addresses_collection, _collection_index);
  }
}
