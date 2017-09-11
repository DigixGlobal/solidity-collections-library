pragma solidity ^0.4.16;

import "../abstract/BytesIteratorStorage.sol";
import "../abstract/AddressIteratorStorage.sol";

contract ExampleStorage is BytesIteratorStorage, AddressIteratorStorage {

  using LibraryDLL for LibraryDLL.BytesDLL;
  using LibraryDLL for LibraryDLL.AddressDLL;
  LibraryDLL.BytesDLL bytes_collection;
  LibraryDLL.AddressDLL address_collection;

  function ExampleStorage() {
    initialize();
  }

  function initialize() {
    bytes_collection.append("test1");
    bytes_collection.append("test2");
    bytes_collection.append("test3");
    bytes_collection.append("test4");
    bytes_collection.append("test5");
    bytes_collection.append("test6");
    address_collection.append(0xb1b8c0e568591f7b71f825be26087a82ddda17b2);
    address_collection.append(0x66ba92773feeef8cc0ddfdc8b6adc87ede1a0ec3);
    address_collection.append(0x9a8cf272691f844e243e7712ca6f3c0d5f6bc94b);
    address_collection.append(0x3c5ce67a06e4fb06022dce62737288bede746ffa);
    address_collection.append(0x7046f6f2125b7148cb96183d2f3ac19781a2dffc);
    address_collection.append(0xd2b90da1b96cbe2aa1b23172dd6d8d77903a92a8);
  }

  function remove_all_data_in_bytes_collection()
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=6;i++) {
      bytes_collection.remove(i);
    }
    _success = bytes_collection.total() == 0;
  }

  function remove_all_data_in_addresses_collection()
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=6;i++) {
      address_collection.remove(i);
    }
    _success = address_collection.total() == 0;
  }

  /*function test_total()
           returns (uint256 _count)
  {
    _count = bytes_collection.total();
  }*/

  function read_first_in_bytes_collection()
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_first_from_bytes_dll(bytes_collection);
  }

  function read_last_in_bytes_collection()
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_last_from_bytes_dll(bytes_collection);
  }

  function read_next_in_bytes_collection(bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_next_from_bytes_dll(bytes_collection, _current_item);
  }

  function read_previous_in_bytes_collection(bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_previous_from_bytes_dll(bytes_collection, _current_item);
  }

  function read_total_in_bytes_collection()
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_bytes_dll_total(bytes_collection);
  }


  function read_first_in_addresses_collection()
           public
           constant
           returns (address _item)
  {
    _item = read_first_from_addresses_dll(address_collection);
  }

  function read_last_in_addresses_collection()
           public
           constant
           returns (address _item)
  {
    _item = read_last_from_addresses_dll(address_collection);
  }

  function read_next_in_addresses_collection(address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = read_next_from_addresses_dll(address_collection, _current_item);
  }

  function read_previous_in_addresses_collection(address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = read_previous_from_addresses_dll(address_collection, _current_item);
  }

  function read_total_in_addresses_collection()
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_addresses_dll_total(address_collection);
  }

}
