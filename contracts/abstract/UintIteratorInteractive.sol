pragma solidity ^0.4.16;

/**
  @title Uint Iterator Interactive
  @author DigixGlobal Pte Ltd
*/
contract UintIteratorInteractive {

    /**
      @notice Lists a Uint collection from start or end
      @param _count Total number of Uint items to return
      @param _function_first The Function that returns the First Uint item in the list
      @param _function_last Function that returns the last Uint item in the list
      @param _function_next The Function that returns the Next Uint item in the list
      @param _function_previous Function that returns previous Uint item in the list
      @param _from_start whether to read from start (or end) of the list
      @return {"_uint_items" : "Collection of reversed Uint list"}
    */
    function list_uints(uint256 _count,
                                   function () external constant returns (uint256) _function_first,
                                   function () external constant returns (uint256) _function_last,
                                   function (uint256) external constant returns (uint256) _function_next,
                                   function (uint256) external constant returns (uint256) _function_previous,
                                   bool _from_start)
             internal
             constant
             returns (uint256[] _uint_items)
    {
      if (_from_start) {
        _uint_items = private_list_uints_from_uint(_function_first(), _count, true, _function_last, _function_next);
      } else {
        _uint_items = private_list_uints_from_uint(_function_last(), _count, true, _function_first, _function_previous);
      }
    }


    /**
      @notice Lists a Uint collection from some `_current_item`, going forwards or backwards depending on `_from_start`
      @param _current_item The current Item
      @param _count Total number of Uint items to return
      @param _function_first The Function that returns the First Uint item in the list
      @param _function_last Function that returns the last Uint item in the list
      @param _function_next The Function that returns the Next Uint item in the list
      @param _function_previous Function that returns previous Uint item in the list
      @param _from_start whether to read in the forwards ( or backwards) direction
      @return {"_uint_items" :"Collection/list of Uint"}
    */
    function list_uints_from(uint256 _current_item, uint256 _count,
                                  function () external constant returns (uint256) _function_first,
                                  function () external constant returns (uint256) _function_last,
                                  function (uint256) external constant returns (uint256) _function_next,
                                  function (uint256) external constant returns (uint256) _function_previous,
                                  bool _from_start)
             internal
             constant
             returns (uint256[] _uint_items)
    {
      if (_from_start) {
        _uint_items = private_list_uints_from_uint(_current_item, _count, false, _function_last, _function_next);
      } else {
        _uint_items = private_list_uints_from_uint(_current_item, _count, false, _function_first, _function_previous);
      }
    }

    /**
      @notice a private function to lists a Uint collection starting from some _current_item (which could be included or excluded), in the forwards or backwards direction
      @param _current_item The current Item
      @param _count Total number of Uint items to return
      @param _including_current Whether the `_current_item` should be included in the result
      @param _function_last The Function that returns the uints where we stop reading more uints
      @param _function_next The Function that returns the next uints to read after some uints (could be backwards or forwards in the physical collection)
      @return {"_uint_items" :"Collection/list of Uint"}
    */
    function private_list_uints_from_uint(uint256 _current_item, uint256 _count, bool _including_current,
                                   function () external constant returns (uint256) _function_last,
                                   function (uint256) external constant returns (uint256) _function_next)
             private
             constant
             returns (uint256[] _uint_items)
    {
      uint256 _i;
      uint256 _real_count = 0;
      uint256 _last_item;

      _last_item = _function_last();
      if (_count == 0 || _last_item == uint256(0x0)) {
        _uint_items = new uint256[](0);
      } else {
        uint256[] memory _items_temp = new uint256[](_count);
        uint256 _this_item;
        if (_including_current == true) {
          _items_temp[0] = _current_item;
          _real_count = 1;
        }
        _this_item = _current_item;
        for (_i = _real_count; (_i < _count) && (_this_item != _last_item);_i++) {
          _this_item = _function_next(_this_item);
          if (_this_item != uint256(0x0)) {
            _real_count++;
            _items_temp[_i] = _this_item;
          }
        }

        _uint_items = new uint256[](_real_count);
        for(_i = 0;_i < _real_count;_i++) {
          _uint_items[_i] = _items_temp[_i];
        }
      }
    }


    /// DEPRECATED Functions (old version)
    /**
      @notice private function to list a Uint collection starting from the start or end of the list
      @param _count Total number of Uint item to return
      @param _function_total The Function that returns the Total number of Uint item in the list
      @param _function_first The Function that returns the First Uint item in the list
      @param _function_next The Function that returns the Next Uint item in the list
      @return {"_uint_items" :"Collection/list of Uint"}
    */
    /*function list_uints_from_start_or_end(uint256 _count,
                                   function () external constant returns (uint256) _function_total,
                                   function () external constant returns (uint256) _function_first,
                                   function (uint256) external constant returns (uint256) _function_next)

             private
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
          if (_current_item != uint256(0x0)) {
            _items_tmp[_i] = _current_item;
          }
        }
        _uint_items = _items_tmp;
      } else {
        _uint_items = new uint256[](0);
      }
    }*/




    /**
      @notice a private function to lists a Uint collection starting from some _current_item, could be forwards or backwards
      @param _current_item The current Item
      @param _count Total number of Uint items to return
      @param _function_last The Function that returns the bytes where we stop reading more bytes
      @param _function_next The Function that returns the next bytes to read after some bytes (could be backwards or forwards in the physical collection)
      @return {"_uint_items" :"Collection/list of Uint"}
    */
    /*function list_uints_from_uint(uint256 _current_item, uint256 _count,
                                   function () external constant returns (uint256) _function_last,
                                   function (uint256) external constant returns (uint256) _function_next)
             private
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

        _last_item = _function_last();

        if (_last_item != _current_item) {
          _start_item = _function_next(_current_item);
          if (_start_item != uint256(0x0)) {
            _items_temp[0] = _start_item;
            _real_count = 1;
            for(_i = 1;(_i <= (_count - 1)) && (_start_item != _last_item);_i++) {
              _start_item = _function_next(_start_item);
              if (_start_item != uint256(0x0)) {
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
    }*/
  }
