pragma solidity ^0.4.16;

import "../abstract/BytesIteratorInteractive.sol";
import "../abstract/AddressIteratorInteractive.sol";
import "../abstract/UintIteratorInteractive.sol";
import "./ExampleController.sol";
/**
    @title Example Interactive
    @author DigixGlobal Pte Ltd
 */
contract ExampleInteractive is BytesIteratorInteractive, AddressIteratorInteractive, UintIteratorInteractive {

  /**
    @notice Publice state for Controller contract
  */
  address public controller_contract;

  /**
    @notice Constructor
  */
  function ExampleInteractive(address _controller) {
    controller_contract = _controller;
  }

  /**
    @notice initializes an instance of an Example Controller
  */
  function example_controller()
           internal
           constant
           returns (ExampleController _contract)
  {
    _contract = ExampleController(controller_contract);
  }

  /**
    @notice Lists collection of Bytes from the start
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_bytes_collection_from_start(uint256 _count)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_bytes_from_start(_count,
                                              example_controller().get_total_in_bytes_collection,
                                              example_controller().get_first_in_bytes_collection,
                                              example_controller().get_next_in_bytes_collection);
  }

  /**
    @notice Lists collection of Bytes in reverse order from the end
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_bytes_collection_backwards_from_end(uint256 _count)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_bytes_backwards_from_end(_count,
                                              example_controller().get_total_in_bytes_collection,
                                              example_controller().get_last_in_bytes_collection,
                                              example_controller().get_previous_in_bytes_collection);
  }

  /**
    @notice Lists collection of Bytes starting from the specified `_current_item`
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_bytes_collection_from_item(bytes32 _current_item, uint256 _count)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_bytes_from_bytes(_current_item, 
                                              _count,
                                              example_controller().get_last_in_bytes_collection,
                                              example_controller().get_next_in_bytes_collection);
  }

  /**
    @notice Lists collection of Bytes in reverse starting from the specified `_current_item`
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_bytes_collection_backwards_from_item(bytes32 _current_item, uint256 _count)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_bytes_backwards_from_bytes(_current_item, 
                                              _count,
                                              example_controller().get_first_in_bytes_collection,
                                              example_controller().get_previous_in_bytes_collection);
  }

  /**
    @notice Lists collection of Addresses from the start
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_addresses_collection_from_start(uint256 _count)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_addresses_from_start(_count,
                                                  example_controller().get_total_in_addresses_collection,
                                                  example_controller().get_first_in_addresses_collection,
                                                  example_controller().get_next_in_addresses_collection);
  }

  /**
    @notice Lists collection of Addresses in reverse order starting from the end
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_addresses_collection_backwards_from_end(uint256 _count)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_addresses_backwards_from_end(_count,
                                                  example_controller().get_total_in_addresses_collection,
                                                  example_controller().get_last_in_addresses_collection,
                                                  example_controller().get_previous_in_addresses_collection);
  }

  /**
    @notice Lists collection of Addresses starting from the specified `_current_item`
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_addresses_collection_from_item(address _current_item, uint256 _count)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_addresses_from_address(_current_item, 
                                                    _count,
                                                    example_controller().get_last_in_addresses_collection,
                                                    example_controller().get_next_in_addresses_collection);
  }

  /**
    @notice Lists collection of Addresses in reverse order starting from the specififed `_current_item`
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_addresses_collection_backwards_from_item(address _current_item, uint256 _count)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_addresses_backwards_from_address(_current_item, 
                                                    _count,
                                                    example_controller().get_first_in_addresses_collection,
                                                    example_controller().get_previous_in_addresses_collection);
  }


  /**
    @notice Lists collection of uints from the start
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_uints_collection_from_start(uint256 _count)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_uints_from_start(_count,
                                                  example_controller().get_total_in_uints_collection,
                                                  example_controller().get_first_in_uints_collection,
                                                  example_controller().get_next_in_uints_collection);
  }

  /**
    @notice Lists collection of uints in reverse order starting from the end
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_uints_collection_backwards_from_end(uint256 _count)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_uints_backwards_from_end(_count,
                                                  example_controller().get_total_in_uints_collection,
                                                  example_controller().get_last_in_uints_collection,
                                                  example_controller().get_previous_in_uints_collection);
  }

  /**
    @notice Lists collection of uints starting from the specified `_current_item`
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_uints_collection_from_item(uint256 _current_item, uint256 _count)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_uints_from_uint(_current_item, 
                                                    _count,
                                                    example_controller().get_last_in_uints_collection,
                                                    example_controller().get_next_in_uints_collection);
  }

  /**
    @notice Lists collection of uints in reverse order starting from the specified `_current_item`
    @param _count The Total number of items you wish to be returned
    @return {"_collection_items":"Collection items"}
  */
  function list_uints_collection_backwards_from_item(uint256 _current_item, uint256 _count)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_uints_backwards_from_uint(_current_item, 
                                                    _count,
                                                    example_controller().get_first_in_uints_collection,
                                                    example_controller().get_previous_in_uints_collection);
  }
}


