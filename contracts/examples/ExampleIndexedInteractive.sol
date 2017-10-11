pragma solidity ^0.4.16;

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
  function ExampleIndexedInteractive(address _controller) {
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
    @notice Lists the Indexed Bytes collection from the start
    @param _collection_index The Index of the Collection to evaluate
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed Bytes"}
  */
  function list_indexed_bytes_collection_from_start(bytes32 _collection_index, uint256 _count)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_indexed_bytes_from_start(_collection_index, _count,
                                                      example_controller().get_total_in_indexed_bytes_collection,
                                                      example_controller().get_first_in_indexed_bytes_collection,
                                                      example_controller().get_next_in_indexed_bytes_collection);
  }

  /**
    @notice Lists the Indexed Bytes collection from the end
    @param _collection_index The Index of the Collection to evaluate
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed Bytes"}
  */
  function list_indexed_bytes_collection_backwards_from_end(bytes32 _collection_index, uint256 _count)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_indexed_bytes_backwards_from_end(_collection_index, _count,
                                                      example_controller().get_total_in_indexed_bytes_collection,
                                                      example_controller().get_last_in_indexed_bytes_collection,
                                                      example_controller().get_previous_in_indexed_bytes_collection);
  }

  /**
    @notice Lists the Indexed Bytes collection starting from the specified `_current_item`
    @param _current_item The item to be used as base line
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed Bytes"}
  */
  function list_indexed_bytes_collection_from_item(bytes32 _collection_index, bytes32 _current_item, uint256 _count)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_indexed_bytes_from_bytes(_collection_index, _current_item, _count,
                                                      example_controller().get_last_in_indexed_bytes_collection,
                                                      example_controller().get_next_in_indexed_bytes_collection);
  }

  /**
    @notice Lists the Indexed Bytes collection backwards starting from the specified `_current_item`
    @param _current_item The item to be used as base line
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed Bytes"}
  */
  function list_indexed_bytes_collection_backwards_from_item(bytes32 _collection_index, bytes32 _current_item, uint256 _count)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_indexed_bytes_backwards_from_bytes(_collection_index, _current_item, _count,
                                                      example_controller().get_first_in_indexed_bytes_collection,
                                                      example_controller().get_previous_in_indexed_bytes_collection);
  }


  /**
    @notice Lists the Indexed Addresses collection from the start
    @param _collection_index The Index Collection to evaluate
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed Addresses"}
  */
  function list_indexed_addresses_collection_from_start(bytes32 _collection_index, uint256 _count)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_indexed_addresses_from_start(_collection_index, _count,
                                                          example_controller().get_total_in_indexed_addresses_collection,
                                                          example_controller().get_first_in_indexed_addresses_collection,
                                                          example_controller().get_next_in_indexed_addresses_collection);
  }

  /**
    @notice Lists the Indexed Addresses collection from the end
    @param _collection_index The Index Collection to evaluate
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed Addresses"}
  */
  function list_indexed_addresses_collection_backwards_from_end(bytes32 _collection_index, uint256 _count)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_indexed_addresses_backwards_from_end(_collection_index, _count,
                                                          example_controller().get_total_in_indexed_addresses_collection,
                                                          example_controller().get_last_in_indexed_addresses_collection,
                                                          example_controller().get_previous_in_indexed_addresses_collection);
  }

  /**
    @notice Lists the Indexed Addresses collection from the specified `_current_item`
    @param _current_item The item to be used as base line
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed Addresses"}
  */
  function list_indexed_addresses_collection_from_item(bytes32 _collection_index, address _current_item, uint256 _count)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_indexed_addresses_from_address(_collection_index, _current_item, _count,
                                                            example_controller().get_last_in_indexed_addresses_collection,
                                                            example_controller().get_next_in_indexed_addresses_collection);
  }

  /**
    @notice Lists the Indexed Addresses collection from the specified `_current_item`
    @param _current_item The item to be used as base line
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed Addresses"}
  */
  function list_indexed_addresses_collection_backwards_from_item(bytes32 _collection_index, address _current_item, uint256 _count)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_indexed_addresses_backwards_from_address(_collection_index, _current_item, _count,
                                                            example_controller().get_first_in_indexed_addresses_collection,
                                                            example_controller().get_previous_in_indexed_addresses_collection);
  }

  /**
    @notice Lists the Indexed uints collection from the start
    @param _collection_index The Index Collection to evaluate
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed uints"}
  */
  function list_indexed_uints_collection_from_start(bytes32 _collection_index, uint256 _count)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_indexed_uints_from_start(_collection_index, _count,
                                                          example_controller().get_total_in_indexed_uints_collection,
                                                          example_controller().get_first_in_indexed_uints_collection,
                                                          example_controller().get_next_in_indexed_uints_collection);
  }

  /**
    @notice Lists the Indexed uints collection from the end
    @param _collection_index The Index Collection to evaluate
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed uints"}
  */
  function list_indexed_uints_collection_backwards_from_end(bytes32 _collection_index, uint256 _count)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_indexed_uints_backwards_from_end(_collection_index, _count,
                                                          example_controller().get_total_in_indexed_uints_collection,
                                                          example_controller().get_last_in_indexed_uints_collection,
                                                          example_controller().get_previous_in_indexed_uints_collection);
  }

  /**
    @notice Lists the Indexed uints collection from the specified `_current_item`
    @param _current_item The item to be used as base line
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed uints"}
  */
  function list_indexed_uints_collection_from_item(bytes32 _collection_index, uint256 _current_item, uint256 _count)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_indexed_uints_from_uint(_collection_index, _current_item, _count,
                                                            example_controller().get_last_in_indexed_uints_collection,
                                                            example_controller().get_next_in_indexed_uints_collection);
  }

  /**
    @notice Lists the Indexed uints collection from the specified `_current_item`
    @param _current_item The item to be used as base line
    @param _count The total number of items to return
    @return {"_collection_items":"List of Indexed uints"}
  */
  function list_indexed_uints_collection_backwards_from_item(bytes32 _collection_index, uint256 _current_item, uint256 _count)
           public
           constant
           returns (uint256[] _collection_items)
  {
    _collection_items = list_indexed_uints_backwards_from_uint(_collection_index, _current_item, _count,
                                                            example_controller().get_first_in_indexed_uints_collection,
                                                            example_controller().get_previous_in_indexed_uints_collection);
  }
}
