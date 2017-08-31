pragma solidity ^0.4.14;

import './lib/LibraryDLL.sol';

contract TestLibraryDLL {
  event TestLog(bytes32 _string);
  
  LibraryDLL.Data testData;
  
  function setup_reset_data () {
    delete testData;
  }
  
  function setup_data_for_testing ()
  {
      delete testData;
      testData.collection.push(LibraryDLL.Item('test1',0,2));
      testData.collection.push(LibraryDLL.Item('test2',1,3));
      testData.collection.push(LibraryDLL.Item('test3',2,4));
      testData.collection.push(LibraryDLL.Item('test4',3,5));
      testData.collection.push(LibraryDLL.Item('test5',4,6));
      testData.collection.push(LibraryDLL.Item('test6',5,0));
      testData.item_index['test1'] = 1;
      testData.item_index['test2'] = 2;
      testData.item_index['test3'] = 3;
      testData.item_index['test4'] = 4;
      testData.item_index['test5'] = 5;
      testData.item_index['test6'] = 6;
      testData.first_index = 1;
      testData.last_index = 6;
      testData.count = 6;
  }
  function test_check_collection_count () returns (uint256 _count) {
    _count = testData.collection.length;
  }
  
  function test_check_first_index () returns (uint256 _first_index) {
    _first_index = testData.first_index;
  }
  
  function test_check_last_index () returns (uint256 _last_index) {
    _last_index = testData.last_index;
  }
  
  function test_check_count () returns (uint256 _count) {
    _count = testData.count;
  }
  
  function test_item_previous_index (uint256 _item_index) returns (uint256 _previous_index) {
    _previous_index = testData.collection[_item_index-1].previous_index;
  }
  
  function test_item_next_index (uint256 _item_index) returns (uint256 _next_index) {
    _next_index = testData.collection[_item_index-1].next_index;
  }
  
  function test_find(bytes32 _item)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = LibraryDLL.find(testData, _item);
  }
  
  function test_get(uint256 _item_index)
           returns (bytes32 _item)
  {
    _item = LibraryDLL.get(testData, _item_index);
  }
  
  function test_append(bytes32 _data)
           returns (bool _success)
  {
    _success = LibraryDLL.append(testData, _data);
  }
  
  function test_remove(uint256 _index)
           returns (bool _success)
  {
    _success = LibraryDLL.remove(testData, _index);
  }
  
  function test_remove_item(bytes32 _item)
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
           returns (bytes32 _item)
  {
    _item = LibraryDLL.start_item(testData);
  }
  
  function test_end () 
           returns (uint256 _end_index)
  {
    _end_index = LibraryDLL.end(testData);
  }
  
  function test_end_item () 
           returns (bytes32 _item)
  {
    _item = LibraryDLL.end_item(testData);
  }
  
  function test_valid(uint256 _item_index)
           returns (bool _yes)
  {
    _yes = LibraryDLL.valid(testData, _item_index);
  }
  
  function test_valid_item(bytes32 _item)
           returns (bool _yes)
  {
    _yes = LibraryDLL.valid_item(testData, _item);
  }
  
  function test_previous(uint256 _current_index)
           returns (uint256 _previous_index)
  {
    _previous_index = LibraryDLL.previous(testData, _current_index);
  }
  
  function test_previous_item(bytes32 _current_item)
           returns (bytes32 _previous_item)
  {
    _previous_item = LibraryDLL.previous_item(testData, _current_item);
  }
  
  function test_next(uint256 _current_index)
           returns (uint256 _next_index)
  {
    _next_index = LibraryDLL.next(testData, _current_index);
  }
  
  function test_next_item(bytes32 _current_item)
           returns (bytes32 _next_item)
  {
    _next_item = LibraryDLL.next_item(testData, _current_item);
  }
  
  function test() returns (uint256[16] _results){
      setup_data_for_testing();
      delete testData.collection[2];
      _results[0] = testData.collection[0].previous_index;
      _results[1] = testData.collection[0].next_index;
      _results[2] = testData.collection[1].previous_index;
      _results[3] = testData.collection[1].next_index;
      _results[4] = testData.collection[2].previous_index;
      _results[5] = testData.collection[2].next_index;
      _results[6] = testData.collection[3].previous_index;
      _results[7] = testData.collection[3].next_index;
      _results[8] = testData.collection[4].previous_index;
      _results[9] = testData.collection[4].next_index;
      _results[10] = testData.collection[5].previous_index;
      _results[11] = testData.collection[5].next_index;
      
      _results[12] = 1000000;
      _results[13] = testData.first_index;
      _results[14] = testData.last_index;
      _results[15] = testData.count;
      
      //_results[8] = testData.count;
      //_results[9] = testData.collection.length;
      
      /*delete testData;*/
      /*_results[10] = testData.item_index['test1'];
      _results[11] = testData.item_index['test2'];
      _results[12] = testData.item_index['test3'];*/
      
      /*_results[11] = testData.first_index;
      _results[12] = testData.last_index;
      */
      
      
      TestLog("test123");
  }
}