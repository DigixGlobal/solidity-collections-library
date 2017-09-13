pragma solidity ^0.4.16;

import "./IndexedUintIteratorStorage.sol";

contract IndexedUintIteratorController {

  function get_first_from_indexed_uints_dll(function (bytes32) constant external returns (uint256) _function, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_collection_index);
  }

  function get_last_from_indexed_uints_dll(function (bytes32) constant external returns (uint256) _function, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_collection_index);
  }

  function get_next_from_indexed_uints_dll(function (bytes32, uint256) constant external returns (uint256) _function, bytes32 _collection_index, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_collection_index, _current_item);
  }
           
  function get_previous_from_indexed_uints_dll(function (bytes32, uint256) constant external returns (uint256) _function, bytes32 _collection_index, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_collection_index, _current_item);
  }

  function get_total_in_indexed_uints_dll(function (bytes32) constant external returns (uint256) _function, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function(_collection_index);
  }

}
