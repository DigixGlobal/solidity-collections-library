pragma solidity ^0.4.19;

import "../abstract/IndexedBytesIteratorController.sol";
import "../abstract/IndexedAddressIteratorController.sol";
import "../abstract/IndexedUintIteratorController.sol";
import "./ExampleIndexedStorage.sol";

/**
  @title Example Indexed Controller
  @author DigixGlobal Pte Ltd
  @notice This contract utilizes: [Indexed Bytes Iterator Controller](/IndexedBytesIteratorController),
                                  [Indexed Address Iterator Controller](/IndexedAddressIteratorController),
                                  [Indexed UintIterator Controller](/IndexedUintIteratorController),
                                  [Example Indexed Storage](/ExampleIndexedStorage)
*/
contract ExampleIndexedController is IndexedBytesIteratorController, IndexedAddressIteratorController, IndexedUintIteratorController {


  /// @notice State to be used as holder for the specified storage
  /// @dev This example controller inherits from [IndexedBytesIteratorController](/IndexedBytesIteratorController),
  ///    [IndexedAddressIteratorController](/IndexedAddressIteratorController), [IndexedUintIteratorController](IndexedUintIteratorController)
  address public storage_contract;

  /**
    @notice Constructor for ExampleIndexedController
    @param _storage Address of storage to use
  */
  constructor(address _storage) public {
    storage_contract = _storage;
  }

  /**
    @notice Initializes an instance of Example Storage
  */
  function example_storage()
           internal
           constant
           returns (ExampleIndexedStorage _contract)
  {
    _contract = ExampleIndexedStorage(storage_contract);
  }

  /**
    @notice Gets the first item of an Indexed Bytes collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"Collection item"}
  */
  function get_first_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_first_from_indexed_bytesarray(example_storage().read_first_in_indexed_bytes_collection, _collection_index);
  }

  /**
    @notice Gets the last item of an Indexed Bytes collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"Collection item"}
  */
  function get_last_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_last_from_indexed_bytesarray(example_storage().read_last_in_indexed_bytes_collection, _collection_index);
  }

  /**
    @notice Gets the next item of an Indexed Bytes collection based on the specified `_current_item`
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The item to be used as base line
    @return {"_item":"Collection item"}
  */
  function get_next_in_indexed_bytes_collection(bytes32 _collection_index, bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_next_from_indexed_bytesarray(example_storage().read_next_in_indexed_bytes_collection, _collection_index, _current_item);
  }

  /**
    @notice Gets the previous item of an Indexed Bytes collection based on the specified `_current_item`
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The item to be used as base line
    @return {"_item":"Collection item"}
  */
  function get_previous_in_indexed_bytes_collection(bytes32 _collection_index, bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_previous_from_indexed_bytesarray(example_storage().read_previous_in_indexed_bytes_collection, _collection_index, _current_item);
  }

  /**
    @notice Gets the total number of items in the Indexed Bytes collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"Collection item"}
  */
  function get_total_in_indexed_bytes_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = get_total_indexed_bytesarray(example_storage().read_total_in_indexed_bytes_collection, _collection_index);
  }

  /**
    @notice Gets the first item in an Indexed Addresses collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"Collection item"}
  */
  function get_first_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (address _item)
  {
    _item = get_first_from_indexed_addresses(example_storage().read_first_in_indexed_addresses_collection, _collection_index);
  }

  /**
    @notice Gets the last item in an Indexed Addresses collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"Collection item"}
  */
  function get_last_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (address _item)
  {
    _item = get_last_from_indexed_addresses(example_storage().read_last_in_indexed_addresses_collection, _collection_index);
  }

  /**
    @notice Gets the next item in an Indexed Addresses collection based on the specified `_current_item`
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The item the be used as base line
    @return {"_item":"Collection item"}
  */
  function get_next_in_indexed_addresses_collection(bytes32 _collection_index, address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = get_next_from_indexed_addresses(example_storage().read_next_in_indexed_addresses_collection, _collection_index, _current_item);
  }


  /**
    @notice Gets the previous item in an Indexed Addresses collection based on the specified `_current_item`
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The item to be used as base line
    @return {"_item":"Collection item"}
  */
  function get_previous_in_indexed_addresses_collection(bytes32 _collection_index, address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = get_previous_from_indexed_addresses(example_storage().read_previous_in_indexed_addresses_collection, _collection_index, _current_item);
  }

  /**
    @notice Gets the total number of items in an Indexed Addresses collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"Collection item"}
  */
  function get_total_in_indexed_addresses_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = get_total_indexed_addresses(example_storage().read_total_in_indexed_addresses_collection, _collection_index);
  }

  /**
    @notice Gets the first item in an Indexed Uints collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"Collection item"}
  */
  function get_first_in_indexed_uints_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _item)
  {
    _item = get_first_from_indexed_uints(example_storage().read_first_in_indexed_uints_collection, _collection_index);
  }

  /**
    @notice Gets the last item in an Indexed Uints collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"Collection item"}
  */
  function get_last_in_indexed_uints_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _item)
  {
    _item = get_last_from_indexed_uints(example_storage().read_last_in_indexed_uints_collection, _collection_index);
  }

  /**
    @notice Gets the next item in an Indexed Uints collection based on the specified `_current_item`
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The item the be used as base line
    @return {"_item":"Collection item"}
  */
  function get_next_in_indexed_uints_collection(bytes32 _collection_index, uint256 _current_item)
           public
           constant
           returns (uint256 _item)
  {
    _item = get_next_from_indexed_uints(example_storage().read_next_in_indexed_uints_collection, _collection_index, _current_item);
  }


  /**
    @notice Gets the previous item in an Indexed Uints collection based on the specified `_current_item`
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The item to be used as base line
    @return {"_item":"Collection item"}
  */
  function get_previous_in_indexed_uints_collection(bytes32 _collection_index, uint256 _current_item)
           public
           constant
           returns (uint256 _item)
  {
    _item = get_previous_from_indexed_uints(example_storage().read_previous_in_indexed_uints_collection, _collection_index, _current_item);
  }

  /**
    @notice Gets the total number of items in an Indexed Uints collection
    @param _collection_index Index of the Collection to evaluate
    @return {"_item":"Collection item"}
  */
  function get_total_in_indexed_uints_collection(bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = get_total_indexed_uints(example_storage().read_total_in_indexed_uints_collection, _collection_index);
  }
}
