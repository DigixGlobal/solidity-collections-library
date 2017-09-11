pragma solidity ^0.4.16;

import "./AddressIteratorStorage.sol";

contract AddressIteratorController {

  function get_first_from_addresses_dll(function () constant external returns (address) _function)
           internal
           constant
           returns (address _item)
  {
    _item = _function();
  }

  function get_last_from_addresses_dll(function () constant external returns (address) _function)
           internal
           constant
           returns (address _item)
  {
    _item = _function();
  }

  function get_next_from_addresses_dll(function (address) constant external returns (address) _function, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _function(_current_item);
  }
           
  function get_previous_from_addresses_dll(function (address) constant external returns (address) _function, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _function(_current_item);
  }

  function get_total_in_addresses_dll(function () constant external returns (uint256) _function)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function();
  }

}
