pragma solidity ^0.4.16;

import "./UintIteratorStorage.sol";

contract UintIteratorController {

  function get_first_from_uints_dll(function () constant external returns (uint256) _function)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function();
  }

  function get_last_from_uints_dll(function () constant external returns (uint256) _function)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function();
  }

  function get_next_from_uints_dll(function (uint256) constant external returns (uint256) _function, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_current_item);
  }
           
  function get_previous_from_uints_dll(function (uint256) constant external returns (uint256) _function, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_current_item);
  }

  function get_total_in_uints_dll(function () constant external returns (uint256) _function)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function();
  }

}
