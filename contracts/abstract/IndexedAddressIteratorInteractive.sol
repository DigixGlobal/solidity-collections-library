pragma solidity ^0.4.16;

contract IndexedAddressIteratorInteractive {

  function list_indexed_addresses_from_start(bytes32 _collection_index, uint256 _count, 
                                             function (bytes32) external constant returns (uint256) _function_total,
                                             function (bytes32) external constant returns (address) _function_first, 
                                             function (bytes32, address) external constant returns (address) _function_next)
                                 
                                 
           internal
           constant
           returns (address[] _address_items)
  {
    uint256 _i;
    address _current_item;
    uint256 _real_count = _function_total(_collection_index);

    if (_count > _real_count) {
      _count = _real_count;
    }

    address[] memory _items_tmp = new address[](_count);

    if (_count > 0) {
      _current_item = _function_first(_collection_index);
      _items_tmp[0] = _current_item;

      for(_i = 1;_i <= (_count - 1);_i++) {
        _current_item = _function_next(_collection_index, _current_item);
        if (_current_item != address(0x0)) {
          _items_tmp[_i] = _current_item;
        }
      }
      _address_items = _items_tmp;
    } else {
      _address_items = new address[](0);
    }
  }

  function list_indexed_addresses_from_address(bytes32 _collection_index, address _current_item, uint256 _count,
                                 function (bytes32) external constant returns (address) _function_last,
                                 function (bytes32, address) external constant returns (address) _function_next)
           internal
           constant
           returns (address[] _address_items)
  {
    uint256 _i;
    uint256 _real_count = 0;

    address[] memory _items_temp = new address[](_count);

    address _start_item;
    address _last_item;

    _last_item = _function_last(_collection_index);

    if (_last_item != _current_item) {
      _start_item = _function_next(_collection_index, _current_item);
      if (_start_item != address(0x0)) {
        _items_temp[0] = _start_item;
        _real_count = 1;
        for(_i = 1;(_i <= (_count - 1)) && (_start_item != _last_item);_i++) {
          _start_item = _function_next(_collection_index, _start_item);
          if (_start_item != address(0x0)) {
            _real_count++;
            _items_temp[_i] = _start_item;
          }
        }
        _address_items = new address[](_real_count);
        for(_i = 0;_i <= (_real_count - 1);_i++) {
          _address_items[_i] = _items_temp[_i];
        }
      } else {
        _address_items = new address[](0);
      }
    } else {
      _address_items = new address[](0);
    }
  }

}
