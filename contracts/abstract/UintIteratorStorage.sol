pragma solidity ^0.4.16;

import "../lib/DoublyLinkedList.sol";

contract UintIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.Uint;

  function read_first_from_uints_dll(DoublyLinkedList.Uint storage _list)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.start_item();
  }

  function read_last_from_uints_dll(DoublyLinkedList.Uint storage _list)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.end_item();
  }

  function read_next_from_uints_dll(DoublyLinkedList.Uint storage _list, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.next_item(_current_item);
  }

  function read_previous_from_uints_dll(DoublyLinkedList.Uint storage _list, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.previous_item(_current_item);
  }

  function read_uints_dll_total(DoublyLinkedList.Uint storage _list)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total();
  }

}
