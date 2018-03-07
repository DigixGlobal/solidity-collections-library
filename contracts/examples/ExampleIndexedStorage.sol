pragma solidity ^0.4.19;

import "../abstract/IndexedBytesIteratorStorage.sol";
import "../abstract/IndexedAddressIteratorStorage.sol";
import "../abstract/IndexedUintIteratorStorage.sol";
/**
    @title Example Indexed Storage
    @author DigixGlobal Pte Ltd
 */
contract ExampleIndexedStorage is IndexedBytesIteratorStorage, IndexedAddressIteratorStorage, IndexedUintIteratorStorage {

  using DoublyLinkedList for DoublyLinkedList.IndexedBytes;
  using DoublyLinkedList for DoublyLinkedList.IndexedAddress;
  using DoublyLinkedList for DoublyLinkedList.IndexedUint;

  DoublyLinkedList.IndexedBytes indexed_bytes_collection;
  DoublyLinkedList.IndexedAddress indexed_address_collection;
  DoublyLinkedList.IndexedUint indexed_uint_collection;

  /**
    @notice Constructor
  */
  function ExampleIndexedStorage() public {
    initialize();
  }

  /**
    @notice Initializes a list of collections
  */
  function initialize() public {
    indexed_bytes_collection.append("a", "atest1");
    indexed_bytes_collection.append("a", "atest2");
    indexed_bytes_collection.append("a", "atest3");
    indexed_bytes_collection.append("a", "atest4");
    indexed_bytes_collection.append("a", "atest5");
    indexed_bytes_collection.append("a", "atest6");
    /*indexed_bytes_collection.append("b", "btest1");
    indexed_bytes_collection.append("b", "btest2");
    indexed_bytes_collection.append("b", "btest3");
    indexed_bytes_collection.append("b", "btest4");
    indexed_bytes_collection.append("b", "btest5");*/
    indexed_address_collection.append("a", 0x7812421a7579d8182DC6f2B68Ab56595db01553F);
    indexed_address_collection.append("a", 0x419f0a80D85f3C7dC3553394d91c9A339332a01E);
    indexed_address_collection.append("a", 0xF5dFE2A3f8Cf5CA8723b51be6fc065beA0cFE893);
    indexed_address_collection.append("a", 0x5dc52D499a77af45f43174CFE7982dC68c331c38);
    indexed_address_collection.append("a", 0x727C89006bd885f9A77254797a362d69E8A1f4da);
    indexed_address_collection.append("a", 0x0F66eC3DF48eC1E216D24e225b772696e031B698);
		/*indexed_address_collection.append("b", 0x0F66eC3DF48eC1E216D24e225b772696e031B698);
		indexed_address_collection.append("b", 0x755eAc40A9017B52b6d811A2Ee3f495D08afb5eD);
		indexed_address_collection.append("b", 0xFd59C5dBB42666CF99a714EE5286C0280B6002Bd);
		indexed_address_collection.append("b", 0xF8954DA58BA81BFC29B5651029A71B0693b6Cd98);
		indexed_address_collection.append("b", 0x027a8620cAD4d536F3C2F9Fdeeb4490b1fa6833b);*/

    indexed_uint_collection.append("a", 1002);
    indexed_uint_collection.append("a", 1003);
    indexed_uint_collection.append("a", 1004);
    indexed_uint_collection.append("a", 1005);
    indexed_uint_collection.append("a", 1006);
    indexed_uint_collection.append("a", 1007);

    /*indexed_uint_collection.append("b", 2002);
    indexed_uint_collection.append("b", 2003);
    indexed_uint_collection.append("b", 2004);
    indexed_uint_collection.append("b", 2005);
    indexed_uint_collection.append("b", 2006);*/
  }

  /**
    @notice Removes all data in the Indexed Bytes Collection
    @param _collection_index The source collection to be delete
    @return {"_success":"True if all items were successfully removed"}d
  */
  function remove_all_data_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=6;i++) {
      indexed_bytes_collection.remove(_collection_index, i);
    }
    _success = indexed_bytes_collection.total(_collection_index) == 0;
  }

  /**
    @notice Removes all data in the Indexed Addreses collection
    @param _collection_index The source collection to be deleted
    @return {"_success":"True if all items were successfully removed"}
  */
  function remove_all_data_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=6;i++) {
      indexed_address_collection.remove(_collection_index, i);
    }
    _success = indexed_address_collection.total(_collection_index) == 0;
  }

  /**
    @notice Removes all data in the Indexed Uints collection
    @param _collection_index The source collection to be deleted
    @return {"_item":"Collection item"}
  */
  function remove_all_data_in_indexed_uints_collection(bytes32 _collection_index)
           public
           returns (bool _success)
  {
    for (uint256 i=1;i<=6;i++) {
      indexed_uint_collection.remove(_collection_index, i);
    }
    _success = indexed_uint_collection.total(_collection_index) == 0;
  }

  /**
    @notice Reads the first item in the Indexed Bytes collection
    @param _collection_index The source collection to be evaluate
    @return {"_item":"Collection item"}
  */
  function read_first_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_first_from_indexed_bytesarray(indexed_bytes_collection, _collection_index);
  }

  /**
    @notice Reads the last item in the Indexed Bytes collection
    @param _collection_index The source collection to evaluate
    @return {"_item":"Collection item"}
  */
  function read_last_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_last_from_indexed_bytesarray(indexed_bytes_collection, _collection_index);
  }

  /**
    @notice Reads the Next Indexed Bytes collection from the specified `_collection_index` and `_current_item`
    @param _collection_index The source collection to evaluate
    @param _current_item The item to be used as base line
    @return {"_item":"Collection item"}
  */
  function read_next_in_indexed_bytes_collection(bytes32 _collection_index, bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_next_from_indexed_bytesarray(indexed_bytes_collection, _collection_index, _current_item);
  }

  /**
    @notice Reads the Previous Indexed Bytes collection from the specified `_collection_index` and `_current_item`
    @param _collection_index The source collection to evaluate
    @param _current_item The item to be used as base line
    @return {"_item":"Collection item"}
  */
  function read_previous_in_indexed_bytes_collection(bytes32 _collection_index, bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = read_previous_from_indexed_bytesarray(indexed_bytes_collection, _collection_index, _current_item);
  }

  /**
    @notice Reads the Total number of items in an Indexed Bytes collection
    @param _collection_index The source collection to evaluate
    @return {"_item":"Collection item"}
  */
  function read_total_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_total_indexed_bytesarray(indexed_bytes_collection, _collection_index);
  }

  /**
    @notice Reads the First item in an Indexed Address collection
    @param _collection_index The source collection to evaluate
    @return {"_item":"Collection item"}
  */
  function read_first_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (address _item)
  {
    _item = read_first_from_indexed_addresses(indexed_address_collection, _collection_index);
  }

  /**
    @notice Reads the Last item in an Indexed Addresses collection
    @param _collection_index The source collection to evaluate
    @return {"_item":"Collection item"}
  */
  function read_last_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (address _item)
  {
    _item = read_last_from_indexed_addresses(indexed_address_collection, _collection_index);
  }

  /**
    @notice Reads the Next item from an Indexed Addresses collection using the specified `_collection_index` and `_current_item`
    @param _collection_index The source collection to evaluate
    @return {"_item":"Collection item"}
  */
  function read_next_in_indexed_addresses_collection(bytes32 _collection_index, address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = read_next_from_indexed_addresses(indexed_address_collection, _collection_index, _current_item);
  }

  /**
    @notice Reads the Previous item from an Indexed Addresses collection using the specified `_collection_index` and `_current_item`
    @param _collection_index The source collection to evaluate
    @return {"_item":"Collection item"}
  */
  function read_previous_in_indexed_addresses_collection(bytes32 _collection_index, address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = read_previous_from_indexed_addresses(indexed_address_collection, _collection_index, _current_item);
  }

  /**
    @notice Reads the Total number of items in an Indexed Addresses collection
    @param _collection_index The source collection to evaluate
    @return {"_total_count":"Total number of items"}
  */
  function read_total_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_total_indexed_addresses(indexed_address_collection, _collection_index);
  }

  /**
    @notice Reads the First item in an Indexed Uints collection
    @param _collection_index The source collection to evaluate
    @return {"_item":"Collection item"}
  */
  function read_first_in_indexed_uints_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _item)
  {
    _item = read_first_from_indexed_uints(indexed_uint_collection, _collection_index);
  }

  /**
    @notice Reads the Last item in an Indexed Uints collection
    @param _collection_index The source collection to evaluate
    @return {"_item":"Collection item"}
  */
  function read_last_in_indexed_uints_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _item)
  {
    _item = read_last_from_indexed_uints(indexed_uint_collection, _collection_index);
  }

  /**
    @notice Reads the Next item from an Indexed Uints collection using the specified `_collection_index` and `_current_item`
    @param _collection_index The source collection to evaluate
    @return {"_item":"Collection item"}
  */
  function read_next_in_indexed_uints_collection(bytes32 _collection_index, uint256 _current_item)
           public
           constant
           returns (uint256 _item)
  {
    _item = read_next_from_indexed_uints(indexed_uint_collection, _collection_index, _current_item);
  }

  /**
    @notice Reads the Previous item from an Indexed Uints collection using the specified `_collection_index` and `_current_item`
    @param _collection_index The source collection to evaluate
    @return {"_item":"Collection item"}
  */
  function read_previous_in_indexed_uints_collection(bytes32 _collection_index, uint256 _current_item)
           public
           constant
           returns (uint256 _item)
  {
    _item = read_previous_from_indexed_uints(indexed_uint_collection, _collection_index, _current_item);
  }

  /**
    @notice Reads the Total number of items in an Indexed Uints collection
    @param _collection_index The source collection to evaluate
    @return {"_total_count":"Total number of items"}
  */
  function read_total_in_indexed_uints_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = read_total_indexed_uints(indexed_uint_collection, _collection_index);
  }
}
