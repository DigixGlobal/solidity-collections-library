pragma solidity ^0.4.16;

import "../abstract/BytesIteratorStorage.sol";
import "../abstract/AddressIteratorStorage.sol";
import "../abstract/UintIteratorStorage.sol";

contract ExampleStorage is BytesIteratorStorage, AddressIteratorStorage, UintIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.Bytes;
  using DoublyLinkedList for DoublyLinkedList.Address;
  using DoublyLinkedList for DoublyLinkedList.Uint;

  DoublyLinkedList.Bytes bytes_collection;
  DoublyLinkedList.Address address_collection;
  DoublyLinkedList.Uint uint_collection;


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

		address_collection.append(0x7812421a7579d8182DC6f2B68Ab56595db01553F);
		address_collection.append(0x419f0a80D85f3C7dC3553394d91c9A339332a01E);
		address_collection.append(0xF5dFE2A3f8Cf5CA8723b51be6fc065beA0cFE893);
		address_collection.append(0x5dc52D499a77af45f43174CFE7982dC68c331c38);
		address_collection.append(0x727C89006bd885f9A77254797a362d69E8A1f4da);
		address_collection.append(0x0F66eC3DF48eC1E216D24e225b772696e031B698);

    uint_collection.append(1002);
    uint_collection.append(1003);
    uint_collection.append(1004);
    uint_collection.append(1005);
    uint_collection.append(1006);
    uint_collection.append(1007);
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


  function remove_all_data_in_uints_collection()
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=6;i++) {
      uint_collection.remove(i);
    }
    _success = uint_collection.total() == 0;
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
