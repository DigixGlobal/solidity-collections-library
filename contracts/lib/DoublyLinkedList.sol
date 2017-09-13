pragma solidity ^0.4.16;

library DoublyLinkedList {

  struct Item {
    bytes32 item;
    uint256 previous_index;
    uint256 next_index;
  }

  struct Data {
    uint256 first_index;
    uint256 last_index;
    uint256 count;
    mapping(bytes32 => uint256) item_index;
    mapping(uint256 => bool) valid_indexes;
    Item[] collection;
  }

  struct IndexedUint {
    mapping(bytes32 => Data) data;
  }

  struct IndexedAddress {
    mapping(bytes32 => Data) data;
  }

  struct IndexedBytes {
    mapping(bytes32 => Data) data;
  }

  struct Address {
    Data data;
  }

  struct Bytes {
    Data data;
  }

  struct Uint {
    Data data;
  }

  uint256 constant NONE = uint256(0);
  bytes32 constant EMPTY_BYTES = bytes32(0x0);
  address constant NULL_ADDRESS = address(0x0);

  function find(Data storage self, bytes32 _item)
           public
           constant
           returns (uint256 _item_index)
  {
    if ((self.item_index[_item] == NONE) && (self.count == NONE)) {
      _item_index = NONE;
    } else {
      _item_index = self.item_index[_item];
    }
  }

  function get(Data storage self, uint256 _item_index)
           public
           constant
           returns (bytes32 _item)
  {
    if (self.valid_indexes[_item_index] == true) { 
      _item = self.collection[_item_index - 1].item;
    } else {
      _item = bytes32("");
    }
  }

  function append(Data storage self, bytes32 _data)
           internal
           returns (bool _success)
  {
    if (find(self, _data) != NONE) {
      _success = false;
    } else {
      var _index = uint256(self.collection.push(Item({item: _data, previous_index: self.last_index, next_index: NONE})));
      if (self.last_index == NONE) {
        if ((self.first_index != NONE) || (self.count != NONE)) {
          revert();
        } else {
          self.first_index = self.last_index = _index;
          self.count = 1;
        } 
      } else {
        self.collection[self.last_index - 1].next_index = _index;
        self.last_index = _index;
        self.count++;
      }
      self.valid_indexes[_index] = true;
      self.item_index[_data] = _index;
      _success = true;
    }     
  }

  function remove(Data storage self, uint256 _index) 
           internal
           returns (bool _success) 
  {
    if (self.valid_indexes[_index] == true) {
      Item memory item = self.collection[_index - 1];
      if (item.previous_index == NONE) {
        self.first_index = item.next_index;
      }
      if (item.next_index == NONE) {
        self.last_index = item.previous_index;
      }
      if (item.previous_index != NONE) {
        self.collection[item.previous_index - 1].next_index = item.next_index;
      }
      if (item.next_index != NONE) {
        self.collection[item.next_index - 1].previous_index = item.previous_index;
      }
      delete self.collection[_index - 1];
      self.valid_indexes[_index] = false;
      self.count--;
      _success = true;
    } else {
      _success = false;
    }
  }

  function remove_item(Data storage self, bytes32 _item) 
           internal 
           returns (bool _success) 
  {
    uint256 _item_index = find(self, _item);
    if (_item_index != NONE) {
      require(remove(self, _item_index));
      delete self.item_index[_item];
      _success = true;
    } else {
      _success = false;
    }
    return _success;
  }

  function total(Data storage self)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = self.count;
  }

  function start(Data storage self)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = self.first_index;
    return _item_index;
  }

  function start_item(Data storage self)
           public
           constant
           returns (bytes32 _item)
  {
    uint256 _item_index = start(self);
    if (_item_index != NONE) {
      _item = get(self, _item_index); 
    } else {
      _item = EMPTY_BYTES;
    }
  }

  function end(Data storage self)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = self.last_index;
    return _item_index;
  }

  function end_item(Data storage self)
           public
           constant
           returns (bytes32 _item)
  {
    uint256 _item_index = end(self);
    if (_item_index != NONE) {
      _item = get(self, _item_index);
    } else {
      _item = EMPTY_BYTES;
    }
  }

  function valid(Data storage self, uint256 _item_index)
           public
           constant
           returns (bool _yes)
  {
    _yes = self.valid_indexes[_item_index];
    //_yes = ((_item_index - 1) < self.collection.length);
  }

  function valid_item(Data storage self, bytes32 _item)
           public
           constant
           returns (bool _yes)
  {
    uint256 _item_index = self.item_index[_item];
    _yes = self.valid_indexes[_item_index];
  }

  function previous(Data storage self, uint256 _current_index)
           public
           constant
           returns (uint256 _previous_index)
  {
    if (self.valid_indexes[_current_index] == true) {
      _previous_index = self.collection[_current_index - 1].previous_index;
    } else {
      _previous_index = NONE;
    }
  }

  function previous_item(Data storage self, bytes32 _current_item)
           public
           constant
           returns (bytes32 _previous_item)
  {
    uint256 _current_index = find(self, _current_item);
    if (_current_index != NONE) {
      uint256 _previous_index = previous(self, _current_index);
      _previous_item = get(self, _previous_index);
    } else {
      _previous_item = EMPTY_BYTES;
    }
  }

  function next(Data storage self, uint256 _current_index)
           public
           constant
           returns (uint256 _next_index)
  {
    if (self.valid_indexes[_current_index] == true) {
      _next_index = self.collection[_current_index - 1].next_index;
    } else {
      _next_index = NONE;
    }
  }

  function next_item(Data storage self, bytes32 _current_item)
           public
           constant
           returns (bytes32 _next_item)
  {
    uint256 _current_index = find(self, _current_item);
    if (_current_index != NONE) {
      uint256 _next_index = next(self, _current_index);
      _next_item = get(self, _next_index);
    } else {
      _next_item = EMPTY_BYTES;
    }
  }

  function find(Uint storage self, uint256 _item)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = find(self.data, bytes32(_item));
  }

  function get(Uint storage self, uint256 _item_index)
           public
           constant
           returns (uint256 _item)
  {
    _item = uint256(get(self.data, _item_index)); 
  }


  function append(Uint storage self, uint256 _data)
           public
           returns (bool _success)
  {
    _success = append(self.data, bytes32(_data));
  }

  function remove(Uint storage self, uint256 _index)
           internal
           returns (bool _success)
  {
    _success = remove(self.data, _index);
  }

  function remove_item(Uint storage self, uint256 _item)
           public
           returns (bool _success)
  {
    _success = remove_item(self.data, bytes32(_item));
  }

  function total(Uint storage self)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = total(self.data); 
  }

  function start(Uint storage self)
           public
           constant
           returns (uint256 _index)
  {
    _index = start(self.data);
  }

  function start_item(Uint storage self)
           public
           constant
           returns (uint256 _start_item)
  {
    _start_item = uint256(start_item(self.data));
  }


  function end(Uint storage self)
           public
           constant
           returns (uint256 _index)
  {
    _index = end(self.data);
  }

  function end_item(Uint storage self)
           public
           constant
           returns (uint256 _end_item)
  {
    _end_item = uint256(end_item(self.data));
  }

  function valid(Uint storage self, uint256 _item_index)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid(self.data, _item_index);
  }

  function valid_item(Uint storage self, uint256 _item)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid_item(self.data, bytes32(_item));
  }

  function previous(Uint storage self, uint256 _current_index)
           public
           constant
           returns (uint256 _previous_index)
  {
    _previous_index = previous(self.data, _current_index);
  }

  function previous_item(Uint storage self, uint256 _current_item)
           public
           constant
           returns (uint256 _previous_item)
  {
    _previous_item = uint256(previous_item(self.data, bytes32(_current_item))); 
  }

  function next(Uint storage self, uint256 _current_index)
           public
           constant
           returns (uint256 _next_index)
  {
    _next_index = next(self.data, _current_index);
  }

  function next_item(Uint storage self, uint256 _current_item)
           public
           constant
           returns (uint256 _next_item)
  {
    _next_item = uint256(next_item(self.data, bytes32(_current_item)));
  }

  function find(Address storage self, address _item)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = find(self.data, bytes32(_item));
  }

  function get(Address storage self, uint256 _item_index)
           public
           constant
           returns (address _item)
  {
    _item = address(get(self.data, _item_index)); 
  }


  function find(IndexedUint storage self, bytes32 _collection_index, uint256 _item)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = find(self.data[_collection_index], bytes32(_item));
  }

  function get(IndexedUint storage self, bytes32 _collection_index, uint256 _item_index)
           public
           constant
           returns (uint256 _item)
  {
    _item = uint256(get(self.data[_collection_index], _item_index)); 
  }


  function append(IndexedUint storage self, bytes32 _collection_index, uint256 _data)
           public
           returns (bool _success)
  {
    _success = append(self.data[_collection_index], bytes32(_data));
  }

  function remove(IndexedUint storage self, bytes32 _collection_index, uint256 _index)
           internal
           returns (bool _success)
  {
    _success = remove(self.data[_collection_index], _index);
  }

  function remove_item(IndexedUint storage self, bytes32 _collection_index, uint256 _item)
           public
           returns (bool _success)
  {
    _success = remove_item(self.data[_collection_index], bytes32(_item));
  }

  function total(IndexedUint storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = total(self.data[_collection_index]); 
  }

  function start(IndexedUint storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _index)
  {
    _index = start(self.data[_collection_index]);
  }

  function start_item(IndexedUint storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _start_item)
  {
    _start_item = uint256(start_item(self.data[_collection_index]));
  }


  function end(IndexedUint storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _index)
  {
    _index = end(self.data[_collection_index]);
  }

  function end_item(IndexedUint storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _end_item)
  {
    _end_item = uint256(end_item(self.data[_collection_index]));
  }

  function valid(IndexedUint storage self, bytes32 _collection_index, uint256 _item_index)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid(self.data[_collection_index], _item_index);
  }

  function valid_item(IndexedUint storage self, bytes32 _collection_index, uint256 _item)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid_item(self.data[_collection_index], bytes32(_item));
  }

  function previous(IndexedUint storage self, bytes32 _collection_index, uint256 _current_index)
           public
           constant
           returns (uint256 _previous_index)
  {
    _previous_index = previous(self.data[_collection_index], _current_index);
  }

  function previous_item(IndexedUint storage self, bytes32 _collection_index, uint256 _current_item)
           public
           constant
           returns (uint256 _previous_item)
  {
    _previous_item = uint256(previous_item(self.data[_collection_index], bytes32(_current_item))); 
  }

  function next(IndexedUint storage self, bytes32 _collection_index, uint256 _current_index)
           public
           constant
           returns (uint256 _next_index)
  {
    _next_index = next(self.data[_collection_index], _current_index);
  }

  function next_item(IndexedUint storage self, bytes32 _collection_index, uint256 _current_item)
           public
           constant
           returns (uint256 _next_item)
  {
    _next_item = uint256(next_item(self.data[_collection_index], bytes32(_current_item)));
  }

  function append(Address storage self, address _data)
           public
           returns (bool _success)
  {
    _success = append(self.data, bytes32(_data));
  }

  function remove(Address storage self, uint256 _index)
           internal
           returns (bool _success)
  {
    _success = remove(self.data, _index);
  }


  function remove_item(Address storage self, address _item)
           public
           returns (bool _success)
  {
    _success = remove_item(self.data, bytes32(_item));
  }

  function total(Address storage self)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = total(self.data); 
  }

  function start(Address storage self)
           public
           constant
           returns (uint256 _index)
  {
    _index = start(self.data);
  }

  function start_item(Address storage self)
           public
           constant
           returns (address _start_item)
  {
    _start_item = address(start_item(self.data));
  }


  function end(Address storage self)
           public
           constant
           returns (uint256 _index)
  {
    _index = end(self.data);
  }

  function end_item(Address storage self)
           public
           constant
           returns (address _end_item)
  {
    _end_item = address(end_item(self.data));
  }

  function valid(Address storage self, uint256 _item_index)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid(self.data, _item_index);
  }

  function valid_item(Address storage self, address _item)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid_item(self.data, bytes32(_item));
  }

  function previous(Address storage self, uint256 _current_index)
           public
           constant
           returns (uint256 _previous_index)
  {
    _previous_index = previous(self.data, _current_index);
  }

  function previous_item(Address storage self, address _current_item)
           public
           constant
           returns (address _previous_item)
  {
    _previous_item = address(previous_item(self.data, bytes32(_current_item))); 
  }

  function next(Address storage self, uint256 _current_index)
           public
           constant
           returns (uint256 _next_index)
  {
    _next_index = next(self.data, _current_index);
  }

  function next_item(Address storage self, address _current_item)
           public
           constant
           returns (address _next_item)
  {
    _next_item = address(next_item(self.data, bytes32(_current_item)));
  }

  function append(IndexedAddress storage self, bytes32 _collection_index, address _data)
           public
           returns (bool _success)
  {
    _success = append(self.data[_collection_index], bytes32(_data));
  }

  function remove(IndexedAddress storage self, bytes32 _collection_index, uint256 _index)
           internal
           returns (bool _success)
  {
    _success = remove(self.data[_collection_index], _index);
  }


  function remove_item(IndexedAddress storage self, bytes32 _collection_index, address _item)
           public
           returns (bool _success)
  {
    _success = remove_item(self.data[_collection_index], bytes32(_item));
  }

  function total(IndexedAddress storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = total(self.data[_collection_index]); 
  }

  function start(IndexedAddress storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _index)
  {
    _index = start(self.data[_collection_index]);
  }

  function start_item(IndexedAddress storage self, bytes32 _collection_index)
           public
           constant
           returns (address _start_item)
  {
    _start_item = address(start_item(self.data[_collection_index]));
  }


  function end(IndexedAddress storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _index)
  {
    _index = end(self.data[_collection_index]);
  }

  function end_item(IndexedAddress storage self, bytes32 _collection_index)
           public
           constant
           returns (address _end_item)
  {
    _end_item = address(end_item(self.data[_collection_index]));
  }

  function valid(IndexedAddress storage self, bytes32 _collection_index, uint256 _item_index)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid(self.data[_collection_index], _item_index);
  }

  function valid_item(IndexedAddress storage self, bytes32 _collection_index, address _item)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid_item(self.data[_collection_index], bytes32(_item));
  }

  function previous(IndexedAddress storage self, bytes32 _collection_index, uint256 _current_index)
           public
           constant
           returns (uint256 _previous_index)
  {
    _previous_index = previous(self.data[_collection_index], _current_index);
  }

  function previous_item(IndexedAddress storage self, bytes32 _collection_index, address _current_item)
           public
           constant
           returns (address _previous_item)
  {
    _previous_item = address(previous_item(self.data[_collection_index], bytes32(_current_item))); 
  }

  function next(IndexedAddress storage self, bytes32 _collection_index, uint256 _current_index)
           public
           constant
           returns (uint256 _next_index)
  {
    _next_index = next(self.data[_collection_index], _current_index);
  }

  function next_item(IndexedAddress storage self, bytes32 _collection_index, address _current_item)
           public
           constant
           returns (address _next_item)
  {
    _next_item = address(next_item(self.data[_collection_index], bytes32(_current_item)));
  }


  function find(Bytes storage self, bytes32 _item)
           public
           constant
           returns (uint256 _item_index)
  {
    _item_index = find(self.data, _item);
  }

  function get(Bytes storage self, uint256 _item_index)
           public
           constant
           returns (bytes32 _item)
  {
    _item = get(self.data, _item_index); 
  }


  function append(Bytes storage self, bytes32 _data)
           public
           returns (bool _success)
  {
    _success = append(self.data, _data);
  }

  function remove(Bytes storage self, uint256 _index)
           internal
           returns (bool _success)
  {
    _success = remove(self.data, _index);
  }


  function remove_item(Bytes storage self, bytes32 _item)
           public
           returns (bool _success)
  {
    _success = remove_item(self.data, _item);
  }

  function total(Bytes storage self)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = total(self.data); 
  }

  function start(Bytes storage self)
           public
           constant
           returns (uint256 _index)
  {
    _index = start(self.data);
  }

  function start_item(Bytes storage self)
           public
           constant
           returns (bytes32 _start_item)
  {
    _start_item = start_item(self.data);
  }


  function end(Bytes storage self)
           public
           constant
           returns (uint256 _index)
  {
    _index = end(self.data);
  }

  function end_item(Bytes storage self)
           public
           constant
           returns (bytes32 _end_item)
  {
    _end_item = end_item(self.data);
  }

  function valid(Bytes storage self, uint256 _item_index)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid(self.data, _item_index);
  }

  function valid_item(Bytes storage self, bytes32 _item)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid_item(self.data, _item);
  }

  function previous(Bytes storage self, uint256 _current_index)
           public
           constant
           returns (uint256 _previous_index)
  {
    _previous_index = previous(self.data, _current_index);
  }

  function previous_item(Bytes storage self, bytes32 _current_item)
           public
           constant
           returns (bytes32 _previous_item)
  {
    _previous_item = previous_item(self.data, _current_item); 
  }

  function next(Bytes storage self, uint256 _current_index)
           public
           constant
           returns (uint256 _next_index)
  {
    _next_index = next(self.data, _current_index);
  }

  function next_item(Bytes storage self, bytes32 _current_item)
           public
           constant
           returns (bytes32 _next_item)
  {
    _next_item = next_item(self.data, _current_item);
  }

  function append(IndexedBytes storage self, bytes32 _collection_index, bytes32 _data)
           public
           returns (bool _success)
  {
    _success = append(self.data[_collection_index], bytes32(_data));
  }

  function remove(IndexedBytes storage self, bytes32 _collection_index, uint256 _index)
           internal
           returns (bool _success)
  {
    _success = remove(self.data[_collection_index], _index);
  }


  function remove_item(IndexedBytes storage self, bytes32 _collection_index, bytes32 _item)
           public
           returns (bool _success)
  {
    _success = remove_item(self.data[_collection_index], bytes32(_item));
  }

  function total(IndexedBytes storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _total_count)
  {
    _total_count = total(self.data[_collection_index]); 
  }

  function start(IndexedBytes storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _index)
  {
    _index = start(self.data[_collection_index]);
  }

  function start_item(IndexedBytes storage self, bytes32 _collection_index)
           public
           constant
           returns (bytes32 _start_item)
  {
    _start_item = bytes32(start_item(self.data[_collection_index]));
  }


  function end(IndexedBytes storage self, bytes32 _collection_index)
           public
           constant
           returns (uint256 _index)
  {
    _index = end(self.data[_collection_index]);
  }

  function end_item(IndexedBytes storage self, bytes32 _collection_index)
           public
           constant
           returns (bytes32 _end_item)
  {
    _end_item = bytes32(end_item(self.data[_collection_index]));
  }

  function valid(IndexedBytes storage self, bytes32 _collection_index, uint256 _item_index)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid(self.data[_collection_index], _item_index);
  }

  function valid_item(IndexedBytes storage self, bytes32 _collection_index, bytes32 _item)
           public
           constant
           returns (bool _yes)
  {
    _yes = valid_item(self.data[_collection_index], bytes32(_item));
  }

  function previous(IndexedBytes storage self, bytes32 _collection_index, uint256 _current_index)
           public
           constant
           returns (uint256 _previous_index)
  {
    _previous_index = previous(self.data[_collection_index], _current_index);
  }

  function previous_item(IndexedBytes storage self, bytes32 _collection_index, bytes32 _current_item)
           public
           constant
           returns (bytes32 _previous_item)
  {
    _previous_item = bytes32(previous_item(self.data[_collection_index], bytes32(_current_item))); 
  }

  function next(IndexedBytes storage self, bytes32 _collection_index, uint256 _current_index)
           public
           constant
           returns (uint256 _next_index)
  {
    _next_index = next(self.data[_collection_index], _current_index);
  }

  function next_item(IndexedBytes storage self, bytes32 _collection_index, bytes32 _current_item)
           public
           constant
           returns (bytes32 _next_item)
  {
    _next_item = bytes32(next_item(self.data[_collection_index], bytes32(_current_item)));
  }


}
