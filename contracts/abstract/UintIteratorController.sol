pragma solidity ^0.4.16;

/**
  @title Uint Iterator Interactive
  @author DigixGlobal Pte Ltd
*/
import "./UintIteratorStorage.sol";

contract UintIteratorController {

  /**
    @notice Returns the first item from the list
    @param _function Function that returns the first item
    @return {"_item": "The first item"}
  */
  function get_first_from_uints(function () constant external returns (uint256) _function)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function();
  }

  /**
    @notice Returns the last item from the list
    @param _function Function that returns the last item
    @return {"_item": "The last item"}
  */
  function get_last_from_uints(function () constant external returns (uint256) _function)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function();
  }

  /**
    @notice Returns the next item from the list based on the `_current_item`
    @param _function Function that returns the next item
    @param _current_item The current item
    @return {"_item": "The next item"}
  */
  function get_next_from_uints(function (uint256) constant external returns (uint256) _function, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_current_item);
  }

  /**
    @notice Returns the previous item from the list based on the `_current_item`
    @param _function Function that returns the previous item
    @param _current_item The current item
    @return {"_item": "The next item"}
  */
  function get_previous_from_uints(function (uint256) constant external returns (uint256) _function, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_current_item);
  }

  /**
    @notice Returns the total number of items from the list
    @param _function Function that returns the total number of items
    @return {"_total_count": "The total number of items"}
  */
  function get_total_uints(function () constant external returns (uint256) _function)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function();
  }

}
