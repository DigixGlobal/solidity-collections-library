pragma solidity ^0.4.14;

import "../abstract/BytesIteratorStorage.sol";

contract ExampleStorage is BytesIteratorStorage {

  using LibraryDLL for LibraryDLL.BytesDLL;
  LibraryDLL.BytesDLL collection;

  function ExampleStorage() {
    initialize();
  }

  function initialize() {
    collection.append("test1");
    collection.append("test2");
    collection.append("test3");
    collection.append("test4");
    collection.append("test5");
    collection.append("test6");
  }

  function read_first_in_collection()
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_first_from_bytes_dll(collection);
  }

  function read_last_in_collection()
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_last_from_bytes_dll(collection);
  } 

  function read_next_in_collection(bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_next_from_bytes_dll(collection, _current_item);
  }

  function read_previous_in_collection(bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_previous_from_bytes_dll(collection, _current_item);
  }

  function read_total_in_collection()
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_bytes_dll_total(collection);
  }

}
