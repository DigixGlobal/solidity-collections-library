pragma solidity ^0.4.19;

import "../abstract/IndexedBytesIteratorInteractive.sol";
import "../abstract/IndexedAddressIteratorInteractive.sol";
import "../abstract/IndexedUintIteratorInteractive.sol";
import "./ExampleIndexedController.sol";
  /**
    @title Example Indexed Interactive
    @author DigixGlobal Pte Ltd
 */
contract ExampleIndexedInteractive is IndexedBytesIteratorInteractive, IndexedAddressIteratorInteractive, IndexedUintIteratorInteractive {

  address public controller_contract;

  /**
    @notice Constructor
    @param _controller The Controller to use
  */
  constructor(address _controller) public {
    controller_contract = _controller;
  }

  /**
    @notice Initializes an instance of ExampleIndexedController
  */
  function example_controller()
           internal
           constant
           returns (ExampleIndexedController _contract)
  {
    _contract = ExampleIndexedController(controller_contract);
  }


  /**
    @notice Lists collection of indexed Bytes from the start or end
    @param _collection_index The Index of the Collection to evaluate
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items from start (or end)
    @return {"_collection_items":"Collection items"}
  */
  function list_indexed_bytes_collection(bytes32 _collection_index, uint256 _count, bool _from_start)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_indexed_bytesarray(_collection_index, _count,
                                    example_controller().get_first_in_indexed_bytes_collection,
                                    example_controller().get_last_in_indexed_bytes_collection,
                                    example_controller().get_next_in_indexed_bytes_collection,
                                    example_controller().get_previous_in_indexed_bytes_collection,
                                    _from_start);
  }

  /**
    @notice Lists collection of Bytes starting from the specified `_current_item`, going forwards or backwards depending on `_from_start`
    @param _collection_index The Index of the Collection to evaluate
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items forwards (or backwards)
    @return {"_collection_items":"Collection items"}
  */
  function list_indexed_bytes_collection_from(bytes32 _collection_index, bytes32 _current_item, uint256 _count, bool _from_start)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_indexed_bytesarray_from(_collection_index, _current_item, _count,
                                              example_controller().get_first_in_indexed_bytes_collection,
                                              example_controller().get_last_in_indexed_bytes_collection,
                                              example_controller().get_next_in_indexed_bytes_collection,
                                              example_controller().get_previous_in_indexed_bytes_collection,
                                              _from_start);
  }

  /**
    @notice Lists collection of indexed Address from the start or end
    @param _collection_index The Index of the Collection to evaluate
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items from start (or end)
    @return {"_collection_items":"Collection items"}
  */
  function list_indexed_addresses_collection(bytes32 _collection_index, uint256 _count, bool _from_start)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_indexed_addresses(_collection_index, _count,
                                    example_controller().get_first_in_indexed_addresses_collection,
                                    example_controller().get_last_in_indexed_addresses_collection,
                                    example_controller().get_next_in_indexed_addresses_collection,
                                    example_controller().get_previous_in_indexed_addresses_collection,
                                    _from_start);
  }

  /**
    @notice Lists collection of Address starting from the specified `_current_item`, going forwards or backwards depending on `_from_start`
    @param _collection_index The Index of the Collection to evaluate
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items forwards (or backwards)
    @return {"_collection_items":"Collection items"}
  */
  function list_indexed_addresses_collection_from(bytes32 _collection_index, address _current_item, uint256 _count, bool _from_start)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_indexed_addresses_from(_collection_index, _current_item, _count,
                                              example_controller().get_first_in_indexed_addresses_collection,
                                              example_controller().get_last_in_indexed_addresses_collection,
                                              example_controller().get_next_in_indexed_addresses_collection,
                                              example_controller().get_previous_in_indexed_addresses_collection,
                                              _from_start);
  }

  /**
    @notice Lists collection of indexed Uints from the start or end
    @param _collection_index The Index of the Collection to evaluate
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items from start (or end)
    @return {"_collection_items":"Collection items"}
  */
  function list_indexed_uints_collection(bytes32 _collection_index, uint256 _count, bool _from_start)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_indexed_uints(_collection_index, _count,
                                    example_controller().get_first_in_indexed_uints_collection,
                                    example_controller().get_last_in_indexed_uints_collection,
                                    example_controller().get_next_in_indexed_uints_collection,
                                    example_controller().get_previous_in_indexed_uints_collection,
                                    _from_start);
  }

  /**
    @notice Lists collection of Uints starting from the specified `_current_item`, going forwards or backwards depending on `_from_start`
    @param _collection_index The Index of the Collection to evaluate
    @param _count The Total number of items you wish to be returned
    @param _from_start Whether to read items forwards (or backwards)
    @return {"_collection_items":"Collection items"}
  */
  function list_indexed_uints_collection_from(bytes32 _collection_index, uint256 _current_item, uint256 _count, bool _from_start)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_indexed_uints_from(_collection_index, _current_item, _count,
                                              example_controller().get_first_in_indexed_uints_collection,
                                              example_controller().get_last_in_indexed_uints_collection,
                                              example_controller().get_next_in_indexed_uints_collection,
                                              example_controller().get_previous_in_indexed_uints_collection,
                                              _from_start);
  }

}
