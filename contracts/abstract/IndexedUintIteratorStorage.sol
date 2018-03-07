pragma solidity ^0.4.19;

import "../lib/DoublyLinkedList.sol";

/**
  @title Indexed Uint Iterator Storage
  @author DigixGlobal Pte Ltd
*/
contract IndexedUintIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.IndexedUint;

  /**
    @notice Returns the first item of an IndexedUint list using the specified `_collection_index`
    @param _list The DoublyLinkedList.IndexedUint list
    @param _collection_index The index of a collection
    @return {"_item": "The first item"}
  */
  function read_first_from_indexed_uints(DoublyLinkedList.IndexedUint storage _list, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.start_item(_collection_index);
  }

  /**
    @notice Returns the last item of an IndexedUint list using the specified `_collection_index`
    @param _list The DoublyLinkedList.IndexedUint list
    @param _collection_index The index of a collection
    @return {"_item": "The last item"}
  */
  function read_last_from_indexed_uints(DoublyLinkedList.IndexedUint storage _list, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.end_item(_collection_index);
  }

  /**
    @notice Returns the next item of an IndexedUint list using the specified `_collection_index` based on the `_current_item`
    @param _list The DoublyLinkedList.IndexedUint list
    @param _collection_index The index of a collection
    @param _current_item The current item
    @return {"_item": "The next item"}
  */
  function read_next_from_indexed_uints(DoublyLinkedList.IndexedUint storage _list, bytes32 _collection_index, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.next_item(_collection_index, _current_item);
  }

  /**
    @notice Returns the previous item of an IndexedUint list using the specified `_collection_index` based on the `_current_item`
    @param _list The DoublyLinkedList.IndexedUint list
    @param _collection_index The index of a collection
    @param _current_item The current item
    @return {"_item": "The previous item"}
  */
  function read_previous_from_indexed_uints(DoublyLinkedList.IndexedUint storage _list, bytes32 _collection_index, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.previous_item(_collection_index, _current_item);
  }

  /**
    @notice Returns the total number `DoublyLinkedList.IndexedUint` list starting from a `_collection_index`
    @param _list The DoublyLinkedList.IndexedUint list
    @param _collection_index The index of a collection
    @return {"_item": "The first item"}
  */
  function read_total_indexed_uints(DoublyLinkedList.IndexedUint storage _list, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total(_collection_index);
  }

}
