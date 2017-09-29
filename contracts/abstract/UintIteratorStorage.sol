pragma solidity ^0.4.16;

import "../lib/DoublyLinkedList.sol";

/**
  @title Uint Iterator Storage
  @author DigixGlobal Pte Ltd
*/
contract UintIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.Uint;

  /**
    @notice Returns the first item from a `DoublyLinkedList.Uint` list
    @param _list The DoublyLinkedList.Uint list
    @return {"_item": "The first item"}
  */
  function read_first_from_uints_dll(DoublyLinkedList.Uint storage _list)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.start_item();
  }

  /**
    @notice Returns the last item from a `DoublyLinkedList.Uint` list
    @param _list The DoublyLinkedList.Uint list
    @return {"_item": "The last item"}
  */
  function read_last_from_uints_dll(DoublyLinkedList.Uint storage _list)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.end_item();
  }

  /**
    @notice Returns the next item from a `DoublyLinkedList.Uint` list based on the specified `_current_item`
    @param _list The DoublyLinkedList.Uint list
    @param _current_item The current item
    @return {"_item": "The next item"}
  */
  function read_next_from_uints_dll(DoublyLinkedList.Uint storage _list, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.next_item(_current_item);
  }

  /**
    @notice Returns the previous item from a `DoublyLinkedList.Uint` list based on the specified `_current_item`
    @param _list The DoublyLinkedList.Uint list
    @param _current_item The current item
    @return {"_item": "The previous item"}
  */
  function read_previous_from_uints_dll(DoublyLinkedList.Uint storage _list, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _list.previous_item(_current_item);
  }

  /**
    @notice Returns the total count of itemsfrom a `DoublyLinkedList.Uint` list
    @param _list The DoublyLinkedList.Uint list
    @return {"_count": "The total count of items"}
  */
  function read_uints_dll_total(DoublyLinkedList.Uint storage _list)
           internal
           constant
           returns (uint256 _count)
  {
    _count = _list.total();
  }

}
