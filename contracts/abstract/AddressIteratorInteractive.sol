pragma solidity ^0.4.16;
/**
  @title Address Iterator Interactive
  @author DigixGlobal Pte Ltd
*/
contract AddressIteratorInteractive {

  /**
    @notice List the Addresses in reverse starting from the end of the list
    @param _count Total number of adddresses to return
    @param _function_total The function that returns the Total number of Address in the list
    @param _function_last The function that returns the Last Address from the list
    @param _function_previous The function that returns the Previous item from the list
    @return {"_address_items": "Reversed address list" }
  */
  function list_addresses_backwards_from_end(uint256 _count, 
                                 function () external constant returns (uint256) _function_total,
                                 function () external constant returns (address) _function_last, 
                                 function (address) external constant returns (address) _function_previous)
                                 
           internal
           constant
           returns (address[] _address_items)
  {
    _address_items = list_addresses_from_start(_count, _function_total, _function_last, _function_previous);
  }


  /**
    @notice List the Addresses from start of the list
    @param _count Total number of adddresses to return
    @param _function_total The Function that returns the Total number of Address in the list
    @param _function_first The Function that returns the First Address from the list
    @param _function_next The Function that returns the Next item from the list
    @return {"_address_items": "Address list" }
  */
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

  /**
    @notice List the Addresses in reverse starting from the specified `_current_item`
    @param _current_item The current item from the collection to be used as base line
    @param _count Total number of adddresses to return
    @param _function_first The Function that returns the First item on the list
    @param _function_previous The Function that return the Previous item on the list
    @return {"_address_items": "Address list" } 
  */
  function list_addresses_backwards_from_address(address _current_item, uint256 _count,
                                 function () external constant returns (address) _function_first,
                                 function (address) external constant returns (address) _function_previous)
           internal
           constant
           returns (address[] _address_items)
  {
    _address_items = list_addresses_from_address(_current_item, _count, _function_first, _function_previous);    
  }

  /**
    @notice List the Addresses starting from a specified `_current_item`
    @param _current_item The current item from the collection
    @param _count Total number of adddresses to return
    @param _function_last The last item on the list
    @param _function_next The next item on the list
    @return {"_address_items": "Address list" } 
  */
  function list_addresses_from_address(address _current_item, uint256 _count,
                                 function () external constant returns (address) _function_last,
                                 function (address) external constant returns (address) _function_next)
           internal
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
  }

}
