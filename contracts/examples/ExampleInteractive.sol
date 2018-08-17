pragma solidity ^0.4.19;

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
  constructor(address _controller) public {
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
    @notice Lists collection of Bytes from the start or end
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items from start (or end)
    @return {"_collection_items":"Collection items"}
  */
  function list_bytes_collection(uint256 _count, bool _from_start)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_bytesarray(_count,
                                    example_controller().get_first_in_bytes_collection,
                                    example_controller().get_last_in_bytes_collection,
                                    example_controller().get_next_in_bytes_collection,
                                    example_controller().get_previous_in_bytes_collection,
                                    _from_start);
  }

  /**
    @notice Lists collection of Bytes starting from the specified `_current_item`, going forwards or backwards depending on `_from_start`
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items forwards (or backwards)
    @return {"_collection_items":"Collection items"}
  */
  function list_bytes_collection_from(bytes32 _current_item, uint256 _count, bool _from_start)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_bytesarray_from(_current_item,
                                              _count,
                                              example_controller().get_first_in_bytes_collection,
                                              example_controller().get_last_in_bytes_collection,
                                              example_controller().get_next_in_bytes_collection,
                                              example_controller().get_previous_in_bytes_collection,
                                              _from_start);
  }

  /**
    @notice Lists collection of Addresses from the start or end
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items from start (or end)
    @return {"_collection_items":"Collection items"}
  */
  function list_addresses_collection(uint256 _count, bool _from_start)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_addresses(_count,
                                    example_controller().get_first_in_addresses_collection,
                                    example_controller().get_last_in_addresses_collection,
                                    example_controller().get_next_in_addresses_collection,
                                    example_controller().get_previous_in_addresses_collection,
                                    _from_start);
  }

  /**
    @notice Lists collection of Addresses starting from the specified `_current_item`, going forwards or backwards depending on `_from_start`
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items forwards (or backwards)
    @return {"_collection_items":"Collection items"}
  */
  function list_addresses_collection_from(address _current_item, uint256 _count, bool _from_start)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_addresses_from(_current_item,
                                              _count,
                                              example_controller().get_first_in_addresses_collection,
                                              example_controller().get_last_in_addresses_collection,
                                              example_controller().get_next_in_addresses_collection,
                                              example_controller().get_previous_in_addresses_collection,
                                              _from_start);
  }

  /**
    @notice Lists collection of Uints from the start or end
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items from start (or end)
    @return {"_collection_items":"Collection items"}
  */
  function list_uints_collection(uint256 _count, bool _from_start)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_uints(_count,
                                    example_controller().get_first_in_uints_collection,
                                    example_controller().get_last_in_uints_collection,
                                    example_controller().get_next_in_uints_collection,
                                    example_controller().get_previous_in_uints_collection,
                                    _from_start);
  }

  /**
    @notice Lists collection of Uints starting from the specified `_current_item`, going forwards or backwards depending on `_from_start`
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items forwards (or backwards)
    @return {"_collection_items":"Collection items"}
  */
  function list_uints_collection_from(uint256 _current_item, uint256 _count, bool _from_start)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_uints_from(_current_item,
                                              _count,
                                              example_controller().get_first_in_uints_collection,
                                              example_controller().get_last_in_uints_collection,
                                              example_controller().get_next_in_uints_collection,
                                              example_controller().get_previous_in_uints_collection,
                                              _from_start);
  }

}
