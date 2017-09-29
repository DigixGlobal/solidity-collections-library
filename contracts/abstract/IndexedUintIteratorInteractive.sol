pragma solidity ^0.4.16;

/**
  @title Indexed Uint Iterator Interactive
  @author DigixGlobal Pte Ltd
*/
contract IndexedUintIteratorInteractive {

  /**
    @notice Returns a list of specified `_count` of uint items in reverse from the specified `_collection_index`
    @param _collection_index The index of a collection
    @param _count Number of items to be returned
    @param _function_total Function that returns the total count of items from a list
    @param _function_last Function that returns the last item from a list
    @param _function_previous Function that returns the previous item from a list
    @return {"_uint_items": "The list of uint items"}
  */
  function list_indexed_uints_backwards_from_end(bytes32 _collection_index, uint256 _count,
                                 function (bytes32) external constant returns (uint256) _function_total,
                                 function (bytes32) external constant returns (uint256) _function_last,
                                 function (bytes32, uint256) external constant returns (uint256) _function_previous)
           internal
           constant
           returns (uint256[] _uint_items)
  {
    _uint_items = list_indexed_uints_from_start(_collection_index, _count, _function_total, _function_last, _function_previous);
  }

  /**
    @notice Returns a list of specified `_count` of uint items from the specified `_collection_index`
    @param _collection_index The index of a collection
    @param _count Number of items to be returned
    @param _function_total Function that returns the total count of items from a list
    @param _function_first Function that returns the first item from a list
    @param _function_next Function that returns the next item from a list
    @return {"_uint_items": "The list of uint items"}
  */
  function list_indexed_uints_from_start(bytes32 _collection_index, uint256 _count,
                                 function (bytes32) external constant returns (uint256) _function_total,
                                 function (bytes32) external constant returns (uint256) _function_first,
                                 function (bytes32, uint256) external constant returns (uint256) _function_next)

           internal
           constant
           returns (uint256[] _uint_items)
  {
    uint256 _i;
    uint256 _current_item;
    uint256 _real_count = _function_total(_collection_index);

    if (_count > _real_count) {
      _count = _real_count;
    }

    uint256[] memory _items_tmp = new uint256[](_count);

    if (_count > 0) {
      _current_item = _function_first(_collection_index);
      _items_tmp[0] = _current_item;

      for(_i = 1;_i <= (_count - 1);_i++) {
        _current_item = _function_next(_collection_index, _current_item);
        if (_current_item != 0) {
          _items_tmp[_i] = _current_item;
        }
      }
      _uint_items = _items_tmp;
    } else {
      _uint_items = new uint256[](0);
    }
  }

  /**
    @notice Returns a list of specified `_count` of uint items in reverse from the specified `_collection_index`
            starting from the specified `_current_item`
    @param _collection_index The index of a collection
    @param _current_item The current item of a collection
    @param _count Number of items to be returned
    @param _function_first Function that returns the first item from a list
    @param _function_previous Function that returns the previous item from a list
    @return {"_uint_items": "The list of uint items"}
  */
  function list_indexed_uints_backwards_from_uint(bytes32 _collection_index, uint256 _current_item, uint256 _count,
                                function (bytes32) external constant returns (uint256) _function_first,
                                function (bytes32, uint256) external constant returns (uint256) _function_previous)
           internal
           constant
           returns (uint256[] _uint_items)
  {
    _uint_items = list_indexed_uints_from_uint(_collection_index, _current_item, _count, _function_first, _function_previous);
  }

  /**
    @notice Returns a list of specified `_count` of uint items from the specified `_collection_index`
            starting from the specified `_current_item`
    @param _collection_index The index of a collection
    @param _current_item The current item of a collection
    @param _count Number of items to be returned
    @param _function_last Function that returns the last item from a list
    @param _function_next Function that returns the next item from a list
    @return {"_uint_items": "The list of uint items"}
  */
  function list_indexed_uints_from_uint(bytes32 _collection_index, uint256 _current_item, uint256 _count,
                                function (bytes32) external constant returns (uint256) _function_last,
                                function (bytes32, uint256) external constant returns (uint256) _function_next)
           internal
           constant
           returns (uint256[] _uint_items)
  {
    uint256 _i;
    uint256 _real_count = 0;

    if (_count == 0) {
      _uint_items = new uint256[](0);
    } else {
      uint256[] memory _items_temp = new uint256[](_count);

      uint256 _start_item;
      uint256 _last_item;

      _last_item = _function_last(_collection_index);

      if (_last_item != _current_item) {
        _start_item = _function_next(_collection_index, _current_item);
        if (_start_item != 0) {
          _items_temp[0] = _start_item;
          _real_count = 1;
          for(_i = 1;(_i <= (_count - 1)) && (_start_item != _last_item);_i++) {
            _start_item = _function_next(_collection_index, _start_item);
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
