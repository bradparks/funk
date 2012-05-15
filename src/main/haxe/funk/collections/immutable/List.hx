package funk.collections.immutable;

import funk.collections.IList;
import funk.collections.IteratorUtil;
import funk.collections.ListUtil;
import funk.collections.immutable.Nil;
import funk.errors.NoSuchElementError;
import funk.errors.RangeError;
import funk.FunkObject;
import funk.product.Product1;
import funk.option.Option;
import funk.tuple.Tuple2;
import funk.unit.Expect;
import funk.util.Require;

using funk.collections.IteratorUtil;
using funk.collections.ListUtil;
using funk.collections.immutable.Nil;
using funk.option.Option;
using funk.tuple.Tuple2;
using funk.unit.Expect;
using funk.util.Require;

class List<T> extends Product1<T>, implements IList<T> {
	
	public var nonEmpty(get_nonEmpty, never) : Bool;

	public var head(get_head, never) : T;
	
	public var headOption(get_headOption, never) : Option<T>;

	public var indices(get_indices, never) : IList<Int>;

	public var init(get_init, never) : IList<T>;

	public var isEmpty(get_isEmpty, never) : Bool;

	public var last(get_last, never) : Option<T>;

	public var reverse(get_reverse, never) : IList<T>;

	public var tail(get_tail, never) : IList<T>;
	
	public var tailOption(get_tailOption, never) : Option<IList<T>>;

	public var zipWithIndex(get_zipWithIndex, never) : IList<ITuple2<T, Int>>;
	
	public var size(get_size, never) : Int;
	
	public var hasDefinedSize(get_hasDefinedSize, never) : Bool;
	
	public var toArray(get_toArray, never) : Array<T>;
	
	public var flatten(get_flatten, never) : IList<T>;
	
	private var _head : T;
	
	private var _tail : IList<T>;
	
	private var _length : Int;
	
	private var _lengthKnown : Bool;
	
	public function new(head : T, tail : IList<T>) {
		super();
		
		_head = head;
		_tail = tail;
		
		_length = 0;
		_lengthKnown = false;
	}
	
	public function contains(value : T) : Bool {
		var p: IList<T> = this;

      	while(p.nonEmpty) {
        	if(expect(p.head).toEqual(value)) {
          		return true;
        	}
        	p = p.tail;
      	}

      	return false;
	}
	
	public function count(f : (T -> Bool)) : Int {
		var n: Int = 0;
      	var p: IList<T> = this;

      	while(p.nonEmpty) {
        	if(f(p.head)) {
          		++n;
        	}

        	p = p.tail;
      	}

      	return n;
	}
	
	public function drop(n : Int) : IList<T> {
		require("n must be positive.").toBe(n >= 0);

      	var p: IList<T> = this;

      	for(i in 0...n) {
        	if(p.isEmpty) {
          		return nil.list();
        	}

        	p = p.tail;
      	}

      	return p;
	}
	
	public function dropRight(n : Int) : IList<T> {
		require("n must be positive.").toBe(n >= 0);
		
		if(0 == n) {
			return this;
      	}
      
      	n = size - n;

      	if(n <= 0) {
        	return nil.list();
      	}

      	var buffer = new Array<List<T>>();
      	var m: Int = n - 1;
      	var p: IList<T> = this;

      	for(i in 0...n) {
        	buffer[i] = new List<T>(p.head, null);
        	p = p.tail;
      	}

      	buffer[m]._tail = nil.list();
		
		var j : Int = 1;
		for(i in 0...m) {
        	buffer[i]._tail = buffer[j];
			j++;
      	}

      	return buffer[0];
	}
	
	public function dropWhile(f : (T -> Bool)) : IList<T> {
		var p: IList<T> = this;

      	while(p.nonEmpty) {
        	if(!f(p.head)) {
          		return p;
        	}

        	p = p.tail;
      }

      return nil.list();
	}
	
	public function exists(f : (T -> Bool)) : Bool {
		var p: IList<T> = this;

      	while(p.nonEmpty) {
        	if(f(p.head)) {
          		return true;
        	}

        	p = p.tail;
      	}

      	return false;
	}
	
