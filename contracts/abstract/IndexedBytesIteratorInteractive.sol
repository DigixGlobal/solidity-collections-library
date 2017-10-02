pragma solidity ^0.4.16;

/**
  @title Indexed Bytes Iterator Interactive
  @author DigixGlobal Pte Ltd
*/
contract IndexedBytesIteratorInteractive {

  /**
    @notice Lists indexed Bytes in reverse from the end of the list
    @param _collection_index Index of the Collection to evaluate
    @param _count The total number of items to return
    @param _function_total Function that returns the Total number of items in the list
    @param _function_last Function that returns the last item in the list
    @param _function_previous Function that returns the previous item in the list
    @return {"_index_bytes_items": "List of reversed Bytes collection"}
  */
  function list_indexed_bytes_backwards_from_end(bytes32 _collection_index, uint256 _count,
                                 function (bytes32) external constant returns (uint256) _function_total,
                                 function (bytes32) external constant returns (bytes32) _function_last,
                                 function (bytes32, bytes32) external constant returns (bytes32) _function_previous)

           internal
           constant
           returns (bytes32[] _indexed_bytes_items)
  {
    _indexed_bytes_items = list_indexed_bytes_from_start(_collection_index, _count, _function_total, _function_last, _function_previous);
  }

  /**
    @notice Lists indexed Bytes starting from the beginning of the collection
    @param _collection_index Index of the Collection to evaluate
    @param _count The total number of items to return
    @param _function_total Function that returns the Total number of items in the list
    @param _function_first Function that returns the first item in the list
    @param _function_next Function that returns the next item in the list
    @return {"_index_bytes_items": "List of items in Bytes collection"}
  */
  function list_indexed_bytes_from_start(bytes32 _collection_index, uint256 _count,
                                 function (bytes32) external constant returns (uint256) _function_total,
                                 function (bytes32) external constant returns (bytes32) _function_first,
                                 function (bytes32, bytes32) external constant returns (bytes32) _function_next)
           internal
           constant
           returns (bytes32[] _indexed_bytes_items)
  {
    uint256 _i;
    bytes32 _current_item;
    uint256 _real_count = _function_total(_collection_index);

    if (_count > _real_count) {
      _count = _real_count;
    }

    bytes32[] memory _items_tmp = new bytes32[](_count);

    if (_count > 0) {
      _current_item = _function_first(_collection_index);
      _items_tmp[0] = _current_item;

      for(_i = 1;_i <= (_count - 1);_i++) {
        _current_item = _function_next(_collection_index, _current_item);
        if (_current_item != bytes32(0x0)) {
          _items_tmp[_i] = _current_item;
        }
      }
      _indexed_bytes_items = _items_tmp;
    } else {
      _indexed_bytes_items = new bytes32[](0);
    }
  }

  /**
    @notice Lists indexed Bytes in reverse starting from a specified `_current_item`
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The current item to be used as base line
    @param _count The The total number of items to return
    @param _function_first Function that returns the first item in the list
    @param _function_previous Function that returns the previous item in the list
    @return {"_index_bytes_items": "List of items in Bytes collection in reverse"}
  */
  function list_indexed_bytes_backwards_from_bytes(bytes32 _collection_index, bytes32 _current_item, uint256 _count,
                                         function (bytes32) external constant returns (bytes32) _function_first,
                                         function (bytes32, bytes32) external constant returns (bytes32) _function_previous)
           internal
           constant
           returns (bytes32[] _indexed_bytes_items)
  {
    _indexed_bytes_items = list_indexed_bytes_from_bytes(_collection_index, _current_item, _count, _function_first, _function_previous);
  }

  /**
    @notice Lists indexed Bytes starting from a specified `_current_item`
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The current item to be used as base line
    @param _count The total number of items to return
    @param _function_last Function that returns the last item in the list
    @param _function_next Function that returns the next item in the list
    @return {"_index_bytes_items": "List of items in Bytes collection"}
  */
  function list_indexed_bytes_from_bytes(bytes32 _collection_index, bytes32 _current_item, uint256 _count,
                                         function (bytes32) external constant returns (bytes32) _function_last,
                                         function (bytes32, bytes32) external constant returns (bytes32) _function_next)
           internal
           constant
           returns (bytes32[] _indexed_bytes_items)
  {
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
          for(_i = 1;(_i <= (_count - 1)) && (_start_item != _last_item);_i++) {
            _start_item = _function_next(_collection_index, _start_item);
            if (_start_item != bytes32(0x0)) {
              _real_count++;
              _items_temp[_i] = _start_item;
            }
          }
          _indexed_bytes_items = new bytes32[](_real_count);
          for(_i = 0;_i <= (_real_count - 1);_i++) {
            _indexed_bytes_items[_i] = _items_temp[_i];
          }
        } else {
          _indexed_bytes_items = new bytes32[](0);
        }
      } else {
        _indexed_bytes_items = new bytes32[](0);
      }
    }
  }

}
