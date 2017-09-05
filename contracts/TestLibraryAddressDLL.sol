pragma solidity ^0.4.14;

import './lib/LibraryDLL.sol';

contract TestLibraryAddressDLL {
  event TestLog(bytes32 _string);

  LibraryDLL.AddressDLL testData;

  function setup_reset_data () {
    delete testData.data;
  }

  function setup_data_for_testing ()
  {
      delete testData.data;
      address[6] memory addresses;
      addresses[0] = 0x249b1bf054d2b2643a0e38948aa92ccb6c2ccd7e;
      addresses[1] = 0x1cd24e853af2027df542551f393b1bd0db2f1a03;
      addresses[2] = 0x54e3872db39fc3a1fa018688bff59dd6409b0a23;
      addresses[3] = 0x4db089d50f72996895dc4224c8c6fae0f104bc1d;
      addresses[4] = 0x74cd5f20ee949189bdc83f7f6088063eb7fdcc86;
      addresses[5] = 0xa1fada6e4f11770a672ca678d6290b311f53c256;

      testData.data.collection.push(LibraryDLL.Item(bytes32(addresses[0]),0,2));
      testData.data.collection.push(LibraryDLL.Item(bytes32(addresses[1]),1,3));
      testData.data.collection.push(LibraryDLL.Item(bytes32(addresses[2]),2,4));
      testData.data.collection.push(LibraryDLL.Item(bytes32(addresses[3]),3,5));
      testData.data.collection.push(LibraryDLL.Item(bytes32(addresses[4]),4,6));
      testData.data.collection.push(LibraryDLL.Item(bytes32(addresses[5]),5,0));
      testData.data.item_index[bytes32(addresses[0])] = 1;
      testData.data.item_index[bytes32(addresses[1])] = 2;
      testData.data.item_index[bytes32(addresses[2])] = 3;
      testData.data.item_index[bytes32(addresses[3])] = 4;
      testData.data.item_index[bytes32(addresses[4])] = 5;
      testData.data.item_index[bytes32(addresses[5])] = 6;
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

  function test_find(address _item)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = LibraryDLL.find(testData, _item);
  }

  function test_get(uint256 _item_index)
           returns (address _item)
  {
    _item = LibraryDLL.get(testData, _item_index);
  }

  function test_append(address _data)
           returns (bool _success)
  {
    _success = LibraryDLL.append(testData, _data);
  }

  function test_remove(uint256 _index)
           returns (bool _success)
  {
    _success = LibraryDLL.remove(testData, _index);
  }

  function test_remove_item(address _item)
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
           returns (address _item)
  {
    _item = LibraryDLL.start_item(testData);
  }

  function test_end ()
           returns (uint256 _end_index)
  {
    _end_index = LibraryDLL.end(testData);
  }

  function test_end_item ()
           returns (address _item)
  {
    _item = LibraryDLL.end_item(testData);
  }

  function test_valid(uint256 _item_index)
           returns (bool _yes)
  {
    _yes = LibraryDLL.valid(testData, _item_index);
  }

  function test_valid_item(address _item)
           returns (bool _yes)
  {
    _yes = LibraryDLL.valid_item(testData, _item);
  }

  function test_previous(uint256 _current_index)
           returns (uint256 _previous_index)
  {
    _previous_index = LibraryDLL.previous(testData, _current_index);
  }

  function test_previous_item(address _current_item)
           returns (address _previous_item)
  {
    _previous_item = LibraryDLL.previous_item(testData, _current_item);
  }

  function test_next(uint256 _current_index)
           returns (uint256 _next_index)
  {
    _next_index = LibraryDLL.next(testData, _current_index);
  }

  function test_next_item(address _current_item)
           returns (address _next_item)
  {
    _next_item = LibraryDLL.next_item(testData, _current_item);
  }

}
