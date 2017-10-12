pragma solidity ^0.4.16;

import "../lib/DoublyLinkedList.sol";

/**
  @title Indexed Address IteratorStorage
  @author DigixGlobal Pte Ltd
  @notice This contract utilizes: [Doubly Linked List](/DoublyLinkedList)
*/
contract IndexedAddressIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.IndexedAddress;
  /**
    @notice Reads the first item from an Indexed Address Doubly Linked List
    @param _list The source list
    @param _collection_index Index of the Collection to evaluate
    @return {"_item" : "First item on the list"}
  */
  function read_first_from_indexed_addresses(DoublyLinkedList.IndexedAddress storage _list, bytes32 _collection_index)
           internal
           constant
           returns (address _item)
  {
    _item = _list.start_item(_collection_index);
  }

  /**
    @notice Reads the last item from an Indexed Address Doubly Linked list
    @param _list The source list
    @param _collection_index Index of the Collection to evaluate
    @return {"_item" : "First item on the list"}
  */
  function read_last_from_indexed_addresses(DoublyLinkedList.IndexedAddress storage _list, bytes32 _collection_index)
           internal
           constant
           returns (address _item)
  {
    _item = _list.end_item(_collection_index);
  }

  /**
    @notice Reads the next item from an Indexed Address Doubly Linked List based on the specified `_current_item`
    @param _list The source list
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The current item to use as base line
    @return {"_item": "The next item on the list"}
  */
  function read_next_from_indexed_addresses(DoublyLinkedList.IndexedAddress storage _list, bytes32 _collection_index, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _list.next_item(_collection_index, _current_item);
  }

  /**
    @notice Reads the previous item from an Index Address Doubly Linked List based on the specified `_current_item`
    @param _list The source list
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The current item to use as base line
    @return {"_item" : "The previous item on the list"}
  */
  function read_previous_from_indexed_addresses(DoublyLinkedList.IndexedAddress storage _list, bytes32 _collection_index, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _list.previous_item(_collection_index, _current_item);
  }


  /**
    @notice Reads the total number of items in an Indexed Address Doubly Linked List
    @param _list  The source list
    @param _collection_index Index of the Collection to evaluate
    @return {"_count": "Length of the Doubly Linked list"}
  */
  function read_total_indexed_addresses(DoublyLinkedList.IndexedAddress storage _list, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total(_collection_index);
  }

}
