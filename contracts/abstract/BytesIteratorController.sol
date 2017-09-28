pragma solidity ^0.4.16;

import "./BytesIteratorStorage.sol";

/**
  @title Bytes Iterator Controller
  @author DigixGlobal Pte Ltd
*/
contract BytesIteratorController {

  /* 
    @notice Encapsulated function that gets the first item from the list of Bytes
    @param _function Function that returns the first item
    @return {"_item": "The first item"}
  */
  function get_first_from_bytes_dll(function () constant external returns (bytes32) _function)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function();
  }

  /*
    @notice Encapsulated function that gets the last item from the list of Bytes
    @param _function Function that returns the last item
    @return {"_item": "The last item"}
  */
  function get_last_from_bytes_dll(function () constant external returns (bytes32) _function)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function();
  }

  /*
    @notice Encapsulated function that gets the next item from the list of Bytes based on the specified `_current_item`
    @param _function Function that returns the next item
    @return {"_item": "The next item"}
  */
  function get_next_from_bytes_dll(function (bytes32) constant external returns (bytes32) _function, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_current_item);
  }

   /*
    @notice Encapsulated function that gets the previous item from the list of Bytes based on the specified `_current_item`
    @param _function Function that returns the next item
    @return {"_item": "The next item"}
  */  
  function get_previous_from_bytes_dll(function (bytes32) constant external returns (bytes32) _function, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_current_item);
  }

  /* 
    @notice Encapsulate function that gets the length of list
    @param _function Function that returns the length of the list
    @return {"_total_count": "Length of the list"}
  */
  function get_total_in_bytes_dll(function () constant external returns (uint256) _function)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function();
  }

}
