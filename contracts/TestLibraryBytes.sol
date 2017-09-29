pragma solidity ^0.4.16;

import './lib/DoublyLinkedList.sol';

/**
  @title Contract that Uses Bytes Struct of DoublyLinkedList Library for Testing
  @author DigixGlobal Pte Ltd
*/
contract TestLibraryBytes {
  using DoublyLinkedList for DoublyLinkedList.Bytes;
  DoublyLinkedList.Bytes testData;

  /// @notice Deletes the `testData` values
  function setup_reset_data () {
    delete testData;
  }

  /// @notice Setups `testData` values for testing
  function setup_data_for_testing ()
  {
      delete testData;
      testData.append('test1');
      testData.append('test2');
      testData.append('test3');
      testData.append('test4');
      testData.append('test5');
      testData.append('test6');
  }

  /**
  @notice Returns the total number of collection in `testData.data`
  @return {"_count": "The total number of collection in `testData.data`"}
  */
  function test_check_collection_count () returns (uint256 _count) {
    _count = testData.data.collection.length;
  }

  /**
  @notice Returns the first index of `testData.data`
  @return {"_first_index": "First index of `testData.data`"}
  */
  function test_check_first_index () returns (uint256 _first_index) {
    _first_index = testData.data.first_index;
  }

  /**
  @notice Returns the last index of `testData.data`
  @return {"_first_index": "Last index of `testData.data`"}
  */
  function test_check_last_index () returns (uint256 _last_index) {
    _last_index = testData.data.last_index;
  }

  /**
  @notice Returns the total number of items in `testData.data`
  @return {"_count": "Total number of items in `testData.data`"}
  */
  function test_check_count () returns (uint256 _count) {
    _count = testData.data.count;
  }

  /**
  @notice Returns the previous index in `testData.data` based on the given `_item_index`
  @param _item_index Starting index of the item
  @return {"_previous_index": "Index of the previous item of `testData.data`"}
  */
  function test_item_previous_index (uint256 _item_index) returns (uint256 _previous_index) {
    _previous_index = testData.data.collection[_item_index-1].previous_index;
  }

  /**
  @notice Returns the next index in `testData.data` based on the given `_item_index`
  @param _item_index Starting index of the item
  @return {"_next_index": "Index of the next item of `testData.data`"}
  */
  function test_item_next_index (uint256 _item_index) returns (uint256 _next_index) {
    _next_index = testData.data.collection[_item_index-1].next_index;
  }

  /**
  @notice Returns the index of the given `_item` in `testData`
  @param _item Address of item to be found
  @return {"_item_index": "Index of the given `_item` in `testData`"}
  */
  function test_find(bytes32 _item)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = testData.find(_item);
  }

  /**
  @notice Returns the item of the given `_item_index` in `testData`
  @param _item_index Index of the item to be get
  @return {"_item": "Item of the given `_item_index` in `testData`"}
  */
  function test_get(uint256 _item_index)
           returns (bytes32 _item)
  {
    _item = testData.get(_item_index);
  }

  /**
  @notice Appends a given `_data` into `testData`
  @param _data Data to be appended
  @return {"_success": "If appending of `data` is successful"}
  */
  function test_append(bytes32 _data)
           returns (bool _success)
  {
    _success = testData.append(_data);
  }

  /**
  @notice Removes an item index based on the given `_index` in `testData`
  @param _index Index of the item to be removed
  @return {"_success": "If removing of the `_index` is successful"}
  */
  function test_remove(uint256 _index)
           returns (bool _success)
  {
    _success = testData.remove(_index);
  }

  /**
  @notice Removes an item based on the given `_item` in `testData`
  @param _item Item to be removed
  @return {"_success": "If removing of the `_item` is successful"}
  */
  function test_remove_item(bytes32 _item)
           returns (bool _success)
  {
    _success = testData.remove_item(_item);
  }

  /**
  @notice Returns the total number of items in `testData`
  @return {"_total_count": "Total number of items in `testData`"}
  */
  function test_total ()
           returns (uint256 _total_count)
  {
    _total_count = testData.total();
  }

  /**
  @notice Returns the index of the first item in `testData`
  @return {"_start_index": "Index of the first item in `testData`"}
  */
  function test_start ()
           returns (uint256 _start_index)
  {
    _start_index = testData.start();
  }

  /**
  @notice Returns the first item of `testData`
  @return {"_item": "First item of `testData`"}
  */
  function test_start_item ()
           returns (bytes32 _item)
  {
    _item = testData.start_item();
  }

  /**
  @notice Returns the index of the last item of `testData`
  @return {"_end_index": "Index of the list item in `testData`"}
  */
  function test_end ()
           returns (uint256 _end_index)
  {
    _end_index = testData.end();
  }

  /**
  @notice Returns the last item of `testData`
  @return {"_item": "Last item of `testData`"}
  */
  function test_end_item ()
           returns (bytes32 _item)
  {
    _item = testData.end_item();
  }

  /**
  @notice Checks if a given `_item_index` is a valid index in `testData`
  @param _item_index Index of the item to be checked
  @return {"_yes": "If `_item_index` is a valid index in `testData`"}
  */
  function test_valid(uint256 _item_index)
           returns (bool _yes)
  {
    _yes = testData.valid(_item_index);
  }

  /**
  @notice Checks if a given `_item_index` is a valid index in `testData`
  @param _item Item to be checked
  @return {"_yes": "If `_item` is a valid item in `testData`"}
  */
  function test_valid_item(bytes32 _item)
           returns (bool _yes)
  {
    _yes = testData.valid_item(_item);
  }

  /**
  @notice Returns the previous index of `testData` based on the given `_current_index`
  @param _current_index Current index of the item
  @return {"_previous_index": "Previous index of `testData`"}
  */
  function test_previous(uint256 _current_index)
           returns (uint256 _previous_index)
  {
    _previous_index = testData.previous(_current_index);
  }

  /**
  @notice Returns the previous item of `testData` based on the given `_current_item`
  @param _current_item Current item
  @return {"_previous_item": "Previous item of `testData`"}
  */
  function test_previous_item(bytes32 _current_item)
           returns (bytes32 _previous_item)
  {
    _previous_item = testData.previous_item(_current_item);
  }

  /**
  @notice Returns the next index of `testData` based on the given `_current_index`
  @param _current_index Current index of the item
  @return {"_next_index": "Next index of `testData`"}
  */
  function test_next(uint256 _current_index)
           returns (uint256 _next_index)
  {
    _next_index = testData.next(_current_index);
  }

  /**
  @notice Returns the next item of `testData` based on the given `_current_item`
  @param _current_item Current item
  @return {"_next_item": "Next item of `testData`"}
  */
  function test_next_item(bytes32 _current_item)
           returns (bytes32 _next_item)
  {
    _next_item = testData.next_item(_current_item);
  }
}
