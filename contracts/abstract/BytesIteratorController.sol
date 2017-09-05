pragma solidity ^0.4.14;

import "./BytesIteratorStorage.sol";

contract BytesIteratorController {

  function get_first_from_bytes_dll(function () returns (bytes32) _function)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function();
  }

  function get_last_from_bytes_dll(function () returns (bytes32) _function)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function();
  }

  function get_next_from_bytes_dll(function (bytes32 _current_item) returns (bytes32) _function)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_current_item);
  }
           
  function get_previous_from_bytes_dll(function (bytes32 _current_item) returns (bytes32) _function)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_current_item);
  }

  function get_total_in_bytes_dll(function () returns (uint256) _function)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function();
  }

}
