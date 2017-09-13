pragma solidity ^0.4.16;

import "../lib/DoublyLinkedList.sol";

contract IndexedUintIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.IndexedUint;

  function read_first_from_indexed_uints_dll(DoublyLinkedList.IndexedUint storage _list, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.start_item(_collection_index);
  }

  function read_last_from_indexed_uints_dll(DoublyLinkedList.IndexedUint storage _list, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.end_item(_collection_index);
  }

  function read_next_from_indexed_uints_dll(DoublyLinkedList.IndexedUint storage _list, bytes32 _collection_index, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.next_item(_collection_index, _current_item);
  }

  function read_previous_from_indexed_uints_dll(DoublyLinkedList.IndexedUint storage _list, bytes32 _collection_index, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.previous_item(_collection_index, _current_item);
  }

  function read_indexed_uints_dll_total(DoublyLinkedList.IndexedUint storage _list, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total(_collection_index);
  }

}
