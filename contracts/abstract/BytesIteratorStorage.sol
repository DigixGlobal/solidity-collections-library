pragma solidity ^0.4.16;

import "../lib/DoublyLinkedList.sol";


/**
  @title Bytes Iterator Storage
  @author DigixGlobal Pte Ltd
*/
contract BytesIteratorStorage {

  // Initialize Doubly Linked List of Bytes
  using DoublyLinkedList for DoublyLinkedList.Bytes;

  /**
    @notice Reads the first item from the list of Bytes
    @param _list The source list
    @return {"_item": "The first item from the list"}
  */
  function read_first_from_bytesarray(DoublyLinkedList.Bytes storage _list)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.start_item();
  }

  /**
    @notice Reads the last item from the list of Bytes
    @param _list The source list
    @return {"_item": "The last item from the list"}
  */
  function read_last_from_bytesarray(DoublyLinkedList.Bytes storage _list)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.end_item();
  }

  /**
    @notice Reads the next item on the list of Bytes
    @param _list The source list
    @param _current_item The current item to be used as base line
    @return {"_item": "The next item from the list based on the specieid `_current_item`"}
    TODO: Need to verify what happens if the specified `_current_item` is the last item from the list
  */
  function read_next_from_bytesarray(DoublyLinkedList.Bytes storage _list, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.next_item(_current_item);
  }

  /**
    @notice Reads the previous item on the list of Bytes
    @param _list The source list
    @param _current_item The current item to be used as base line
    @return {"_item": "The previous item from the list based on the spcified `_current_item`"}
    TODO: Need to verify what happens if the specified `_current_item` is the first item from the list
  */
  function read_previous_from_bytesarray(DoublyLinkedList.Bytes storage _list, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _list.previous_item(_current_item);
  }

  /**
    @notice Reads the list of Bytes and returns the length of the list
    @param _list The source list
    @return {"count": "`uint256` The lenght of the list"}

  */
  function read_total_bytesarray(DoublyLinkedList.Bytes storage _list)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total();
  }

  /**
    @notice Removes item from list
    @param _list The source list
    @param _item The item to remove
    @return {"_success": "If item was removed successfully"}
  */
  function remove_item_from_bytes(DoublyLinkedList.Bytes storage _list, bytes32 _item)
           internal
           returns (bool _success)
  {
    _success = _list.remove_item(_item);
  }

}
