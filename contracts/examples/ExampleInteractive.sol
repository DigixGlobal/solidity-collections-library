pragma solidity ^0.4.16;

import "../abstract/BytesIteratorInteractive.sol";
import "../abstract/AddressIteratorInteractive.sol";
import "./ExampleController.sol";

contract ExampleInteractive is BytesIteratorInteractive, AddressIteratorInteractive {

  address public controller_contract;

  function ExampleInteractive(address _controller) {
    controller_contract = _controller;
  }

  function example_controller()
           internal
           constant
           returns (ExampleController _contract)
  {
    _contract = ExampleController(controller_contract);
  }

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

  function list_addresses_collection_backwards_from_item(address _current_item, uint256 _count)
           public
           constant
           returns (address[] _collection_items)
  {
    _collection_items = list_addresses_from_address(_current_item, 
                                                    _count,
                                                    example_controller().get_first_in_addresses_collection,
                                                    example_controller().get_previous_in_addresses_collection);
  }
}


