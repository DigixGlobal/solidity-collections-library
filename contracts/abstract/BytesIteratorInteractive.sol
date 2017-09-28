pragma solidity ^0.4.16;
/**
  @title Bytes Iterator Interactive
  @author DigixGlobal Pte Ltd
*/
contract BytesIteratorInteractive {

  /*
    @notice Lists a Bytes collection in reverse starting from the end of the list
    @param _count Total number of Bytes item to return
    @param _function_total Function that returns the total number of Bytes item in the list
    @param _function_last Function that returns the last Bytes item from the list
    @param _function_previous Function that returns previous Bytes item from the list
    @return {"_bytes_items" : "Collection of reversed Bytes list"}
  */
  function list_bytes_backwards_from_end(uint256 _count,
                                 function () external constant returns (uint256) _function_total,
                                 function () external constant returns (bytes32) _function_last,
                                 function (bytes32) external constant returns (bytes32) _function_previous)

           internal
           constant
           returns (bytes32[] _bytes_items)
  {
    _bytes_items = list_bytes_from_start(_count, _function_total, _function_last, _function_previous);
  }

  /*
    @notice Lists a Bytes collection starting from the start of the list
    @param _count Total number of Bytes item to return
    @param _funtion_total Function that returns the total number of Bytes item in the list
    @param _function_first Function that returns the first Bytes item in the list
    @param _functioin-next Function that returns the next Bytes item in the list
    @return {"_bytes_items" :"Collection/list of Bytes"}
  */
  function list_bytes_from_start(uint256 _count,
                                 function () external constant returns (uint256) _function_total,
                                 function () external constant returns (bytes32) _function_first,
                                 function (bytes32) external constant returns (bytes32) _function_next)

           internal
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
  }

  /*
    @notice Lists a Bytes collection in reverse starting from the specified `_current_item`
    @param _current_item The current Item
    @param _count Total number of Bytes item to return
    @param _function_first Function that returns the first item
    @param _function_previous Function that returns the previous item based on the specified `_current_item`
    @return {"_bytes_items" :"Collection/list of Bytes"}
  */
  function list_bytes_backwards_from_bytes(bytes32 _current_item, uint256 _count,
                                 function () external constant returns (bytes32) _function_first,
                                 function (bytes32) external constant returns (bytes32) _function_previous)
           internal
           constant
           returns (bytes32[] _bytes_items)
  {
    _bytes_items = list_bytes_from_bytes(_current_item, _count, _function_first, _function_previous);
  }

  /*
    @notice Lists a Bytes collection starting from the specified `_current_item`
    @param _current_item The current Item
    @param _count Total number of Bytes item to return
    @param _function_last Function that returns the last item
    @param _function_next Function that returns the next item
    @return {"_bytes_items" :"Collection/list of Bytes"}
  */
  function list_bytes_from_bytes(bytes32 _current_item, uint256 _count,
                                 function () external constant returns (bytes32) _function_last,
                                 function (bytes32) external constant returns (bytes32) _function_next)
           internal
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
  }

}