	public function filter(f : (T -> Bool)) : IList<T> {
		var p: IList<T> = this;
      	var q: List<T> = null;
      	var first: List<T> = null;
      	var last: List<T> = null;
      	var allFiltered: Bool = true;

      	while(p.nonEmpty) {
        	if(f(p.head)) {
          		q = new List<T>(p.head, nil.list());

          		if(null != last) {
            		last._tail = q;
          		}

          		if(null == first) {
            		first = q;
          		}

          		last = q;
        	} else {
          		allFiltered = false;
        	}

        	p = p.tail;
      	}

      	if(allFiltered) {
        	return this;
      	}

      	return (first == null) ? nil.list() : first;
	}
	
	public function filterNot(f : (T -> Bool)) : IList<T> {
		var p: IList<T> = this;
      	var q: List<T> = null;
      	var first: List<T> = null;
      	var last: List<T> = null;
      	var allFiltered: Bool = true;

      	while(p.nonEmpty) {
        	if(!f(p.head)) {
          		q = new List<T>(p.head, nil.list());

          		if(null != last) {
            		last._tail = q;
          		}

          		if(null == first) {
            		first = q;
          		}

          		last = q;
        	} else {
          		allFiltered = false;
        	}

        	p = p.tail;
      	}

      	if(allFiltered) {
        	return this;
      	}

      	return (first == null) ? nil.list() : first;
	}
	
	public function find(f : (T -> Bool)) : Option<T> {
		var p: IList<T> = this;

      	while(p.nonEmpty) {
        	if(f(p.head)) {
          		return p.headOption;
        	}

        	p = p.tail;
      	}

      	return None;
	}
	
	public function flatMap(f : (T -> IList<T>)) : IList<T> {
		var n: Int = size;
      	var buffer: Array<IList<T>> = new Array<IList<T>>();
      	var p: IList<T> = this;
      	var i: Int = 0;

      	while(p.nonEmpty) {
			// TODO (Simon) We should verify the type.
        	buffer[i++] = f(p.head); 
        	p = p.tail;
      	}

      	var list: IList<T> = buffer[--n];

      	while(--n > -1) {
        	list = list.prependAll(buffer[n]);
      	}

      	return list;
	}
	
	public function foldLeft(x : T, f : (T -> T -> T)) : T {
		var value: T = x;
      	var p: IList<T> = this;

      	while(p.nonEmpty) {
        	value = f(value, p.head);
        	p = p.tail;
      	}

      	return value;
	}
	
	public function foldRight(x : T, f : (T -> T -> T)) : T {
		var value: T = x;
      	var buffer: Array<T> = toArray;
      	var n: Int = buffer.length;

      	while(--n > -1) {
        	value = f(value, buffer[n]);
      	}

      	return value;
	}
	
	public function forall(f : (T -> Bool)) : Bool {
		var p: IList<T> = this;

      	while(p.nonEmpty) {
        	if(!f(p.head)) {
          		return false;
        	}

        	p = p.tail;
      	}

      	return true;
	}
	
	public function foreach(f : (T -> Void)) : Void {
		var p: IList<T> = this;

      	while(p.nonEmpty) {
        	f(p.head);
        	p = p.tail;
      	}
	}
	
	public function get(index : Int) : Option<T> {
		return productElement(index);
	}
	
	public function map(f : (T -> T)) : IList<T> {
		var n: Int = size;
      	var buffer: Array<List<T>> = new Array<List<T>>();
      	var m: Int = n - 1;

      	var p: IList<T> = this;

      	for(i in 0...n) {
        	buffer[i] = new List<T>(f(p.head), null);
        	p = p.tail;
      	}

      	buffer[m]._tail = nil.list();
		
		var j : Int = 1;
		for(i in 0...m) {
        	buffer[i]._tail = buffer[j];
			j++;
      	}

      	return buffer[0];
	}
	
	public function partition(f : (T -> Bool)) : ITuple2<IList<T>, IList<T>> {
		var left: Array<List<T>> = new Array<List<T>>();
      	var right: Array<List<T>> = new Array<List<T>>();

      	var i: Int = 0;
      	var j: Int = 0;
      	var m: Int = 0;
      	var o: Int = 0;

      	var p: IList<T> = this;

      	while(p.nonEmpty) {
        	if(f(p.head)) {
          		left[i++] = new List<T>(p.head, nil.list());
        	} else {
          		right[j++] = new List<T>(p.head, nil.list());
        	}

        	p = p.tail;
      	}

      	m = i - 1;
      	o = j - 1;

      	if(m > 0) {
			j = 1;
			for(i in 0...m) {
          		left[i]._tail = left[j];
				j++;
        	}
      	}

      	if(o > 0) {
			j = 1;
			for(i in 0...o) {
          		right[i]._tail = right[j];
				j++;
        	}
      	}

      	return tuple2(m > 0 ? left[0] : nil.list(), o > 0 ? right[0] : nil.list()).instance();
	}
	
