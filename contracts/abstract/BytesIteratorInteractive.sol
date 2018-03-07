pragma solidity ^0.4.19;
/**
  @title Bytes Iterator Interactive
  @author DigixGlobal Pte Ltd
*/
contract BytesIteratorInteractive {

  /**
    @notice Lists a Bytes collection from start or end
    @param _count Total number of Bytes items to return
    @param _function_first Function that returns the First Bytes item in the list
    @param _function_last Function that returns the last Bytes item in the list
    @param _function_next Function that returns the Next Bytes item in the list
    @param _function_previous Function that returns previous Bytes item in the list
    @param _from_start whether to read from start (or end) of the list
    @return {"_bytes_items" : "Collection of reversed Bytes list"}
  */
  function list_bytesarray(uint256 _count,
                                 function () external constant returns (bytes32) _function_first,
                                 function () external constant returns (bytes32) _function_last,
                                 function (bytes32) external constant returns (bytes32) _function_next,
                                 function (bytes32) external constant returns (bytes32) _function_previous,
                                 bool _from_start)
           internal
           constant
           returns (bytes32[] _bytes_items)
  {
    if (_from_start) {
      _bytes_items = private_list_bytes_from_bytes(_function_first(), _count, true, _function_last, _function_next);
    } else {
      _bytes_items = private_list_bytes_from_bytes(_function_last(), _count, true, _function_first, _function_previous);
    }
  }

  /**
    @notice Lists a Bytes collection from some `_current_item`, going forwards or backwards depending on `_from_start`
    @param _current_item The current Item
    @param _count Total number of Bytes items to return
    @param _function_first Function that returns the First Bytes item in the list
    @param _function_last Function that returns the last Bytes item in the list
    @param _function_next Function that returns the Next Bytes item in the list
    @param _function_previous Function that returns previous Bytes item in the list
    @param _from_start whether to read in the forwards ( or backwards) direction
    @return {"_bytes_items" :"Collection/list of Bytes"}
  */
  function list_bytesarray_from(bytes32 _current_item, uint256 _count,
                                function () external constant returns (bytes32) _function_first,
                                function () external constant returns (bytes32) _function_last,
                                function (bytes32) external constant returns (bytes32) _function_next,
                                function (bytes32) external constant returns (bytes32) _function_previous,
                                bool _from_start)
           internal
           constant
           returns (bytes32[] _bytes_items)
  {
    if (_from_start) {
      _bytes_items = private_list_bytes_from_bytes(_current_item, _count, false, _function_last, _function_next);
    } else {
      _bytes_items = private_list_bytes_from_bytes(_current_item, _count, false, _function_first, _function_previous);
    }
  }

  /**
    @notice A private function to lists a Bytes collection starting from some `_current_item` (which could be included or excluded), in the forwards or backwards direction
    @param _current_item The current Item
    @param _count Total number of Bytes items to return
    @param _including_current Whether the `_current_item` should be included in the result
    @param _function_last Function that returns the bytes where we stop reading more bytes
    @param _function_next Function that returns the next bytes to read after some bytes (could be backwards or forwards in the physical collection)
    @return {"_address_items" :"Collection/list of Bytes"}
  */
  function private_list_bytes_from_bytes(bytes32 _current_item, uint256 _count, bool _including_current,
                                 function () external constant returns (bytes32) _function_last,
                                 function (bytes32) external constant returns (bytes32) _function_next)
           private
           constant
           returns (bytes32[] _bytes32_items)
  {
    uint256 _i;
    uint256 _real_count = 0;
    bytes32 _last_item;

    _last_item = _function_last();
    if (_count == 0 || _last_item == bytes32(0x0)) {
      _bytes32_items = new bytes32[](0);
    } else {
      bytes32[] memory _items_temp = new bytes32[](_count);
      bytes32 _this_item;
      if (_including_current == true) {
        _items_temp[0] = _current_item;
        _real_count = 1;
      }
      _this_item = _current_item;
      for (_i = _real_count; (_i < _count) && (_this_item != _last_item);_i++) {
        _this_item = _function_next(_this_item);
        if (_this_item != bytes32(0x0)) {
          _real_count++;
          _items_temp[_i] = _this_item;
        }
      }

      _bytes32_items = new bytes32[](_real_count);
      for(_i = 0;_i < _real_count;_i++) {
        _bytes32_items[_i] = _items_temp[_i];
      }
    }
  }




  ////// DEPRECATED FUNCTIONS (old versions)

  /**
    @notice a private function to lists a Bytes collection starting from some `_current_item`, could be forwards or backwards
    @param _current_item The current Item
    @param _count Total number of Bytes items to return
    @param _function_last Function that returns the bytes where we stop reading more bytes
    @param _function_next Function that returns the next bytes to read after some bytes (could be backwards or forwards in the physical collection)
    @return {"_bytes_items" :"Collection/list of Bytes"}
  */
  /*function list_bytes_from_bytes(bytes32 _current_item, uint256 _count,
                                 function () external constant returns (bytes32) _function_last,
                                 function (bytes32) external constant returns (bytes32) _function_next)
           private
           constant
           returns (bytes32[] _bytes_items)
  {
    uint256 _i;
    uint256 _real_count = 0;

    if (_count == 0) {
      _bytes_items = new bytes32[](0);
    } else {
      bytes32[] memory _items_temp = new bytes32[](_count);

      bytes32 _start_item;
      bytes32 _last_item;

      _last_item = _function_last();

      if (_last_item != _current_item) {
        _start_item = _function_next(_current_item);
        if (_start_item != bytes32(0x0)) {
          _items_temp[0] = _start_item;
          _real_count = 1;
          for(_i = 1;(_i <= (_count - 1)) && (_start_item != _last_item);_i++) {
            _start_item = _function_next(_start_item);
            if (_start_item != bytes32(0x0)) {
              _real_count++;
              _items_temp[_i] = _start_item;
            }
          }
          _bytes_items = new bytes32[](_real_count);
          for(_i = 0;_i <= (_real_count - 1);_i++) {
            _bytes_items[_i] = _items_temp[_i];
          }
        } else {
          _bytes_items = new bytes32[](0);
        }
      } else {
        _bytes_items = new bytes32[](0);
      }
    }
  }*/

  /**
    @notice private function to list a Bytes collection starting from the start or end of the list
    @param _count Total number of Bytes item to return
    @param _function_total Function that returns the Total number of Bytes item in the list
    @param _function_first Function that returns the First Bytes item in the list
    @param _function_next Function that returns the Next Bytes item in the list
    @return {"_bytes_items" :"Collection/list of Bytes"}
  */
  /*function list_bytes_from_start_or_end(uint256 _count,
                                 function () external constant returns (uint256) _function_total,
                                 function () external constant returns (bytes32) _function_first,
                                 function (bytes32) external constant returns (bytes32) _function_next)

           private
           constant
           returns (bytes32[] _bytes_items)
  {
    uint256 _i;
    bytes32 _current_item;
    uint256 _real_count = _function_total();

    if (_count > _real_count) {
      _count = _real_count;
    }

    bytes32[] memory _items_tmp = new bytes32[](_count);

    if (_count > 0) {
      _current_item = _function_first();
      _items_tmp[0] = _current_item;

      for(_i = 1;_i <= (_count - 1);_i++) {
        _current_item = _function_next(_current_item);
        if (_current_item != bytes32(0x0)) {
          _items_tmp[_i] = _current_item;
        }
      }
      _bytes_items = _items_tmp;
    } else {
      _bytes_items = new bytes32[](0);
    }
  }*/
}
