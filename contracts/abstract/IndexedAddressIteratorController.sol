pragma solidity ^0.4.16;

import "./IndexedAddressIteratorStorage.sol";

/**
  @title Indexed Address Iterator Controller
  @author DigixGlobal Pte Ltd
  @notice This contract utilizes: [Indexed Address IteratorStorage](/IndexedAddressIteratorStorage)
*/
contract IndexedAddressIteratorController {

  /**
    @notice Encapsulated function that gets the first item from an Indexed Address Doubly Linked List
    @param _function Function that returns the first Address based on the specified  `_collection_index`
    @param _collection_index Index of the collection to evaluate
    @return {"_item":"The first item from the list"}
  */
  function get_first_from_indexed_addresses(function (bytes32) constant external returns (address) _function, bytes32 _collection_index)
           internal
           constant
           returns (address _item)
  {
    _item = _function(_collection_index);
  }

  /**
    @notice Encapsulated function that gets the last item from an Indexed Adddress Doubly Linked List
    @param _function Function that returns the last Address based on the specified  `_collection_index`
    @param _collection_index Index of the collection to evaluate
    @return {"_item":"The last item from the list"}
  */
  function get_last_from_indexed_addresses(function (bytes32) constant external returns (address) _function, bytes32 _collection_index)
           internal
           constant
           returns (address _item)
  {
    _item = _function(_collection_index);
  }

  /**
    @notice Encapsulated function that gets the next item from an Indexed Address Doubly Linked List
    @param _function Function that returns the next Address based on the specified `_collection_index` and `_current-item`
    @param _collection_index The index of the collection to evaluate
    @param _current_item The current item to be used as base line
    @return {"_item":"The next item from the list"}
  */
  function get_next_from_indexed_addresses(function (bytes32, address) constant external returns (address) _function, bytes32 _collection_index, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _function(_collection_index, _current_item);
  }
  
  /**
    @notice Encapsulated function that gets the previous item from an Indexed Address Doubly Linked List
    @param _function Function that returns the previous Address based on the specified `_collection_index` and `_current-item`
    @param _collection_index The index of the collection to evaluate
    @param _current_item The current item be used as base line
    @return {"_item":"The previous item from the list"}
  */
  function get_previous_from_indexed_addresses(function (bytes32, address) constant external returns (address) _function, bytes32 _collection_index, address _current_item)
           internal
           constant
           returns (address _item)
  {
    _item = _function(_collection_index, _current_item);
  }

  /**
    @notice Encapsulated function that gets the length of an Indexed Address Doubly Linked List
    @param _function Function that returns the length of the list
    @param _collection_index The index of the collection to evaluate
    @return {"_total_count": "Lenth of the list"}
  */
  function get_total_indexed_addresses(function (bytes32) constant external returns (uint256) _function, bytes32 _collection_index)
           internal
           constant
           returns (uint256 _total_count)
  {
    _total_count = _function(_collection_index);
  }

}