	override public function equals(that: IFunkObject): Bool {
      	return if (Std.is(that, IList)) {
       		super.equals(that);
      	} else {
			false;
		}
    }
	
	public function prepend(value : T) : IList<T> {
		return new List<T>(value, this);
	}
	
	public function prependAll(value : IList<T>) : IList<T> {
		var n: Int = value.size;

      	if(0 == n) {
        	return this;
      	}

      	var buffer: Array<List<T>> = new Array<List<T>>();
      	var m: Int = n - 1;
      	var p: IList<T> = value;
      	var i: Int = 0;

      	while(p.nonEmpty) {
        	buffer[i++] = new List<T>(p.head, null);
        	p = p.tail;
      	}

      	buffer[m]._tail = this;

		var j : Int = 1;
		for(i in 0...m) {
        	buffer[i]._tail = buffer[j];
			j++;
      	}

      	return buffer[0];
	}
	
	public function reduceLeft(f : (T -> T -> T)) : Option<T> {
		var value: T = head;
      	var p: IList<T> = _tail;

      	while(p.nonEmpty) {
        	value = f(value, p.head);
        	p = p.tail;
      	}

      	return Some(value);
	}
	
	public function reduceRight(f : (T -> T -> T)) : Option<T> {
		var buffer: Array<T> = toArray;
      	var value: T = buffer.pop();
      	var n: Int = buffer.length;

      	while(--n > -1) {
        	value = f(value, buffer[n]);
      	}

      	return Some(value);
	}
	
	public function take(n : Int) : IList<T> {
		require("n must be positive.").toBe(n >= 0);
		
		if(n > size) {
        	return this;
      	} else if(0 == n) {
        	return nil.list();
      	}

      	var buffer: Array<List<T>> = new Array<List<T>>();
      	var m: Int = n - 1;
      	var p: IList<T> = this;

      	for(i in 0...n) {
        	buffer[i] = new List<T>(p.head, null);
        	p = p.tail;
      	}

      	buffer[m]._tail = nil.list();

		var j : Int = 1;
		for(i in 0...m) {
        	buffer[i]._tail = buffer[j];
			j++;
      	}

      	return buffer[0];
	}
	
	public function takeRight(n : Int) : IList<T> {
		require("n must be positive.").toBe(n >= 0);
		
		if(n > size) {
        	return this;
      	} else if(0 == n) {
        	return nil.list();
      	}

      	n = size - n;

      	if(n <= 0) {
        	return this;
      	}

      	var p: IList<T> = this;
		
		for(i in 0...n) {
        	p = p.tail;
      	}

      	return p;
	}
	
	public function takeWhile(f : (IList<T> -> Bool)) : IList<T> {
		var buffer: Array<List<T>> = new Array<List<T>>();
      	var p: IList<T> = this;
      	var n: Int = 0;

      	while(p.nonEmpty) {
        	if(f(p)) {
          		buffer[n++] = new List<T>(p.head, null);
          		p = p.tail;
        	} else {
          		break;
        	}
      	}

      	var m: Int = n - 1;

      	if(m <= 0) {
        	return nil.list();
      	}
      
      	buffer[m]._tail = nil.list();

		var j : Int = 1;
		for(i in 0...m) {
        	buffer[i]._tail = buffer[j];
			j++;
      	}

      	return buffer[0];
	}
	
	public function zip(that : IList<T>) : IList<ITuple2<T, T>> {
		var n: Int = Std.int(Math.min(size, that.size));
      	var m: Int = n - 1;
      	var buffer: Array<List<ITuple2<T, T>>> = new Array<List<ITuple2<T, T>>>();

      	var p: IList<T> = this;
		var q: IList<T> = that;

		for(i in 0...n) {
        	buffer[i] = new List<ITuple2<T, T>>(tuple2(p.head, q.head).instance(), null);
        	p = p.tail;
        	q = q.tail;
      	}

      	buffer[m]._tail = nil.list();

		var j : Int = 1;
		for(i in 0...m) {
        	buffer[i]._tail = buffer[j];
			j++;
      	}

      	return buffer[0];
	}
	
	public function findIndexOf(f: (T -> Bool)): Int {
		var index: Int = 0;
      	var p: IList<T> = this;

      	while(p.nonEmpty) {
        	if(f(p.head)) {
          		return index;
        	}

        	p = p.tail;
        	index += 1;
      	}

      	return -1;
	}
	
