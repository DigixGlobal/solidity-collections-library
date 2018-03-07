pragma solidity ^0.4.19;

import "./IndexedUintIteratorStorage.sol";

/**
  @title Indexed Uint Iterator Controller
  @author DigixGlobal Pte Ltd
*/
contract IndexedUintIteratorController {

  /**
  @notice Returns the first item of the specified `_collection_index`
  @param _function Function that returns the first item of the `_collection_index`
  @param _collection_index The index of a collection
  @return {"_item": "The first item"}
  */
  function get_first_from_indexed_uints(function (bytes32) constant external returns (uint256) _function, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_collection_index);
  }

  /**
  @notice Returns the last item of the specified `_collection_index`
  @param _function Function that returns the last item of the `_collection_index`
  @param _collection_index The index of a collection
  @return {"_item": "The last item"}
  */
  function get_last_from_indexed_uints(function (bytes32) constant external returns (uint256) _function, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_collection_index);
  }

  /**
  @notice Returns the next item of the specified `_collection_index` based on the specified `_current_item`
  @param _function Function that returns the next item of the `_collection_index` based on the `_current_item`
  @param _collection_index The index of a collection
  @param _current_item The current item
  @return {"_item": "The next item"}
  */
  function get_next_from_indexed_uints(function (bytes32, uint256) constant external returns (uint256) _function, bytes32 _collection_index, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_collection_index, _current_item);
  }

  /**
  @notice Returns the previous item of the specified `_collection_index` based on the specified `_current_item`
  @param _function Function that returns the previous item of the `_collection_index` based on the `_current_item`
  @param _collection_index The index of a collection
  @param _current_item The current item
  @return {"_item": "The previous item"}
  */
  function get_previous_from_indexed_uints(function (bytes32, uint256) constant external returns (uint256) _function, bytes32 _collection_index, uint256 _current_item)
           internal
           constant
           returns (uint256 _item)
  {
    _item = _function(_collection_index, _current_item);
  }

  /**
  @notice Returns the total number of items in the specified `_collection_index`
  @param _function Function that returns the total number of items in the specified `_collection_index`
  @param _collection_index The index of a collection
  @return {"_total_count": "The total number of items"}
  */
  function get_total_indexed_uints(function (bytes32) constant external returns (uint256) _function, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function(_collection_index);
  }

}
