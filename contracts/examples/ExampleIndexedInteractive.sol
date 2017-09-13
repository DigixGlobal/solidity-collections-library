pragma solidity ^0.4.16;

import "../abstract/IndexedBytesIteratorInteractive.sol";
import "../abstract/IndexedAddressIteratorInteractive.sol";
import "../abstract/IndexedUintIteratorInteractive.sol";
import "./ExampleIndexedController.sol";

contract ExampleIndexedInteractive is IndexedBytesIteratorInteractive, IndexedAddressIteratorInteractive, IndexedUintIteratorInteractive {

  address public controller_contract;

  function ExampleIndexedInteractive(address _controller) {
    controller_contract = _controller;
  }

  function example_controller()
           internal
           constant
           returns (ExampleIndexedController _contract)
  {
    _contract = ExampleIndexedController(controller_contract);
  }

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

  function list_indexed_bytes_collection_from_item(bytes32 _collection_index, bytes32 _current_item, uint256 _count)
           public
           constant
           returns (bytes32[] _collection_items)
  {
    _collection_items = list_indexed_bytes_from_bytes(_collection_index, _current_item, _count,
                                                      example_controller().get_last_in_indexed_bytes_collection,
                                                      example_controller().get_next_in_indexed_bytes_collection);
  }

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

  function list_indexed_addresses_collection_from_item(bytes32 _collection_index, address _current_item, uint256 _count)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_indexed_addresses_from_address(_collection_index, _current_item, _count,
                                                            example_controller().get_last_in_indexed_addresses_collection,
                                                            example_controller().get_next_in_indexed_addresses_collection);
  }
}


