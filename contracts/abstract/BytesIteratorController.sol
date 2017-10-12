pragma solidity ^0.4.16;

import "./BytesIteratorStorage.sol";

/**
  @title Bytes Iterator Controller
  @author DigixGlobal Pte Ltd
  @notice This contract utilizes: [Bytes Iterator Storage](/BytesIteratorStorage)
*/
contract BytesIteratorController {

  /**
    @notice Encapsulated function that gets the first item from the list of Bytes
    @param _function The Function that returns the First item
    @return {"_item": "The first item"}
  */
  function get_first_from_bytesarray(function () constant external returns (bytes32) _function)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function();
  }

  /**
    @notice Encapsulated function that gets the last item from the list of Bytes
    @param _function The Function that returns the Last item
    @return {"_item": "The last item"}
  */
  function get_last_from_bytesarray(function () constant external returns (bytes32) _function)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function();
  }

  /**
    @notice Encapsulated function that gets the next item from the list of Bytes based on the specified `_current_item`
    @param _function The Function that returns the Next item
    @param _current_item The item to be used as base line
    @return {"_item": "The next item"}
  */
  function get_next_from_bytesarray(function (bytes32) constant external returns (bytes32) _function, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_current_item);
  }

   /**
    @notice Encapsulated function that gets the previous item from the list of Bytes based on the specified `_current_item`
    @param _function The Function that returns the Previous item
    @param _current_item The item to be used as base line
    @return {"_item": "The previous item"}
  */
  function get_previous_from_bytesarray(function (bytes32) constant external returns (bytes32) _function, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_current_item);
  }

  /**
    @notice Encapsulate function that gets the length of list
    @param _function The Function that returns the length of the list
    @return {"_total_count": "Length of the list"}
  */
  function get_total_bytesarray(function () constant external returns (uint256) _function)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function();
  }

}
