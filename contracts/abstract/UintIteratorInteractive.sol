pragma solidity ^0.4.16;

contract UintIteratorInteractive {

  function list_uints_backwards_from_end(uint256 _count,
                                 function () external constant returns (uint256) _function_total,
                                 function () external constant returns (uint256) _function_last,
                                 function (uint256) external constant returns (uint256) _function_previous)
           internal
           constant
           returns (uint256[] _uint_items)
  {
    _uint_items = list_uints_from_start(_count, _function_total, _function_last, _function_previous);
  }

  function list_uints_from_start(uint256 _count,
                                 function () external constant returns (uint256) _function_total,
                                 function () external constant returns (uint256) _function_first,
                                 function (uint256) external constant returns (uint256) _function_next)
           internal
           constant
           returns (uint256[] _uint_items)
  {
    uint256 _i;
    uint256 _current_item;
    uint256 _real_count = _function_total();

    if (_count > _real_count) {
      _count = _real_count;
    }

    uint256[] memory _items_tmp = new uint256[](_count);

    if (_count > 0) {
      _current_item = _function_first();
      _items_tmp[0] = _current_item;

      for(_i = 1;_i <= (_count - 1);_i++) {
        _current_item = _function_next(_current_item);
        if (_current_item != 0) {
          _items_tmp[_i] = _current_item;
        }
      }
      _uint_items = _items_tmp;
    } else {
      _uint_items = new uint256[](0);
    }
  }

  function list_uints_backwards_from_uint(uint256 _current_item, uint256 _count,
                                function () external constant returns (uint256) _function_first,
                                function (uint256) external constant returns (uint256) _function_previous)
           internal
           constant
           returns (uint256[] _uint_items)
  {
    _uint_items = list_uints_from_uint(_current_item, _count, _function_first, _function_previous);
  }

  function list_uints_from_uint(uint256 _current_item, uint256 _count,
                                function () external constant returns (uint256) _function_last,
                                function (uint256) external constant returns (uint256) _function_next)
           internal
           constant
           returns (uint256[] _uint_items)
  {
    uint256 _i;
    uint256 _real_count = 0;

    if (_count == 0 ) {
      _uint_items = new uint256[](0);
    } else {
      uint256[] memory _items_temp = new uint256[](_count);

      uint256 _start_item;
      uint256 _last_item;

      _last_item = _function_last();

      if (_last_item != _current_item) {
        _start_item = _function_next(_current_item);
        if (_start_item != 0) {
          _items_temp[0] = _start_item;
          _real_count = 1;
          for(_i = 1;(_i <= (_count - 1)) && (_start_item != _last_item);_i++) {
            _start_item = _function_next(_start_item);
            if (_start_item != 0) {
              _real_count++;
              _items_temp[_i] = _start_item;
            }
          }
          _uint_items = new uint256[](_real_count);
          for(_i = 0;_i <= (_real_count - 1);_i++) {
            _uint_items[_i] = _items_temp[_i];
          }
        } else {
          _uint_items = new uint256[](0);
        }
      } else {
        _uint_items = new uint256[](0);
      }
    }
  }
}
