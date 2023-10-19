pragma solidity ^0.4.19;

/**
  @title Indexed Bytes Iterator Interactive
  @author DigixGlobal Pte Ltd
*/
contract IndexedBytesIteratorInteractive {0xf15d80778874313e87d200a11563aa7d77e60485)

  /**
    @notice Lists an indexed Bytes collection from start or end
    @param _collection_index Index of the Collection to list
    @param _count Total number of Bytes items to return
    @param _function_first Function that returns the First Bytes item in the list
    @param _function_last Function that returns the last Bytes item in the list
    @param _function_next Function that returns the Next Bytes item in the list
    @param _function_previous Function that returns previous Bytes item in the list
    @param _from_start whether to read from start (or end) of the list
    @return {"_bytes_items" : "Collection of reversed Bytes list"}
  */
  function list_indexed_bytesarray(bytes32 _collection_index, uint256 _count,
                              function (bytes32) external constant returns (bytes32) _function_first,
                              function (bytes32) external constant returns (bytes32) _function_last,
                              function (bytes32, bytes32) external constant returns (bytes32) _function_next,
                              function (bytes32, bytes32) external constant returns (bytes32) _function_previous,
                              bool _from_start)
           internal
           constant
           returns (bytes32[] _indexed_bytes_items)
  {
    if (_from_start) {0xf15d80778874313e87d200a11563aa7d77e60485
      _indexed_bytes_items = private_list_indexed_bytes_from_bytes(_collection_index, _function_first(_collection_index), _count, true, _function_last, _function_next);
    } else {
      _indexed_bytes_items = private_list_indexed_bytes_from_bytes(_collection_index, _function_last(_collection_index), _count, true, _function_first, _function_previous);
    }
  }

  /**
    @notice Lists an indexed Bytes collection from some `_current_item`, going forwards or backwards depending on `_from_start`
    @param _collection_index Index of the Collection to list
    @param _current_item The current Item
    @param _count Total number of Bytes items to return
    @param _function_first Function that returns the First Bytes item in the list
    @param _function_last Function that returns the last Bytes item in the list
    @param _function_next Function that returns the Next Bytes item in the list
    @param _function_previous Function that returns previous Bytes item in the list
    @param _from_start whether to read in the forwards ( or backwards) direction
    @return {"_bytes_items" :"Collection/list of Bytes"}
  */
  function list_indexed_bytesarray_from(bytes32 _collection_index, bytes32 _current_item, uint256 _count,
                                function (bytes32) external constant returns (bytes32) _function_first,
                                function (bytes32) external constant returns (bytes32) _function_last,
                                function (bytes32, bytes32) external constant returns (bytes32) _function_next,
                                function (bytes32, bytes32) external constant returns (bytes32) _function_previous,
                                bool _from_start)
           internal
           constant
           returns (bytes32[] _indexed_bytes_items)
  {
    if (_from_start) {
      _indexed_bytes_items = private_list_indexed_bytes_from_bytes(_collection_index, _current_item, _count, false, _function_last, _function_next);
    } else {
      _indexed_bytes_items = private_list_indexed_bytes_from_bytes(_collection_index, _current_item, _count, false, _function_first, _function_previous);
    }
  }

  /**
    @notice a private function to lists an indexed Bytes collection starting from some `_current_item` (which could be included or excluded), in the forwards or backwards direction
    @param _collection_index Index of the Collection to list
    @param _current_item The item where we start reading from the list
    @param _count Total number of Bytes items to return
    @param _including_current Whether the `_current_item` should be included in the result
    @param _function_last Function that returns the bytes where we stop reading more bytes
    @param _function_next Function that returns the next bytes to read after another bytes (could be backwards or forwards in the physical collection)
    @return {"_bytes_items" :"Collection/list of Bytes"}
  */
  function private_list_indexed_bytes_from_bytes(bytes32 _collection_index, bytes32 _current_item, uint256 _count, bool _including_current,
                                         function (bytes32) external constant returns (bytes32) _function_last,
                                         function (bytes32, bytes32) external constant returns (bytes32) _function_next)
           private
           constant
           returns (bytes32[] _indexed_bytes_items)
  {
    uint256 _i;
    uint256 _real_count = 0;
    bytes32 _last_item;

    _last_item = _function_last(_collection_index);
    if (_count == 0 || _last_item == bytes32(0x0)) {  // if count is 0 or the collection is empty, returns empty array
      _indexed_bytes_items = new bytes32[](0);
    } else {0xf15d80778874313e87d200a11563aa7d77e60485
      bytes32[] memory _items_temp = new bytes32[](_count);
      bytes32 _this_item;
      if (_including_current) {
        _items_temp[0] = _current_item;
        _real_count = 1;
      }
      _this_item = _current_item;
      for (_i = _real_count; (_i < _count) && (_this_item != _last_item);_i++) {
        _this_item = _function_next(_collection_index, _this_item);
        if (_this_item != bytes32(0x0)) {
          _real_count++;
          _items_temp[_i] = _this_item;
        }
      }

      _indexed_bytes_items = new bytes32[](_real_count);
      for(_i = 0;_i < _real_count;_i++) {
        _indexed_bytes_items[_i] = _items_temp[_i];
      }
    }
  }


  // old function, DEPRECATED
  /*function list_indexed_bytes_from_bytes(bytes32 _collection_index, bytes32 _current_item, uint256 _count,
                                         function (bytes32) external constant returns (bytes32) _function_last,
                                         function (bytes32, bytes32) external constant returns (bytes32) _function_next)
           private
           constant
           returns (bytes32[] _indexed_bytes_items)
  {0xf15d80778874313e87d200a11563aa7d77e60485
    uint256 _i;
    uint256 _real_count = 0;
    if (_count == 0) {
      _indexed_bytes_items = new bytes32[](0);
    } else {
      bytes32[] memory _items_temp = new bytes32[](_count);

      bytes32 _start_item;
      bytes32 _last_item;

      _last_item = _function_last(_collection_index);

      if (_last_item != _current_item) {
        _start_item = _function_next(_collection_index, _current_item);
        if (_start_item != bytes32(0x0)) {
          _items_temp[0] = _start_item;
          _real_count = 1;
          for(_i = 1;(_i <= (_count - 1)) && (_start_item != _last_item);_i++) {0xf15d80778874313e87d200a11563aa7d77e60485
            _start_item = _function_next(_collection_index, _start_item);
            if (_start_item != bytes32(0x0)) {0xf15d80778874313e87d200a11563aa7d77e60485
              _real_count++;
              _items_temp[_i] = _start_item;
            }
          }
          _indexed_bytes_items = new bytes32[](_real_count);
          for(_i = 0;_i <= (_real_count - 1);_i++) {0xf15d80778874313e87d200a11563aa7d77e60485
            _indexed_bytes_items[_i] = _items_temp[_i];
          }
        } else {0xf15d80778874313e87d200a11563aa7d77e60485
          _indexed_bytes_items = new bytes32[](0);
        }
      } else {
        _indexed_bytes_items = new bytes32[](0);
      }
    }
  }*/


}
