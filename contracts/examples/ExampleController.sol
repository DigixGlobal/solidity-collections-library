pragma solidity ^0.4.16;

import "../abstract/BytesIteratorController.sol";
import "../abstract/AddressIteratorController.sol";
import "../abstract/UintIteratorController.sol";
import "./ExampleStorage.sol";

/**
  @title Example Controller
  @author DigixGlobal Pte Ltd
  @notice this contract utilizes: [Bytes Iterator Controller](/BytesIteratorController),
                                  [Address Iterator Controller](/AddressIteratorController),
                                  [Uint Iterator Controller](/UintIteratorController),
                                  [Example Storage](/ExampleStorage)
*/
contract ExampleController is BytesIteratorController, AddressIteratorController, UintIteratorController {

  address public storage_contract;

  /**
    @notice Constructor for ExampleController
    @param _storage Adress of storage to use
  */
  function ExampleController(address _storage) {
    storage_contract = _storage;
  }

  /**
    @notice Initializes an instance of Example storage
  */
  function example_storage()
           internal
           constant
           returns (ExampleStorage _contract)
  {
    _contract = ExampleStorage(storage_contract);
  }

  /**
    @notice Gets the first item in the Bytes collection
    @return {"_item":"Collection item"}
  */
  function get_first_in_bytes_collection()
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_first_from_bytes_dll(example_storage().read_first_in_bytes_collection);
  }

  /** 
    @notice Gets the last item in the Bytes collection
    @return {"_item":"Collection item"}
  */
  function get_last_in_bytes_collection()
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_last_from_bytes_dll(example_storage().read_last_in_bytes_collection);
    
  }

  /**
    @notice Gets the next item in the Bytes collection based on the specified `_current_item`
    @param _current_item The current item to be used as base line
    @return {"_item":"Collection item"}
  */
  function get_next_in_bytes_collection(bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_next_from_bytes_dll(example_storage().read_next_in_bytes_collection, _current_item);
  }

  /**
    @notice Gets the previous imte in the Bytes collection based on the specified `_current_item`
    @param _current_item The current item to be used as base line
    @return {"_item":"Collection item"}
  */
  function get_previous_in_bytes_collection(bytes32 _current_item)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get_previous_from_bytes_dll(example_storage().read_previous_in_bytes_collection, _current_item);
  }

  /**
    @notice Gets the Total number of items in the Bytes collection
    @return {"_total_count":"The Toal number of items in the collection"}
  */
  function get_total_in_bytes_collection()
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = get_total_in_bytes_dll(example_storage().read_total_in_bytes_collection);
  }

  /**
    @notice Gets the first item in the Addresses collection
    @return {"_item":"Collection item"}
  */
  function get_first_in_addresses_collection()
           public
           constant
           returns (address _item)
  {
    _item = get_first_from_addresses_dll(example_storage().read_first_in_addresses_collection);
  }

  /**
    @notice Gets the last item in the Addresses collection
    @return {"_item":"Collection item"}
  */
  function get_last_in_addresses_collection()
           public
           constant
           returns (address _item)
  {
    _item = get_last_from_addresses_dll(example_storage().read_last_in_addresses_collection);
  }

  /**
    @notice Gets the next item in the Addresses collection based on the specified `_current_item`
    @return {"_item":"Collection item"}
  */
  function get_next_in_addresses_collection(address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = get_next_from_addresses_dll(example_storage().read_next_in_addresses_collection, _current_item);
  }

  /**
    @notice Gets the previous item in the Addresses collection based on the specified `_current_item`
    @return {"_item":"Collection item"}
  */
  function get_previous_in_addresses_collection(address _current_item)
           public
           constant
           returns (address _item)
  {
    _item = get_previous_from_addresses_dll(example_storage().read_previous_in_addresses_collection, _current_item);
  }

  /**
    @notice Gets the total number of addresses in the Addresses collection
    @return {"_item":"Collection item"}
  */
  function get_total_in_addresses_collection()
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = get_total_in_addresses_dll(example_storage().read_total_in_addresses_collection);
  }


  /**
    @notice Gets the first item in the uints collection
    @return {"_item":"Collection item"}
  */
  function get_first_in_uints_collection()
           public
           constant
           returns (uint256 _item)
  {
    _item = get_first_from_uints_dll(example_storage().read_first_in_uints_collection);
  }

  /**
    @notice Gets the last item in the uints collection
    @return {"_item":"Collection item"}
  */
  function get_last_in_uints_collection()
           public
           constant
           returns (uint256 _item)
  {
    _item = get_last_from_uints_dll(example_storage().read_last_in_uints_collection);
  }

  /**
    @notice Gets the next item in the uints collection based on the specified `_current_item`
    @param _current_item The item to be used as base line
    @return {"_item":"Collection item"}
  */
  function get_next_in_uints_collection(uint256 _current_item)
           public
           constant
           returns (uint256 _item)
  {
    _item = get_next_from_uints_dll(example_storage().read_next_in_uints_collection, _current_item);
  }

  /**
    @notice Gets the previous item in the uints collection based on the specified `_current_item`
    @param _current_item The item to be used as base line
    @return {"_item":"Collection item"}
  */
  function get_previous_in_uints_collection(uint256 _current_item)
           public
           constant
           returns (uint256 _item)
  {
    _item = get_previous_from_uints_dll(example_storage().read_previous_in_uints_collection, _current_item);
  }

  /**
    @notice Gets the total number of uints in the uints collection
    @return {"_item":"Collection item"}
  */
  function get_total_in_uints_collection()
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = get_total_in_uints_dll(example_storage().read_total_in_uints_collection);
  }
}
