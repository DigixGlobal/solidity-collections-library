pragma solidity ^0.4.19;
/**
  @title Address Iterator Interactive
  @author DigixGlobal Pte Ltd
*/
contract AddressIteratorInteractive {

  /**
    @notice Lists a Address collection from start or end
    @param _count Total number of Address items to return
    @param _function_first Function that returns the First Address item in the list
    @param _function_last Function that returns the last Address item in the list
    @param _function_next Function that returns the Next Address item in the list
    @param _function_previous Function that returns previous Address item in the list
    @param _from_start whether to read from start (or end) of the list
    @return {"_address_items" : "Collection of reversed Address list"}
  */
  function list_addresses(uint256 _count,
                                 function () external constant returns (address) _function_first,
                                 function () external constant returns (address) _function_last,
                                 function (address) external constant returns (address) _function_next,
                                 function (address) external constant returns (address) _function_previous,
                                 bool _from_start)
           internal
           constant
           returns (address[] _address_items)
  {
    if (_from_start) {
      _address_items = private_list_addresses_from_address(_function_first(), _count, true, _function_last, _function_next);
    } else {
      _address_items = private_list_addresses_from_address(_function_last(), _count, true, _function_first, _function_previous);
    }
  }



  /**
    @notice Lists a Address collection from some `_current_item`, going forwards or backwards depending on `_from_start`
    @param _current_item The current Item
    @param _count Total number of Address items to return
    @param _function_first Function that returns the First Address item in the list
    @param _function_last Function that returns the last Address item in the list
    @param _function_next Function that returns the Next Address item in the list
    @param _function_previous Function that returns previous Address item in the list
    @param _from_start whether to read in the forwards ( or backwards) direction
    @return {"_address_items" :"Collection/list of Address"}
  */
  function list_addresses_from(address _current_item, uint256 _count,
                                function () external constant returns (address) _function_first,
                                function () external constant returns (address) _function_last,
                                function (address) external constant returns (address) _function_next,
                                function (address) external constant returns (address) _function_previous,
                                bool _from_start)
           internal
           constant
           returns (address[] _address_items)
  {
    if (_from_start) {
      _address_items = private_list_addresses_from_address(_current_item, _count, false, _function_last, _function_next);
    } else {
      _address_items = private_list_addresses_from_address(_current_item, _count, false, _function_first, _function_previous);
    }
  }


  /**
    @notice a private function to lists a Address collection starting from some `_current_item` (which could be included or excluded), in the forwards or backwards direction
    @param _current_item The current Item
    @param _count Total number of Address items to return
    @param _including_current Whether the `_current_item` should be included in the result
    @param _function_last Function that returns the address where we stop reading more address
    @param _function_next Function that returns the next address to read after some address (could be backwards or forwards in the physical collection)
    @return {"_address_items" :"Collection/list of Address"}
  */
  function private_list_addresses_from_address(address _current_item, uint256 _count, bool _including_current,
                                 function () external constant returns (address) _function_last,
                                 function (address) external constant returns (address) _function_next)
           private
           constant
           returns (address[] _address_items)
  {
    uint256 _i;
    uint256 _real_count = 0;
    address _last_item;

    _last_item = _function_last();
    if (_count == 0 || _last_item == address(0x0)) {
      _address_items = new address[](0);
    } else {
      address[] memory _items_temp = new address[](_count);
      address _this_item;
      if (_including_current == true) {
        _items_temp[0] = _current_item;
        _real_count = 1;
      }
      _this_item = _current_item;
      for (_i = _real_count; (_i < _count) && (_this_item != _last_item);_i++) {
        _this_item = _function_next(_this_item);
        if (_this_item != address(0x0)) {
          _real_count++;
          _items_temp[_i] = _this_item;
        }
      }

      _address_items = new address[](_real_count);
      for(_i = 0;_i < _real_count;_i++) {
        _address_items[_i] = _items_temp[_i];
      }
    }
  }


  /** DEPRECATED
    @notice private function to list a Address collection starting from the start or end of the list
    @param _count Total number of Address item to return
    @param _function_total Function that returns the Total number of Address item in the list
    @param _function_first Function that returns the First Address item in the list
    @param _function_next Function that returns the Next Address item in the list
    @return {"_address_items" :"Collection/list of Address"}
  */
  /*function list_addresses_from_start_or_end(uint256 _count,
                                 function () external constant returns (uint256) _function_total,
                                 function () external constant returns (address) _function_first,
                                 function (address) external constant returns (address) _function_next)

           private
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
  }*/

  /** DEPRECATED
    @notice a private function to lists a Address collection starting from some `_current_item`, could be forwards or backwards
    @param _current_item The current Item
    @param _count Total number of Address items to return
    @param _function_last Function that returns the bytes where we stop reading more bytes
    @param _function_next Function that returns the next bytes to read after some bytes (could be backwards or forwards in the physical collection)
    @return {"_address_items" :"Collection/list of Address"}
  */
  /*function list_addresses_from_byte(address _current_item, uint256 _count,
                                 function () external constant returns (address) _function_last,
                                 function (address) external constant returns (address) _function_next)
           private
           constant
           returns (address[] _address_items)
  {
    uint256 _i;
    uint256 _real_count = 0;

    if (_count == 0) {
      _address_items = new address[](0);
    } else {
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
  }*/

}
