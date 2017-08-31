pragma solidity ^0.4.14;

import './lib/LibraryDLL.sol';

contract TestLibraryUintDLL {
  event TestLog(bytes32 _string);

  LibraryDLL.UintDLL testData;

  function setup_reset_data () {
    delete testData.data;
  }

  function setup_data_for_testing ()
  {
      delete testData.data;
      testData.data.collection.push(LibraryDLL.Item(bytes32(101),0,2));
      testData.data.collection.push(LibraryDLL.Item(bytes32(102),1,3));
      testData.data.collection.push(LibraryDLL.Item(bytes32(103),2,4));
      testData.data.collection.push(LibraryDLL.Item(bytes32(104),3,5));
      testData.data.collection.push(LibraryDLL.Item(bytes32(105),4,6));
      testData.data.collection.push(LibraryDLL.Item(bytes32(106),5,0));
      testData.data.item_index[bytes32(101)] = 1;
      testData.data.item_index[bytes32(102)] = 2;
      testData.data.item_index[bytes32(103)] = 3;
      testData.data.item_index[bytes32(104)] = 4;
      testData.data.item_index[bytes32(105)] = 5;
      testData.data.item_index[bytes32(106)] = 6;
      testData.data.first_index = 1;
      testData.data.last_index = 6;
      testData.data.count = 6;
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
    _item_index = LibraryDLL.find(testData, _item);
  }

  function test_get(uint256 _item_index)
           returns (uint256 _item)
  {
    _item = LibraryDLL.get(testData, _item_index);
  }

  function test_append(uint256 _data)
           returns (bool _success)
  {
    _success = LibraryDLL.append(testData, _data);
  }

  function test_remove(uint256 _index)
           returns (bool _success)
  {
    _success = LibraryDLL.remove(testData, _index);
  }

  function test_remove_item(uint256 _item)
           returns (bool _success)
  {
    _success = LibraryDLL.remove_item(testData, _item);
  }

  function test_total ()
           returns (uint256 _total_count)
  {
    _total_count = LibraryDLL.total(testData);
  }

  function test_start ()
           returns (uint256 _start_index)
  {
    _start_index = LibraryDLL.start(testData);
  }

  function test_start_item ()
           returns (uint256 _item)
  {
    _item = LibraryDLL.start_item(testData);
  }

  function test_end ()
           returns (uint256 _end_index)
  {
    _end_index = LibraryDLL.end(testData);
  }

  function test_end_item ()
           returns (uint256 _item)
  {
    _item = LibraryDLL.end_item(testData);
  }

  function test_valid(uint256 _item_index)
           returns (bool _yes)
  {
    _yes = LibraryDLL.valid(testData, _item_index);
  }

  function test_valid_item(uint256 _item)
           returns (bool _yes)
  {
    _yes = LibraryDLL.valid_item(testData, _item);
  }

  function test_previous(uint256 _current_index)
           returns (uint256 _previous_index)
  {
    _previous_index = LibraryDLL.previous(testData, _current_index);
  }

  function test_previous_item(uint256 _current_item)
           returns (uint256 _previous_item)
  {
    _previous_item = LibraryDLL.previous_item(testData, _current_item);
  }

  function test_next(uint256 _current_index)
           returns (uint256 _next_index)
  {
    _next_index = LibraryDLL.next(testData, _current_index);
  }

  function test_next_item(uint256 _current_item)
           returns (uint256 _next_item)
  {
    _next_item = LibraryDLL.next_item(testData, _current_item);
  }

  function test() returns (uint256[16] _results){
      setup_data_for_testing();
      delete testData.data.collection[2];
      _results[0] = testData.data.collection[0].previous_index;
      _results[1] = testData.data.collection[0].next_index;
      _results[2] = testData.data.collection[1].previous_index;
      _results[3] = testData.data.collection[1].next_index;
      _results[4] = testData.data.collection[2].previous_index;
      _results[5] = testData.data.collection[2].next_index;
      _results[6] = testData.data.collection[3].previous_index;
      _results[7] = testData.data.collection[3].next_index;
      _results[8] = testData.data.collection[4].previous_index;
      _results[9] = testData.data.collection[4].next_index;
      _results[10] = testData.data.collection[5].previous_index;
      _results[11] = testData.data.collection[5].next_index;

      _results[12] = 1000000;
      _results[13] = testData.data.first_index;
      _results[14] = testData.data.last_index;
      _results[15] = testData.data.count;

      //_results[8] = testData.data.count;
      //_results[9] = testData.data.collection.length;

      /*delete testData;*/
      /*_results[10] = testData.data.item_index['test1'];
      _results[11] = testData.data.item_index['test2'];
      _results[12] = testData.data.item_index['test3'];*/

      /*_results[11] = testData.data.first_index;
      _results[12] = testData.data.last_index;
      */


      TestLog("test123");
  }
}
