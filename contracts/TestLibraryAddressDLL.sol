pragma solidity ^0.4.14;

import './lib/LibraryDLL.sol';

contract TestLibraryAddressDLL {
  using LibraryDLL for LibraryDLL.AddressDLL;
  LibraryDLL.AddressDLL testData;

  function setup_reset_data () {
    delete testData;
  }


  function setup_data_for_testing ()
  {
      delete testData;
      testData.append(address(0xef91b34f9a88f811dbd0794446830e95bd68fe7d));
      testData.append(address(0x66ba92773feeef8cc0ddfdc8b6adc87ede1a0ec3));
      testData.append(address(0xe6583dcde6403fbae2a83641ea849f744ca862d5));
      testData.append(address(0x7046f6f2125b7148cb96183d2f3ac19781a2dffc));
      testData.append(address(0x9a8cf272691f844e243e7712ca6f3c0d5f6bc94b));
      testData.append(address(0xd2b90da1b96cbe2aa1b23172dd6d8d77903a92a8));
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

  function test_find(address _item)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = testData.find(_item);
  }

  function test_get(uint256 _item_index)
           returns (address _item)
  {
    _item = testData.get(_item_index);
  }

  function test_append(address _data)
           returns (bool _success)
  {
    _success = testData.append(_data);
  }

  function test_remove(uint256 _index)
           returns (bool _success)
  {
    _success = testData.remove(_index);
  }

  function test_remove_item(address _item)
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
           returns (address _item)
  {
    _item = testData.start_item();
  }

  function test_end ()
           returns (uint256 _end_index)
  {
    _end_index = testData.end();
  }

  function test_end_item ()
           returns (address _item)
  {
    _item = testData.end_item();
  }

  function test_valid(uint256 _item_index)
           returns (bool _yes)
  {
    _yes = testData.valid(_item_index);
  }

  function test_valid_item(address _item)
           returns (bool _yes)
  {
    _yes = testData.valid_item(_item);
  }

  function test_previous(uint256 _current_index)
           returns (uint256 _previous_index)
  {
    _previous_index = testData.previous(_current_index);
  }

  function test_previous_item(address _current_item)
           returns (address _previous_item)
  {
    _previous_item = testData.previous_item(_current_item);
  }

  function test_next(uint256 _current_index)
           returns (uint256 _next_index)
  {
    _next_index = testData.next(_current_index);
  }

  function test_next_item(address _current_item)
           returns (address _next_item)
  {
    _next_item = testData.next_item(_current_item);
  }
}
