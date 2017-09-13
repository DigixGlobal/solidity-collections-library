pragma solidity ^0.4.16;

import "../lib/DoublyLinkedList.sol";

contract IndexedBytesIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.IndexedBytes;

  function read_first_from_indexed_bytes_dll(DoublyLinkedList.IndexedBytes storage _list, bytes32 _collection_index)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.start_item(_collection_index);
  }

  function read_last_from_indexed_bytes_dll(DoublyLinkedList.IndexedBytes storage _list, bytes32 _collection_index)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.end_item(_collection_index);
  }

  function read_next_from_indexed_bytes_dll(DoublyLinkedList.IndexedBytes storage _list, bytes32 _collection_index, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.next_item(_collection_index, _current_item);
  }

  function read_previous_from_indexed_bytes_dll(DoublyLinkedList.IndexedBytes storage _list, bytes32 _collection_index, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.previous_item(_collection_index, _current_item);
  }

  function read_indexed_bytes_dll_total(DoublyLinkedList.IndexedBytes storage _list, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total(_collection_index);
  }

}
