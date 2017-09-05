pragma solidity ^0.4.14;

import "../abstract/BytesIteratorController.sol";
import "./ExampleStorage.sol";

contract ExampleController is BytesIteratorController {

  address public storage_contract;

  function ExampleController(address _storage) {
    storage_contract = _storage;
  }

  function example_storage() 
           internal
           constant
           returns (ExampleStorage _contract)
  {
    _contract = ExampleStorage(storage_contract);
  }

  function get_first_in_collection()
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_first_from_bytes_dll(example_storage().read_first_in_collection);
  }

  function get_last_in_collection()
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_last_from_bytes_dll(example_storage().read_last_in_collection);
  }

  function get_next_in_collection(bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_next_from_bytes_dll(example_storage().read_next_in_collection, _current_item);
  }

  function get_previous_in_collection(bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_previous_from_bytes_dll(example_storage().read_previous_in_collection, _current_item);
  }

  function get_total_in_collection()
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = get_total_in_bytes_dll(example_storage().read_total_in_collection);
  }
          
}
