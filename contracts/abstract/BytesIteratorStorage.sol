pragma solidity ^0.4.16;

import "../lib/LibraryDLL.sol";

contract BytesIteratorStorage {

  using LibraryDLL for LibraryDLL.BytesDLL;

  function read_first_from_bytes_dll(LibraryDLL.BytesDLL storage _list)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.start_item();
  }

  function read_last_from_bytes_dll(LibraryDLL.BytesDLL storage _list)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.end_item();
  }

  function read_next_from_bytes_dll(LibraryDLL.BytesDLL storage _list, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.next_item(_current_item);
  }

  function read_previous_from_bytes_dll(LibraryDLL.BytesDLL storage _list, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.previous_item(_current_item);
  }

  function read_bytes_dll_total(LibraryDLL.BytesDLL storage _list)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total();
  }

}
