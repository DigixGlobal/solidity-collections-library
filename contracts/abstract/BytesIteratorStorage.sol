pragma solidity ^0.4.16;

import "../lib/DoublyLinkedList.sol";

contract BytesIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.Bytes;

  function read_first_from_bytes_dll(DoublyLinkedList.Bytes storage _list)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.start_item();
  }

  function read_last_from_bytes_dll(DoublyLinkedList.Bytes storage _list)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.end_item();
  }

  function read_next_from_bytes_dll(DoublyLinkedList.Bytes storage _list, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.next_item(_current_item);
  }

  function read_previous_from_bytes_dll(DoublyLinkedList.Bytes storage _list, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.previous_item(_current_item);
  }

  function read_bytes_dll_total(DoublyLinkedList.Bytes storage _list)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total();
  }

}
