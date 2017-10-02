pragma solidity ^0.4.16;

import "../lib/DoublyLinkedList.sol";

/**
  @title Indexed Bytes Iterator Storage
  @author DigixGlobal Pte Ltd
  @notice This contract utilizes: [Doubly Linked List](/DoublyLinkedList)
*/
contract IndexedBytesIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.IndexedBytes;

  /**
    @notice Reads the first item from an Indexed Bytes Doubly Linked List
    @param _list The source list
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"The first item from the specified `_list`"}
  */
  function read_first_from_indexed_bytes_dll(DoublyLinkedList.IndexedBytes storage _list, bytes32 _collection_index)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.start_item(_collection_index);
  }

  /**
    @notice Reads the last item from an Indexed Bytes Doubly Linked List
    @param _list The source list
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"The last item from the specified `_list`"}
  */
  function read_last_from_indexed_bytes_dll(DoublyLinkedList.IndexedBytes storage _list, bytes32 _collection_index)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.end_item(_collection_index);
  }

  /**
    @notice Reads the next item from an Indexed Bytes Doubly Linked List
    @param _list The source list
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The current item to be used as base line
    @return {"_item":"The next item from the specified `_current_item`"}
  */
  function read_next_from_indexed_bytes_dll(DoublyLinkedList.IndexedBytes storage _list, bytes32 _collection_index, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.next_item(_collection_index, _current_item);
  }

  /**
    @notice Reads the previous item from an Indexed Bytes Doubly Linked List
    @param _list The source list
    @param _collection_index Collection Index
    @param _current_item The current item to be used as base line
    @return {"_item":"The previous item from the specified `_current_item`"}
  */
  function read_previous_from_indexed_bytes_dll(DoublyLinkedList.IndexedBytes storage _list, bytes32 _collection_index, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.previous_item(_collection_index, _current_item);
  }

  /**
    @notice Reads the list of Indexed Bytes and returns length of the list
    @param _list The source list
    @param _collection_index Index of the Collection to evaluate
    @return {"_count":""}
  */
  function read_indexed_bytes_dll_total(DoublyLinkedList.IndexedBytes storage _list, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total(_collection_index);
  }

}