	public function indexOf(value : T) : Int {
		var index: Int = 0;
      	var p: IList<T> = this;

      	while(p.nonEmpty) {
        	if(expect(p.head).toEqual(value)) {
          		return index;
        	}

        	p = p.tail;
        	index += 1;
      	}

      	return -1;
	}
	
	public function prependIterator(iterator : Iterator<T>) : IList<T> {
		return prependAll(iterator.toList());
	}
	
	public function prependIterable(iterable : Iterable<T>) : IList<T> {
		return prependAll(iterable.iterator().toList());
	}
	
	public function append(value : T) : IList<T> {
		return new List<T>(value, this);
	}

	public function appendAll(value : IList<T>) : IList<T> {
		return value;
	}

	public function appendIterator(iterator : Iterator<T>) : IList<T> {
		return appendAll(iterator.toList());
	}

	public function appendIterable(iterable : Iterable<T>) : IList<T> {
		return appendAll(iterable.iterator().toList());
	}
	
	override public function productElement(i : Int) : Dynamic {
		var p: IList<T> = this;

      	while(p.nonEmpty) {
        	if(i == 0) {
        	  return p.head;
        	}

        	p = p.tail;
        	i -= 1;
      	}

      throw new NoSuchElementError();
	}
	
	private function get_nonEmpty() : Bool {
		return true;
	}
	
	public function get_isEmpty() : Bool {
		return false;
	}
	
	private function get_head() : T {
		return _head;
	}
	
	private function get_headOption() : Option<T> {
		return Some(_head);
	}
	
	private function get_indices() : IList<Int> {
		var n: Int = size;
      	var p: IList<Int> = nil.list();

      	while(--n > -1) {
        	p = p.prepend(n);
      	}

      	return p;
	}
	
	private function get_init() : IList<T> {
		return dropRight(1);
	}
	
	private function get_last() : Option<T> {
		var p: IList<T> = this;
      	var value: Option<T> = None;
		
      	while(p.nonEmpty) {
        	value = p.headOption;
        	p = p.tail;
      	}
		
      	return value;
	}
	
	private function get_reverse() : IList<T> {
		var result: IList<T> = nil.list();
	    var p: IList<T> = this;
	
	    while(p.nonEmpty) {
	    	result = result.prepend(p.head);
	    	p = p.tail;
	    }
	
	    return result;
	}
	
	private function get_tail() : IList<T> {
		return _tail;
	}
	
	private function get_tailOption() : Option<IList<T>> {
		return Some(_tail);
	}
	
	private function get_zipWithIndex() : IList<ITuple2<T, Int>> {
		var n: Int = size;
      	var m: Int = n - 1;
      	var buffer: Array<List<ITuple2<T, Int>>> = new Array<List<ITuple2<T, Int>>>();

      	var p: IList<T> = this;

		for(i in 0...n) {
        	buffer[i] = new List<ITuple2<T, Int>>(tuple2(p.head, i).instance(), null);
        	p = p.tail;
      	}

      	buffer[m]._tail = nil.list();

		var j : Int = 1;
		for(i in 0...m) {
        	buffer[i]._tail = buffer[j];
			j++;
      	}

      	return buffer[0];
	}
	
	private function get_size() : Int {
		if(_lengthKnown) {
        	return _length;
      	}

      	var p: IList<T> = this;
      	var length: Int = 0;

      	while(p.nonEmpty) {
        	++length;
        	p = p.tail;
      	}

      	_length = length;
      	_lengthKnown = true;

      	return length;
	}
	
	private function get_hasDefinedSize() : Bool {
		return true;
	}

	private function get_toArray() : Array<T> {
		var n: Int = size;
      	var array: Array<T> = new Array<T>();
      	var p: IList<T> = this;

     	for(i in 0...n) {
        	array[i] = p.head;
        	p = p.tail;
      	}

	    return array;
	}
	
	private function get_flatten() : IList<T> {
		return flatMap(function(x: Dynamic): IList<T> { 
			return Std.is(x, IList) ? cast x : x.toList(); 
		});
	}
	
	private function get_iterator() : Iterator<Dynamic> {
		return new ListIterator<Dynamic>(this);
	}
	
	override private function get_productArity() : Int {
		return size;
	}

	override private function get_productPrefix() : String {
		return "List";
	}
}