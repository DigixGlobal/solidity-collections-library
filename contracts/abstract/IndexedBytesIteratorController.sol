pragma solidity ^0.4.16;

import "./IndexedBytesIteratorStorage.sol";

/**
  @title Indexed Bytes Iterator Controller
  @author DigixGlobal Pte Ltd
  @notice This contract utilizes: [Indexed Bytes Iterator Storage](/IndexedBytesIteratorStorage)
*/
contract IndexedBytesIteratorController {

  /**
    @notice Gets the first item from an indexed Bytes Doubly Linked List
    @param _function Function that returns the first item in the collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"First item in the list"}
  */
  function get_first_from_indexed_bytesarray(function (bytes32) constant external returns (bytes32) _function, bytes32 _collection_index)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_collection_index);
  }

  /**
    @notice Gets the last item from an indexed Bytes Doubly Linked List
    @param _function Function that returns the last item in the collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item": "The last item in the list"}
  */
  function get_last_from_indexed_bytesarray(function (bytes32) constant external returns (bytes32) _function, bytes32 _collection_index)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_collection_index);
  }

  /**
    @notice Gets the next item from an indexed Bytes Doubly Linked List using the spcified `_current_item`
    @param _function Function that returns the next item in the collection
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The current item to be used as base line
    @return {"_item":"The next item in the list"}
  */
  function get_next_from_indexed_bytesarray(function (bytes32, bytes32) constant external returns (bytes32) _function, bytes32 _collection_index, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_collection_index, _current_item);
  }
  
  /**
    @notice Gets the previous item from an indexed Bytes Doubly Linked List using the spcified `_current_item`
    @param _function Function that returns the previous item in the collection
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The current item to be used as base line
    @return {"_item":"The previous item in the list"}
  */
  function get_previous_from_indexed_bytesarray(function (bytes32, bytes32) constant external returns (bytes32) _function, bytes32 _collection_index, bytes32 _current_item)
           internal
           constant
           returns (bytes32 _item)
  {
    _item = _function(_collection_index, _current_item);
  }

  /**
    @notice Gets the total number of items in an Indexed Bytes Doubly Linked List
    @param _function Function that returns the length of the collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_total_count":"length of the Doubly Linked List"}
  */
  function get_total_indexed_bytesarray(function (bytes32) constant external returns (uint256) _function, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function(_collection_index);
  }

}
