pragma solidity ^0.4.14;

import "../lib/LibraryDLL.sol";

contract AddressIteratorStorage {

  using LibraryDLL for LibraryDLL.AddressDLL;

  function read_first_from_addresses_dll(LibraryDLL.AddressDLL storage _list)
           internal
           constant
           returns (address _item)
  {
    _item = _list.start_item();
  }

  function read_last_from_addresses_dll(LibraryDLL.AddressDLL storage _list)
           internal
           constant
           returns (address _item)
  {
    _item = _list.end_item();
  }

  function read_next_from_addresses_dll(LibraryDLL.AddressDLL storage _list, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _list.next_item(_current_item);
  }

  function read_previous_from_addresses_dll(LibraryDLL.AddressDLL storage _list, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _list.previous_item(_current_item);
  }

  function read_addresses_dll_total(LibraryDLL.AddressDLL storage _list)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total();
  }

}
