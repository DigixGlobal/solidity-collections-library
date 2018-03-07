pragma solidity ^0.4.19;

import "../lib/DoublyLinkedList.sol";

/**
  @title Address Iterator Storage
  @author DigixGlobal Pte Ltd
  @notice See: [Doubly Linked List](/DoublyLinkedList)
*/
contract AddressIteratorStorage {

  // Initialize Doubly Linked List of Address
  using DoublyLinkedList for DoublyLinkedList.Address;

  /**
    @notice Reads the first item from the list of Address
    @param _list The source list
    @return {"_item" : "The first item from the list"}
  */
  function read_first_from_addresses(DoublyLinkedList.Address storage _list)
           internal
           constant
           returns (address _item)
  {
    _item = _list.start_item();
  }


  /**
    @notice Reads the last item from the list of Address
    @param _list The source list
    @return {"_item" : "The last item from the list"}
  */
  function read_last_from_addresses(DoublyLinkedList.Address storage _list)
           internal
           constant
           returns (address _item)
  {
    _item = _list.end_item();
  }

  /**
    @notice Reads the next item on the list of Address
    @param _list The source list
    @param _current_item The current item to be used as base line
    @return {"_item" : "The next item from the list based on the specieid `_current_item`"}
  */
  function read_next_from_addresses(DoublyLinkedList.Address storage _list, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _list.next_item(_current_item);
  }

  /**
    @notice Reads the previous item on the list of Address
    @param _list The source list
    @param _current_item The current item to be used as base line
    @return {"_item" : "The previous item from the list based on the spcified `_current_item`"}
  */
  function read_previous_from_addresses(DoublyLinkedList.Address storage _list, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _list.previous_item(_current_item);
  }

  /**
    @notice Reads the list of Address and returns the length of the list
    @param _list The source list
    @return {"_count": "The lenght of the list"}
  */
  function read_total_addresses(DoublyLinkedList.Address storage _list)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total();
  }

}
