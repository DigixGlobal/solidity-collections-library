pragma solidity ^0.4.16;

import './lib/LibraryDLL.sol';

contract TestLibraryUintDLL {
  using LibraryDLL for LibraryDLL.UintDLL;
  LibraryDLL.UintDLL testData;

  function setup_reset_data () {
    delete testData;
  }

  function setup_data_for_testing ()
  {
      delete testData;
      testData.append(101);
      testData.append(102);
      testData.append(103);
      testData.append(104);
      testData.append(105);
      testData.append(106);
  }
  function test_check_collection_count () returns (uint256 _count) {
    _count = testData.data.collection.length;
  }

  function test_check_first_index () returns (uint256 _first_index) {
    _first_index = testData.data.first_index;
  }

  function test_check_last_index () returns (uint256 _last_index) {
    _last_index = testData.data.last_index;
  }

  function test_check_count () returns (uint256 _count) {
    _count = testData.data.count;
  }

  function test_item_previous_index (uint256 _item_index) returns (uint256 _previous_index) {
    _previous_index = testData.data.collection[_item_index-1].previous_index;
  }

  function test_item_next_index (uint256 _item_index) returns (uint256 _next_index) {
    _next_index = testData.data.collection[_item_index-1].next_index;
  }

  function test_find(uint256 _item)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = testData.find(_item);
  }

  function test_get(uint256 _item_index)
           returns (uint256 _item)
  {
    _item = testData.get(_item_index);
  }

  function test_append(uint256 _data)
           returns (bool _success)
  {
    _success = testData.append(_data);
  }

  function test_remove(uint256 _index)
           returns (bool _success)
  {
    _success = testData.remove(_index);
  }

  function test_remove_item(uint256 _item)
           returns (bool _success)
  {
    _success = testData.remove_item(_item);
  }

  function test_total ()
           returns (uint256 _total_count)
  {
    _total_count = testData.total();
  }

  function test_start ()
           returns (uint256 _start_index)
  {
    _start_index = testData.start();
  }

  function test_start_item ()
           returns (uint256 _item)
  {
    _item = testData.start_item();
  }

  function test_end ()
           returns (uint256 _end_index)
  {
    _end_index = testData.end();
  }

  function test_end_item ()
           returns (uint256 _item)
  {
    _item = testData.end_item();
  }

  function test_valid(uint256 _item_index)
           returns (bool _yes)
  {
    _yes = testData.valid(_item_index);
  }

  function test_valid_item(uint256 _item)
           returns (bool _yes)
  {
    _yes = testData.valid_item(_item);
  }

  function test_previous(uint256 _current_index)
           returns (uint256 _previous_index)
  {
    _previous_index = testData.previous(_current_index);
  }

  function test_previous_item(uint256 _current_item)
           returns (uint256 _previous_item)
  {
    _previous_item = testData.previous_item(_current_item);
  }

  function test_next(uint256 _current_index)
           returns (uint256 _next_index)
  {
    _next_index = testData.next(_current_index);
  }

  function test_next_item(uint256 _current_item)
           returns (uint256 _next_item)
  {
    _next_item = testData.next_item(_current_item);
  }
}
