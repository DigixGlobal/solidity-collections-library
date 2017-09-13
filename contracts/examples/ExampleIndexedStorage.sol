pragma solidity ^0.4.16;

import "../abstract/IndexedBytesIteratorStorage.sol";
import "../abstract/IndexedAddressIteratorStorage.sol";
import "../abstract/IndexedUintIteratorStorage.sol";

contract ExampleIndexedStorage is IndexedBytesIteratorStorage, IndexedAddressIteratorStorage, IndexedUintIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.IndexedBytes;
  using DoublyLinkedList for DoublyLinkedList.IndexedAddress;
  using DoublyLinkedList for DoublyLinkedList.IndexedUint;

  DoublyLinkedList.IndexedBytes indexed_bytes_collection;
  DoublyLinkedList.IndexedAddress indexed_address_collection;
  DoublyLinkedList.IndexedUint indexed_uint_collection;


  function ExampleIndexedStorage() {
  }

  function initialize() {
    indexed_bytes_collection.append("a", "atest1");
    indexed_bytes_collection.append("a", "atest2");
    indexed_bytes_collection.append("a", "atest3");
    indexed_bytes_collection.append("a", "atest4");
    indexed_bytes_collection.append("a", "atest5");
    indexed_bytes_collection.append("b", "btest1");
    indexed_bytes_collection.append("b", "btest2");
    indexed_bytes_collection.append("b", "btest3");
    indexed_bytes_collection.append("b", "btest4");
    indexed_bytes_collection.append("b", "btest5");
		indexed_address_collection.append("a", 0x7812421a7579d8182DC6f2B68Ab56595db01553F);
		indexed_address_collection.append("a", 0x419f0a80D85f3C7dC3553394d91c9A339332a01E);
		indexed_address_collection.append("a", 0xF5dFE2A3f8Cf5CA8723b51be6fc065beA0cFE893);
		indexed_address_collection.append("a", 0x5dc52D499a77af45f43174CFE7982dC68c331c38);
		indexed_address_collection.append("a", 0x727C89006bd885f9A77254797a362d69E8A1f4da);
		indexed_address_collection.append("b", 0x0F66eC3DF48eC1E216D24e225b772696e031B698);
		indexed_address_collection.append("b", 0x755eAc40A9017B52b6d811A2Ee3f495D08afb5eD);
		indexed_address_collection.append("b", 0xFd59C5dBB42666CF99a714EE5286C0280B6002Bd);
		indexed_address_collection.append("b", 0xF8954DA58BA81BFC29B5651029A71B0693b6Cd98);
		indexed_address_collection.append("b", 0x027a8620cAD4d536F3C2F9Fdeeb4490b1fa6833b);
    indexed_uint_collection.append("a", 1002);
    indexed_uint_collection.append("a", 1003);
    indexed_uint_collection.append("a", 1004);
    indexed_uint_collection.append("a", 1005);
    indexed_uint_collection.append("a", 1006);
    indexed_uint_collection.append("b", 2002);
    indexed_uint_collection.append("b", 2003);
    indexed_uint_collection.append("b", 2004);
    indexed_uint_collection.append("b", 2005);
    indexed_uint_collection.append("b", 2006);
  }

  function remove_all_data_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=5;i++) {
      indexed_bytes_collection.remove(_collection_index, i);
    }
    _success = indexed_bytes_collection.total(_collection_index) == 0;
  }

  function remove_all_data_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=5;i++) {
      indexed_address_collection.remove(_collection_index, i);
    }
    _success = indexed_address_collection.total(_collection_index) == 0;
  }


  function remove_all_data_in_indexed_uints_collection(bytes32 _collection_index)
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=6;i++) {
      indexed_uint_collection.remove(_collection_index, i);
    }
    _success = indexed_uint_collection.total(_collection_index) == 0;
  }

  function read_first_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_first_from_indexed_bytes_dll(indexed_bytes_collection, _collection_index);
  }

  function read_last_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_last_from_indexed_bytes_dll(indexed_bytes_collection, _collection_index);
  }

  function read_next_in_indexed_bytes_collection(bytes32 _collection_index, bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_next_from_indexed_bytes_dll(indexed_bytes_collection, _collection_index, _current_item);
  }

  function read_previous_in_indexed_bytes_collection(bytes32 _collection_index, bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_previous_from_indexed_bytes_dll(indexed_bytes_collection, _collection_index, _current_item);
  }

  function read_total_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_indexed_bytes_dll_total(indexed_bytes_collection, _collection_index);
  }


  function read_first_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (address _item)
  {
    _item = read_first_from_indexed_addresses_dll(indexed_address_collection, _collection_index);
  }

  function read_last_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (address _item)
  {
    _item = read_last_from_indexed_addresses_dll(indexed_address_collection, _collection_index);
  }

  function read_next_in_indexed_addresses_collection(bytes32 _collection_index, address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = read_next_from_indexed_addresses_dll(indexed_address_collection, _collection_index, _current_item);
  }

  function read_previous_in_indexed_addresses_collection(bytes32 _collection_index, address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = read_previous_from_indexed_addresses_dll(indexed_address_collection, _collection_index, _current_item);
  }

  function read_total_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_indexed_addresses_dll_total(indexed_address_collection, _collection_index);
  }

}
