pragma solidity ^0.4.16;

contract AddressIteratorInteractive {

  function list_addresses_from_start(uint256 _count, 
                                 function () external constant returns (uint256) _function_total,
                                 function () external constant returns (address) _function_first, 
                                 function (address) external constant returns (address) _function_next)
                                 
           internal
           constant
           returns (address[] _address_items)
  {
    uint256 _i;
    address _current_item;
    uint256 _real_count = _function_total();

    if (_count > _real_count) {
      _count = _real_count;
    }

    address[] memory _items_tmp = new address[](_count);

    if (_count > 0) {
      _current_item = _function_first();
      _items_tmp[0] = _current_item;

      for(_i = 1;_i <= (_count - 1);_i++) {
        _current_item = _function_next(_current_item);
        if (_current_item != address(0x0)) {
          _items_tmp[_i] = _current_item;
        }
      }
      _address_items = _items_tmp;
    } else {
      _address_items = new address[](0);
    }
  }

  function list_addresses_from_address(address _current_item, uint256 _count,
                                 function () external constant returns (address) _function_last,
                                 function (address) external constant returns (address) _function_next)
           internal
           constant
           returns (address[] _address_items)
  {
    uint256 _i;
    uint256 _real_count = 0;

    address[] memory _items_temp = new address[](_count);

    address _start_item;
    address _last_item;

    _last_item = _function_last();

    if (_last_item != _current_item) {
      _start_item = _function_next(_current_item);
      if (_start_item != address(0x0)) {
        _items_temp[0] = _start_item;
        _real_count = 1;
        for(_i = 1;(_i <= (_count - 1)) && (_start_item != _last_item);_i++) {
          _start_item = _function_next(_start_item);
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
