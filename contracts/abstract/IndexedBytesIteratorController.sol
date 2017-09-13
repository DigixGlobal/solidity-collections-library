pragma solidity ^0.4.16;

import "./IndexedBytesIteratorStorage.sol";

contract IndexedBytesIteratorController {

  function get_first_from_indexed_bytes_dll(function (bytes32) constant external returns (bytes32) _function, bytes32 _collection_index)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_collection_index);
  }

  function get_last_from_indexed_bytes_dll(function (bytes32) constant external returns (bytes32) _function, bytes32 _collection_index)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_collection_index);
  }

  function get_next_from_indexed_bytes_dll(function (bytes32, bytes32) constant external returns (bytes32) _function, bytes32 _collection_index, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_collection_index, _current_item);
  }
           
  function get_previous_from_indexed_bytes_dll(function (bytes32, bytes32) constant external returns (bytes32) _function, bytes32 _collection_index, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_collection_index, _current_item);
  }

  function get_total_in_indexed_bytes_dll(function (bytes32) constant external returns (uint256) _function, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function(_collection_index);
  }

}
