pragma solidity ^0.4.16;

import "./AddressIteratorStorage.sol";

/**
  @title Address Iterator Controller
  @author DigixGlobal Pte Ltd
  @notice This contract utilizes: [Address Iterator Storage](/AddressIteratorStorage)
*/

contract AddressIteratorController {

  /**
	  @notice Gets the first adddress from the list
    @return {"_item": "The first Address"}
  */
  function get_first_from_addresses_dll(function () constant external returns (address) _function)
           internal
           constant
           returns (address _item)
  {
    _item = _function();
  }

  /**
    @notice Gets the last address from the list
    @return {"_item": "The last Address"}
  */
  function get_last_from_addresses_dll(function () constant external returns (address) _function)
           internal
           constant
           returns (address _item)
  {
    _item = _function();
  }

  /**
    @notice Gets the next address from the list based on the specified `_current_item`
    @param _function The function that returns the next address based on the specified `_current_item`
    @param _current_item The current Address
    @return {"_item": "The last Address"} 
  */
  function get_next_from_addresses_dll(function (address) constant external returns (address) _function, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _function(_current_item);
  }

  /**
    @notice Gets the previous address from the list based on the spcified `_current_item`
    @param _function The function that returns the previous address based on the specified `_current_item`
    @param _current_item  The current Address
    @return {"_item": "The last Address"}
  */         
  function get_previous_from_addresses_dll(function (address) constant external returns (address) _function, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _function(_current_item);
  }

  /**
    @notice Gets the length (total number of addresses) of the list
    @param _function Function that returns the length of the list
    @return {"_total_count": "Length of the list"}
  */
  function get_total_in_addresses_dll(function () constant external returns (uint256) _function)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function();
  }

}
