pragma solidity ^0.4.16;

import "../abstract/BytesIteratorStorage.sol";
import "../abstract/AddressIteratorStorage.sol";
import "../abstract/UintIteratorStorage.sol";

/**
    @title Example Storage
    @author DigixGlobal Pte Ltd
 */
contract ExampleStorage is BytesIteratorStorage, AddressIteratorStorage, UintIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.Bytes;
  using DoublyLinkedList for DoublyLinkedList.Address;
  using DoublyLinkedList for DoublyLinkedList.Uint;

  DoublyLinkedList.Bytes bytes_collection;
  DoublyLinkedList.Address address_collection;
  DoublyLinkedList.Uint uint_collection;

  /**
    @notice Constructor
  */
  function ExampleStorage() {
    initialize();
  }

  /**
    @notice Initializes instace of collections
  */
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

  /**
    @notice Removes all the items in a Bytes collection
    @return {"_success":"True when all items are successfully deleted"}
  */
  function remove_all_data_in_bytes_collection()
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=6;i++) {
      bytes_collection.remove(i);
    }
    _success = bytes_collection.total() == 0;
  }

  /**
    @notice Removes all items in an Addresses collection
    @return {"_success":"True when all items are successfully deleted"}
  */
  function remove_all_data_in_addresses_collection()
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=6;i++) {
      address_collection.remove(i);
    }
    _success = address_collection.total() == 0;
  }

  /**
    @notice Removes all items in uints collection
    @return {"_success":"True when all items are successfully deleted"}
  */
  function remove_all_data_in_uints_collection()
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=6;i++) {
      uint_collection.remove(i);
    }
    _success = uint_collection.total() == 0;
  }

  /**
    @notice Reads the first item in the Bytes collection
    @return {"_item": "Collection item"}
  */
  function read_first_in_bytes_collection()
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_first_from_bytes_dll(bytes_collection);
  }

  /**
    @notice Reads the last item in the Bytes collection
    @return {"_item": "Collection item"}
  */
  function read_last_in_bytes_collection()
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_last_from_bytes_dll(bytes_collection);
  }

  /**
    @notice Reads the next item in the Bytes collection starting from the specified `_current_item`
    @return {"_item": "Collection item"}
  */
  function read_next_in_bytes_collection(bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_next_from_bytes_dll(bytes_collection, _current_item);
  }

  /**
    @notice Reads the previous item in the Bytes collection starting from the specified `_current_item`
    @return {"_item": "Collection item"}
  */
  function read_previous_in_bytes_collection(bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_previous_from_bytes_dll(bytes_collection, _current_item);
  }

  /**
    @notice Reads the total number of items in the Bytes collection
    @return {"_total_count": "Total number of items in the Bytes collection"}
  */
  function read_total_in_bytes_collection()
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_bytes_dll_total(bytes_collection);
  }

  /**
    @notice Reads the first item in the Addresses collection
    @return {"_item": "Collection item"}
  */
  function read_first_in_addresses_collection()
           public
           constant
           returns (address _item)
  {
    _item = read_first_from_addresses_dll(address_collection);
  }

  /**
    @notice Reads the last item in the Address collection
    @return {"_item": "Collection item"}
  */
  function read_last_in_addresses_collection()
           public
           constant
           returns (address _item)
  {
    _item = read_last_from_addresses_dll(address_collection);
  }

  /**
    @notice Reads the next item in the Addresses collection
    @return {"_item": "Collection item"}
  */
  function read_next_in_addresses_collection(address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = read_next_from_addresses_dll(address_collection, _current_item);
  }

  /**
    @notice Reads the previous item in the Addresses collection
    @return {"_item": "Collection item"}
  */
  function read_previous_in_addresses_collection(address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = read_previous_from_addresses_dll(address_collection, _current_item);
  }

  /**
    @notice Reads the total number of items in the Addresses collection
    @return {"_total_count": "Total number of items in the Address collection"}
  */
  function read_total_in_addresses_collection()
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_addresses_dll_total(address_collection);
  }


  /*
    @notice Reads the first item in the uints collection
    @return {"_item": "Collection item"}
  */
  function read_first_in_uints_collection()
           public
           constant
           returns (uint256 _item)
  {
    _item = read_first_from_uints_dll(uint_collection);
  }

  /**
    @notice Reads the last item in the uints collection
    @return {"_item": "Collection item"} 
   */
  function read_last_in_uints_collection()
           public
           constant
           returns (uint256 _item)
  {
    _item = read_last_from_uints_dll(uint_collection);
  }

  /**
    @notice Reads the next item from the uints collection starting from the specified `_current_item`
    @return {"_item": "Collection item"}
  */
  function read_next_in_uints_collection(uint256 _current_item)
           public
           constant
           returns (uint256 _item)
  {
    _item = read_next_from_uints_dll(uint_collection, _current_item);
  }

  /**
    @notice Reads the previous item from the uints collection starting from the specified `_current_item`
    @return {"_item": "Collection item"}
  */
  function read_previous_in_uints_collection(uint256 _current_item)
           public
           constant
           returns (uint256 _item)
  {
    _item = read_previous_from_uints_dll(uint_collection, _current_item);
  }

  /**
    @notice Reads the total number of items in the uints collection
    @return {"_total_count": "Total number of items in the uints collection"}
  */
  function read_total_in_uints_collection()
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_uints_dll_total(uint_collection);
  }

}
