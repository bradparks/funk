package funk.collections;

import funk.collections.IList;
import funk.errors.ArgumentError;
import funk.errors.NoSuchElementError;
import funk.errors.RangeError;
import funk.option.Option;
import funk.tuple.Tuple2;
import funk.Wildcard;

import massive.munit.Assert;
import util.AssertExtensions;

using funk.option.Option;
using funk.tuple.Tuple2;
using funk.Wildcard;

using massive.munit.Assert;
using util.AssertExtensions;

class MapTestBase {

	public var actual : IMap<Dynamic, Dynamic>;

	public var expected : IMap<Dynamic, Dynamic>;

	public var other : IMap<Dynamic, Dynamic>;

	public var filledList : IMap<Dynamic, Dynamic>;

	public var listClassName : String;

	public function generateIntMap(size : Int) : IMap<Int, Int> {
		return null;
	}

	public function convertToMap<T, K, V>(any : T) : IMap<K, V> {
		return null;
	}

	@Test
	public function should_be_not_empty():Void {
		actual.nonEmpty.isTrue();
	}

	@Test
	public function should_be_empty():Void {
		actual.isEmpty.isFalse();
	}

	@Test
	public function should_have_5_size():Void {
		var value = 5;
		generateIntMap(value).size.areEqual(value);
	}

	@Test
	public function should_generate_correct_list():Void {
		generateIntMap(5).productPrefix.areEqual(listClassName);
	}

	@Test
	public function should_have_99999_size():Void {
		var value = 9999;
		generateIntMap(value).size.areEqual(value);
	}

	@Test
	public function should_have_a_defined_size():Void {
		actual.hasDefinedSize.isTrue();
	}

	@Test
	public function should_call_count() : Void {
		var exp = 5;
		var act = 0;
		generateIntMap(exp).count(function(k, v) {
			act++;
			return true;
		});
		act.areEqual(exp);
	}

	@Test
	public function should_count_be_same_as_expected() : Void {
		var exp = 5;
		var act = generateIntMap(exp).count(function(k, v) {
			return true;
		});
		act.areEqual(exp);
	}

	@Test
	public function should_count_be_0() : Void {
		var exp = 0;
		var act = generateIntMap(exp).count(function(k, v) {
			return false;
		});
		act.areEqual(exp);
	}

	@Test
	public function should_count_5_be_0() : Void {
		var exp = 5;
		var act = generateIntMap(exp).count(function(k, v) {
			return false;
		});
		act.areEqual(0);
	}

	@Test
	public function when_drop_0__return_same_list() : Void {
		actual.drop(0).areEqual(actual);
	}

	@Test
	public function when_drop_3__return_IList() : Void {
		actual.drop(2).isType(IList);
	}

	@Test
	public function when_drop_2__return_size_2() : Void {
		actual.drop(2).size.areEqual(2);
	}

	@Test
	public function when_drop_4__return_size_0() : Void {
		actual.drop(4).size.areEqual(0);
	}

	@Test
	public function when_drop_5__return_size_0() : Void {
		actual.drop(5).size.areEqual(0);
	}

	@Test
	public function when_drop_2__return_get_0__1_is_2() : Void {
		var opt : IOption<ITuple2<Int, Int>> = generateIntMap(5).drop(2).get(0);
		opt.get()._1.areEqual(2);
	}

	@Test
	public function when_drop_2__return_get_0__2_is_2() : Void {
		var opt : IOption<ITuple2<Int, Int>> = generateIntMap(5).drop(2).get(0);
		opt.get()._2.areEqual(2);
	}

	@Test
	public function when_drop_2__return_get_1__1_is_3() : Void {
		var opt : IOption<ITuple2<Int, Int>> = generateIntMap(5).drop(2).get(1);
		opt.get()._1.areEqual(3);
	}

	@Test
	public function when_drop_2__return_get_1__2_is_3() : Void {
		var opt : IOption<ITuple2<Int, Int>> = generateIntMap(5).drop(2).get(1);
		opt.get()._2.areEqual(3);
	}

	@Test
	public function when_drop_2_then_1__return_get_0_is_3() : Void {
		var opt : IOption<ITuple2<Int, Int>> = generateIntMap(5).drop(2).drop(1).get(0);
		opt.get()._2.areEqual(3);
	}

	@Test
	public function when_drop_on_list__throw_argument_when_passing_minus_to_drop() : Void {
		var called = try {
			actual.drop(-1);
			false;
		} catch(error : ArgumentError) {
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_dropRight_0_on_list__return_same_list() : Void {
		actual.dropRight(0).areEqual(actual);
	}

	@Test
	public function when_dropRight_1_on_list__return_and_get_0_equals_0() : Void {
		generateIntMap(5).dropRight(1).get(0).get().areEqual(0);
	}

	@Test
	public function when_dropRight_2_on_list__return_and_get_2_equals_2() : Void {
		generateIntMap(5).dropRight(2).get(2).get().areEqual(2);
	}

	@Test
	public function when_dropRight_4__return_size_0() : Void {
		actual.dropRight(4).size.areEqual(0);
	}

	@Test
	public function when_dropRight_5__return_size_0() : Void {
		actual.dropRight(5).size.areEqual(0);
	}

	@Test
	public function when_dropRight_on_list__throw_argument_when_passing_minus_to_dropRight() : Void {
		var called = try {
			actual.dropRight(-1);
			false;
		} catch(error : ArgumentError) {
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_dropWhile__return_not_null() : Void {
		generateIntMap(5).dropWhile(function(k, v):Bool {
			return v < 2;
		}).isNotNull();
	}

	@Test
	public function when_dropWhile__return_is_type_of_list() : Void {
		generateIntMap(5).dropWhile(function(k, v):Bool {
			return v < 2;
		}).isType(IList);
	}

	@Test
	public function when_dropWhile__return_size_is_3() : Void {
		generateIntMap(5).dropWhile(function(k, v):Bool {
			return v < 2;
		}).size.areEqual(3);
	}

	@Test
	public function when_dropWhile__return_get_2_equals_4() : Void {
		generateIntMap(5).dropWhile(function(k, v):Bool {
			return v < 2;
		}).get(2).get().areEqual(4);
	}

	@Test
	public function when_dropWhile__return_size_equals_0() : Void {
		generateIntMap(5).dropWhile(function(k, v):Bool {
			return true;
		}).size.areEqual(0);
	}

	@Test
	public function when_exists__should_return_true_when_calling_exists() : Void {
		actual.exists(function(k, v):Bool {
			return v == 2;
		}).isTrue();
	}

	@Test
	public function when_exists_all_false__should_return_false_when_calling_exists() : Void {
		actual.exists(function(k, v):Bool {
			return false;
		}).isFalse();
	}

	@Test
	public function when_exists_all_true__should_return_true_when_calling_exists() : Void {
		actual.exists(function(k, v):Bool {
			return true;
		}).isTrue();
	}

	@Test
	public function when_filter__should_return_list() : Void {
		actual.filter(function(k, v):Bool {
			return v == 1;
		}).isType(IMap);
	}

	@Test
	public function when_filter__should_return_list_of_size_1() : Void {
		actual.filter(function(k, v):Bool {
			return v == 1;
		}).size.areEqual(1);
	}

	@Test
	public function when_filter__should_return_even_list_of_size_2() : Void {
		actual.filter(function(k, v):Bool {
			return v % 2 == 0;
		}).size.areEqual(2);
	}

	@Test
	public function when_filter_all__should_return_size_of_4() : Void {
		actual.filter(function(k, v):Bool {
			return true;
		}).size.areEqual(4);
	}

	@Test
	public function when_filter_all_false__should_return_size_of_0() : Void {
		actual.filter(function(k, v):Bool {
			return false;
		}).size.areEqual(0);
	}

	@Test
	public function when_filterNot__should_return_list() : Void {
		actual.filterNot(function(k, v):Bool {
			return v == 1;
		}).isType(IMap);
	}

	@Test
	public function when_filterNot__should_return_list_of_size_4() : Void {
		actual.filterNot(function(k, v):Bool {
			return v == 1;
		}).size.areEqual(3);
	}

	@Test
	public function when_filterNot__should_return_even_list_of_size_2() : Void {
		actual.filterNot(function(k, v):Bool {
			return v % 2 == 0;
		}).size.areEqual(2);
	}

	@Test
	public function when_filterNot_all__should_return_size_of_4() : Void {
		actual.filterNot(function(k, v):Bool {
			return false;
		}).size.areEqual(4);
	}

	@Test
	public function when_filterNot_all_true__should_return_size_of_0() : Void {
		actual.filterNot(function(k, v):Bool {
			return true;
		}).size.areEqual(0);
	}

	@Test
	public function when_find__should_return_Option() : Void {
		actual.find(function(k, v):Bool {
			return v == 2;
		}).isType(IOption);
	}

	@Test
	public function when_find__should_return_Some() : Void {
		actual.find(function(k, v):Bool {
			return v == 2;
		}).isDefined().isTrue();
	}

	@Test
	public function when_find__should_call_find() : Void {
		var called = false;
		actual.find(function(k, v):Bool {
			called = true;
			return v == 2;
		});
		called.isTrue();
	}

	@Test
	public function when_find_all_false__should_return_none() : Void {
		actual.find(function(k, v):Bool {
			return false;
		}).isEmpty().isTrue();
	}

	@Test
	public function when_zip__should_not_be_null() : Void {
		actual.zip(other).isNotNull();
	}

	@Test
	public function when_zip__should_be_be_size_0() : Void {
		actual.zip(other).size.areEqual(0);
	}

	@Test
	public function when_zip__should_be_be_size_4() : Void {
		actual.zip(filledList).size.areEqual(4);
	}

	@Test
	public function when_zip__should_calling_get_0_return_tuple2() : Void {
		actual.zip(filledList).get(0).get().isType(ITuple2);
	}

	@Test
	public function when_zip__should_calling_get_3_return_tuple2() : Void {
		actual.zip(filledList).get(3).get().isType(ITuple2);
	}

	@Test
	public function when_zip__should_calling_get_3_return_tuple2_and__1_equals_4() : Void {
		actual.zip(filledList).get(3).get()._1.areEqual(4);
	}

	@Test
	public function when_zip__should_calling_get_2_return_tuple2_and__2_equals_3() : Void {
		actual.zip(filledList).get(2).get()._2.areEqual(3);
	}

	@Test
	public function when_map__should_return_list() : Void {
		actual.map(function(t) : ITuple2<Dynamic, Dynamic> {
			return tuple2(t._1, t._2 + 1).toInstance();
		}).isType(IMap);
	}

	@Test
	public function when_map__should_return_list_of_size_4() : Void {
		actual.map(function(t) : ITuple2<Dynamic, Dynamic> {
			return tuple2(t._1, t._2 + 1).toInstance();
		}).size.areEqual(4);
	}

	@Test
	public function when_map__should_calling_get_0_return_2() : Void {
		actual.map(function(t) : ITuple2<Dynamic, Dynamic> {
			return tuple2(t._1, t._2 + 1).toInstance();
		}).get(0).get().areEqual(2);
	}

	@Test
	public function when_map__should_calling_get_1_return_3() : Void {
		actual.map(function(t) : ITuple2<Dynamic, Dynamic> {
			return tuple2(t._1, t._2 + 1).toInstance();
		}).get(1).get().areEqual(3);
	}

	@Test
	public function when_map__should_calling_get_2_return_4() : Void {
		actual.map(function(t) : ITuple2<Dynamic, Dynamic> {
			return tuple2(t._1, t._2 + 1).toInstance();
		}).get(2).get().areEqual(4);
	}

	@Test
	public function when_map__should_calling_get_3_return_5() : Void {
		actual.map(function(t) : ITuple2<Dynamic, Dynamic> {
			return tuple2(t._1, t._2 + 1).toInstance();
		}).get(3).get().areEqual(5);
	}

	@Test
	public function when_map__should_calling_get_0_return_Hello1() : Void {
		actual.map(function(t) : ITuple2<Dynamic, Dynamic> {
			return tuple2(t._1, "Hello" + t._2).toInstance();
		}).get(0).get().areEqual("Hello1");
	}

	@Test
	public function when_map__should_calling_get_0_return_same_instance_as_past_in() : Void {
		var instance = {};
		Assert.areEqual(actual.map(function(t) : ITuple2<Dynamic, Dynamic> {
			return tuple2(t._1, instance).toInstance();
		}).get(0).get()._2, instance);
	}

	@Test
	public function when_find__should_return_size_of_16() : Void {
		actual.flatMap(function(t):IMap<Dynamic, Dynamic> {
			return expected;
		}).size.areEqual(16);
	}

	@Test
	public function when_flatMap__should_return_a_list_containing_concat_lists() : Void {
		var result = actual.flatMap(function(t):IMap<Dynamic, Dynamic> {
			return expected;
		});
		result.equals(convertToMap([1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4])).isTrue();
	}

	@Test
	public function when_flatten__should_flatten_list() : Void {
		actual.flatten.equals(filledList).isTrue();
	}

	@Test
	public function when_flatten__should_flatten_sublists() : Void {
		var a = convertToMap([convertToMap([1, 2, 3, 4]), convertToMap([5, 6, 7, 8]), convertToMap([9, 10])]);
		a.flatten.equals(convertToMap([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])).isTrue();
	}

	@Test
	public function when_fold__should_foldLeft_should_return_10() : Void {
		actual.foldLeft(tuple2(0, 0).toInstance(), function(t0, t1){
			return tuple2(t0._1 + t1._1, t0._2 + t1._2).toInstance();
		})._2.areEqual(10);
	}

	@Test
	public function when_fold__should_foldLeft_should_return_11() : Void {
		actual.foldLeft(tuple2(0, 1).toInstance(), function(t0, t1){
			return tuple2(t0._1 + t1._1, t0._2 + t1._2).toInstance();
		})._2.areEqual(11);
	}

	@Test
	public function when_fold__should_call_foldLeft() : Void {
		actual.foldLeft(tuple2(0, 1).toInstance(), function(t0, t1) {
			return tuple2(0, 0).toInstance();
		})._2.areEqual(0);
	}

	@Test
	public function when_fold__should_foldRight_should_return_10() : Void {
		actual.foldRight(tuple2(0, 0).toInstance(), function(t0, t1){
			return tuple2(t0._1 + t1._1, t0._2 + t1._2).toInstance();
		})._2.areEqual(10);
	}

	@Test
	public function when_fold__should_foldRight_should_return_11() : Void {
		actual.foldRight(tuple2(0, 1).toInstance(), function(t0, t1){
			return tuple2(t0._1 + t1._1, t0._2 + t1._2).toInstance();
		})._2.areEqual(11);
	}

	@Test
	public function when_fold__should_call_foldRight() : Void {
		actual.foldRight(tuple2(0, 1).toInstance(), function(t0, t1) {
			return tuple2(0, 0).toInstance();
		})._2.areEqual(0);
	}

	@Test
	public function when_forall__should_return_true() : Void {
		actual.forall(function(k, v) : Bool {
			return true;
		}).isTrue();
	}

	@Test
	public function when_forall__should_return_false_if_value_is_less_than_2() : Void {
		actual.forall(function(k, v) : Bool {
			return v == 2;
		}).isFalse();
	}

	@Test
	public function when_foreach__should_run_function() : Void {
		var called = false;
		actual.foreach(function(k, v) : Void {
			called = true;
		});
		called.isTrue();
	}

	@Test
	public function when_partition__should_return_isNotNull() : Void {
		actual.partition(function(k, v) : Bool {
			return true;
		}).isNotNull();
	}

	@Test
	public function when_partition__should_return_a_ITuple2() : Void {
		actual.partition(function(k, v) : Bool {
			return true;
		}).isType(ITuple2);
	}

	@Test
	public function when_partition__should_return_a_ITuple2_and__1_is_IList() : Void {
		actual.partition(function(k, v) : Bool {
			return true;
		})._1.isType(IList);
	}

	@Test
	public function when_partition_false__should_return_a_ITuple2_and__2_is_IList() : Void {
		actual.partition(function(k, v) : Bool {
			return false;
		})._2.isType(IList);
	}

	@Test
	public function when_partition_false__should_return_a_ITuple2_and__1_is_empty() : Void {
		actual.partition(function(k, v) : Bool {
			return false;
		})._1.isEmpty.isTrue();
	}

	@Test
	public function when_partition_false__should_return_a_ITuple2_and__2_is_empty() : Void {
		actual.partition(function(k, v) : Bool {
			return true;
		})._2.isEmpty.isTrue();
	}

	@Test
	public function when_partition__should_return_a_ITuple2_and__1_is_IList_of_size_2() : Void {
		actual.partition(function(k, v) : Bool {
			return v % 2 == 0;
		})._1.size.areEqual(2);
	}

	@Test
	public function when_partition__should_return_a_ITuple2_and__2_is_IList() : Void {
		actual.partition(function(k, v) : Bool {
			return true;
		})._2.isType(IList);
	}

	@Test
	public function when_partition__should_return_a_ITuple2_and__2_is_IList_of_size_2() : Void {
		actual.partition(function(k, v) : Bool {
			return v % 2 == 0;
		})._2.size.areEqual(2);
	}

	@Test
	public function when_reduceRight__should_return_Option() : Void {
		actual.reduceRight(function(a, b) {
			return tuple2(a._1 + b._1, a._2 + b._2).toInstance();
		}).isType(IOption);
	}

	@Test
	public function when_reduceRight__should_return_Some() : Void {
		actual.reduceRight(function(a, b) {
			return tuple2(-1, -1).toInstance();
		}).isDefined().isTrue();
	}

	@Test
	public function when_reduceRight__should_call_method() : Void {
		var called = false;
		actual.reduceRight(function(a, b) {
			called = true;
			return tuple2(-1, -1).toInstance();
		});
		called.isTrue();
	}

	@Test
	public function when_reduceRight__should_return_10() : Void {
		Assert.areEqual(actual.reduceRight(function(a, b) {
			return tuple2(a._1 + a._1, a._2 + b._2).toInstance();
		}).get()._2, 10);
	}

	@Test
	public function when_reduceRight__should_return_fedcba() : Void {
		Assert.areEqual(convertToMap("abcdef").reduceRight(function(a, b) {
			return tuple2(0, a._2 + b._2).toInstance();
		}).get()._2, "fedcba");
	}

	@Test
	public function when_reduceLeft__should_return_Option() : Void {
		actual.reduceLeft(function(a, b) {
			return tuple2(a._1 + b._1, a._2 + b._2).toInstance();
		}).isType(IOption);
	}

	@Test
	public function when_reduceLeft__should_return_Some() : Void {
		actual.reduceLeft(function(a, b) {
			return tuple2(-1, -1).toInstance();
		}).isDefined().isTrue();
	}

	@Test
	public function when_reduceLeft__should_call_method() : Void {
		var called = false;
		actual.reduceLeft(function(a, b) {
			called = true;
			return tuple2(-1, -1).toInstance();
		});
		called.isTrue();
	}

	@Test
	public function when_reduceLeft__should_return_10() : Void {
		Assert.areEqual(actual.reduceLeft(function(a, b) {
			return tuple2(-1, -1).toInstance();
		}).get(), 10);
	}

	@Test
	public function when_reduceLeft__should_return_abcdef() : Void {
		Assert.areEqual(convertToMap("abcdef").reduceLeft(function(a, b) {
			return tuple2(a._1 + b._1, a._2 + b._2).toInstance();
		}).get(), "abcdef");
	}

	@Test
	public function when_take_0__should_return_isNotNull() : Void {
		actual.take(0).isNotNull();
	}

	@Test
	public function when_take_0___should_return_valid_IList() : Void {
		actual.take(0).isType(IList);
	}

	@Test
	public function when_take_0__should_return_size_0() : Void {
		actual.take(0).size.areEqual(0);
	}

	@Test
	public function when_take_1__should_return_size_1() : Void {
		actual.take(1).size.areEqual(1);
	}

	@Test
	public function when_take_10__should_return_size_4() : Void {
		actual.take(10).size.areEqual(4);
	}

	@Test
	public function when_take_1__should_return_1() : Void {
		Assert.areEqual(actual.take(1).get(0).get(), 1);
	}

	@Test
	public function when_take_minus_1__should_throw_error() : Void {
		var called = try {
			actual.take(-1);
			false;
		} catch(error : ArgumentError){
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_takeRight_0__should_return_isNotNull() : Void {
		actual.takeRight(0).isNotNull();
	}

	@Test
	public function when_takeRight_0___should_return_valid_IList() : Void {
		actual.takeRight(0).isType(IList);
	}

	@Test
	public function when_takeRight_0__should_return_size_0() : Void {
		actual.takeRight(0).size.areEqual(0);
	}

	@Test
	public function when_takeRight_1__should_return_size_1() : Void {
		actual.takeRight(1).size.areEqual(1);
	}

	@Test
	public function when_takeRight_10__should_return_size_4() : Void {
		actual.takeRight(10).size.areEqual(4);
	}

	@Test
	public function when_takeRight_1__should_return_4() : Void {
		Assert.areEqual(actual.takeRight(1).get(0).get(), 4);
	}

	@Test
	public function when_takeRight_minus_1__should_throw_error() : Void {
		var called = try {
			actual.takeRight(-1);
			false;
		} catch(error : ArgumentError){
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_takeWhile__should_return_isNotNull() : Void {
		actual.takeWhile(function(t) : Bool {
			return true;
		}).isNotNull();
	}

	@Test
	public function when_takeWhile__should_return_valid_IList() : Void {
		actual.takeWhile(function(t) : Bool {
			return true;
		}).isType(IList);
	}

	@Test
	public function when_takeWhile__should_return_size_4() : Void {
		actual.takeWhile(function(t) : Bool {
			return true;
		}).size.areEqual(4);
	}

	@Test
	public function when_takeWhile__should_return_size_0() : Void {
		actual.takeWhile(function(t) : Bool {
			return false;
		}).size.areEqual(0);
	}

	@Test
	public function when_takeWhile__should_return_nil() : Void {
		actual.takeWhile(function(t) : Bool {
			return false;
		}).areEqual(other);
	}

	@Test
	public function when_takeWhile__should_return_size_2() : Void {
		actual.takeWhile(function(t) : Bool {
			return t._2 <= 2;
		}).size.areEqual(2);
	}

	@Test
	public function when_takeWhile__should_call_method() : Void {
		var called = false;
		actual.takeWhile(function(t) : Bool {
			called = true;
			return true;
		});
		called.isTrue();
	}

	@Test
	public function when_get_0__should_return_Option() : Void {
		actual.get(0).isType(IOption);
	}

	@Test
	public function when_get_0__should_return_None() : Void {
		actual.get(0).isDefined().isTrue();
	}

	@Test
	public function when_get_0__should_return_1() : Void {
		Assert.areEqual(actual.get(0).get()._2, 1);
	}

	@Test
	public function when_take__should_not_return_null() : Void {
		actual.take(0).isNotNull();
	}

	@Test
	public function when_take__should_return_list() : Void {
		actual.take(0).areEqual(other);
	}

	@Test
	public function when_take__should_return_list_of_size_0() : Void {
		actual.take(0).size.areEqual(0);
	}

	@Test
	public function when_take_with_1__should_return_list_with_1() : Void {
		Assert.areEqual(actual.take(1).get(0).get()._2, 1);
	}

	@Test
	public function when_take_with_2__should_return_list_with_2() : Void {
		Assert.areEqual(actual.take(2).get(1).get()._2, 2);
	}

	@Test
	public function when_takeRight__should_not_return_null() : Void {
		actual.takeRight(0).isNotNull();
	}

	@Test
	public function when_takeRight__should_return_list() : Void {
		actual.takeRight(0).areEqual(other);
	}

	@Test
	public function when_takeRight__should_return_list_of_size_0() : Void {
		actual.takeRight(0).size.areEqual(0);
	}

	@Test
	public function when_takeRight_with_1__should_return_list_with_4() : Void {
		Assert.areEqual(actual.takeRight(1).get(0).get()._2, 4);
	}

	@Test
	public function when_takeRight_with_2__should_return_list_with_4() : Void {
		Assert.areEqual(actual.takeRight(2).get(1).get()._2, 4);
	}

	@Test
	public function when_contains__should_not_contain_null() : Void {
		actual.contains(null).isFalse();
	}

	@Test
	public function when_contains__should_not_contain_true() : Void {
		actual.contains(true).isFalse();
	}

	@Test
	public function when_contains__should_not_contain_object() : Void {
		actual.contains({}).isFalse();
	}

	@Test
	public function when_contains__should_not_contain_array() : Void {
		actual.contains([]).isFalse();
	}

	@Test
	public function when_contains__should_contain_1() : Void {
		actual.contains(1).isTrue();
	}

	@Test
	public function when_contains__should_contain_2() : Void {
		actual.contains(2).isTrue();
	}

	@Test
	public function when_contains__should_contain_3() : Void {
		actual.contains(3).isTrue();
	}

	@Test
	public function when_contains__should_contain_4() : Void {
		actual.contains(4).isTrue();
	}

	@Test
	public function when_toArray__should_not_be_null() : Void {
		actual.toArray.isNotNull();
	}

	@Test
	public function when_toArray__should_be_length_4() : Void {
		actual.toArray.length.areEqual(4);
	}

	@Test
	public function when_toArray__should_value_0_be_1() : Void {
		Assert.areEqual(actual.toArray[0], 1);
	}

	@Test
	public function when_toArray__should_value_1_be_2() : Void {
		Assert.areEqual(actual.toArray[1], 2);
	}

	@Test
	public function when_toArray__should_value_2_be_3() : Void {
		Assert.areEqual(actual.toArray[2], 3);
	}

	@Test
	public function when_toArray__should_value_3_be_4() : Void {
		Assert.areEqual(actual.toArray[3], 4);
	}

	@Test
	public function when_head__should_not_be_null() : Void {
		actual.head.isNotNull();
	}

	@Test
	public function when_head__should_be_1() : Void {
		Assert.areEqual(actual.head, 1);
	}

	@Test
	public function when_headOption__should_be_Option() : Void {
		actual.headOption.isType(IOption);
	}

	@Test
	public function when_headOption__should_be_Some() : Void {
		actual.headOption.isDefined().isTrue();
	}

	@Test
	public function when_headOption__should_be_Some_of_value_1() : Void {
		Assert.areEqual(actual.headOption.get(), 1);
	}

	@Test
	public function when_tail__should_not_be_null() : Void {
		actual.tail.isNotNull();
	}

	@Test
	public function when_tail__should_be_2_3_4() : Void {
		actual.tail.equals(convertToMap([2, 3, 4])).isTrue();
	}

	@Test
	public function when_tailOption__should_be_Option() : Void {
		actual.tailOption.isType(IOption);
	}

	@Test
	public function when_tailOption__should_be_Some() : Void {
		actual.tailOption.isDefined().isTrue();
	}

	@Test
	public function when_tailOption__should_be_Some_value_of_2_3_4() : Void {
		actual.tailOption.get().equals(convertToMap([2, 3, 4])).isTrue();
	}

	@Test
	public function when_zipWithIndex__should_not_be_null() : Void {
		actual.zipWithIndex.isNotNull();
	}

	@Test
	public function when_zipWithIndex__should_be_equal_to_nil() : Void {
		actual.zipWithIndex.equals(convertToMap([	tuple2(1, 0).toInstance(),
													tuple2(2, 1).toInstance(),
													tuple2(3, 2).toInstance(),
													tuple2(4, 3).toInstance()
													])).isTrue();
	}

	@Test
	public function when_productArity__should_be_equal_to_4() : Void {
		actual.productArity.areEqual(4);
	}

	@Test
	public function when_calling_productElement__should_throw_RangeError() : Void {
		var called = try {
			actual.productElement(5);
			false;
		} catch(e : RangeError) {
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_calling_append__should_not_be_null() : Void {
		actual.add(1, 5).isNotNull();
	}

	@Test
	public function when_calling_append__should_be_size_5() : Void {
		actual.add(1, 5).size.areEqual(5);
	}

	@Test
	public function when_calling_append__should_equal_1_2_3_4_5() : Void {
		actual.add(5, 5).equals(convertToMap([1, 2, 3, 4, 5])).isTrue();
	}

	@Test
	public function when_calling_appendIterable__should_not_be_null() : Void {
		actual.addIterable({iterator: filledList.productIterator}).isNotNull();
	}

	@Test
	public function when_calling_appendIterable__should_be_size_8() : Void {
		actual.addIterable({iterator: filledList.productIterator}).size.areEqual(8);
	}

	@Test
	public function when_calling_appendIterable__should_be_size_1_2_3_4_1_2_3_4() : Void {
		actual.addIterable({iterator: filledList.productIterator}).equals(convertToMap([1, 2, 3, 4, 1, 2, 3, 4])).isTrue();
	}

	@Test
	public function when_calling_iterator__should_not_be_null() : Void {
		actual.addIterator(filledList.productIterator()).isNotNull();
	}

	@Test
	public function when_calling_iterator__should_be_size_8() : Void {
		actual.addIterator(filledList.productIterator()).size.areEqual(8);
	}

	@Test
	public function when_calling_appendAll__should_not_be_null() : Void {
		actual.addAll(other).isNotNull();
	}

	@Test
	public function when_calling_appendAll__should_be_size_8() : Void {
		actual.addAll(filledList).size.areEqual(8);
	}

	@Test
	public function when_calling_appendAll__should_be_1_2_3_4_1_2_3_4() : Void {
		actual.addAll(filledList).equals(convertToMap([1, 2, 3, 4, 1, 2, 3, 4])).isTrue();
	}

	@Test
	public function when_calling_toString_should_return_List() : Void {
		actual.toString().areEqual(Std.format('$listClassName(tuple2(0, 1), tuple2(0, 2), tuple2(0, 3), tuple2(0, 4))'));
	}

	@Test
	public function when_calling_productPrefix_on_list_should_return_List() : Void {
		actual.productPrefix.areEqual(Std.format('$listClassName'));
	}

	@Test
	public function when_calling_productIterator_on_list_is_not_null() : Void {
		actual.productIterator().isNotNull();
	}

	@Test
	public function when_calling_productIterator_on_list_should_hasNext_be_true() : Void {
		actual.productIterator().hasNext().isTrue();
	}

	@Test
	public function when_calling_productIterator_on_list_should_next_be_1() : Void {
		actual.productIterator().next().areEqual(1);
	}

	@Test
	public function when_calling_productIterator_on_list_should_next_be_2() : Void {
		var iterator = actual.productIterator();
		iterator.next();
		iterator.next().areEqual(2);
	}

	@Test
	public function when_calling_productIterator_on_list_should_next_be_3() : Void {
		var iterator = actual.productIterator();
		iterator.next();
		iterator.next();
		iterator.next().areEqual(3);
	}

	@Test
	public function when_calling_productIterator_on_list_should_next_be_4() : Void {
		var iterator = actual.productIterator();
		iterator.next();
		iterator.next();
		iterator.next();
		iterator.next().areEqual(4);
	}

	@Test
	public function when_calling_productIterator_on_list_should_throw_error_when_iterator_is_exhausted() : Void {
		var iterator = actual.productIterator();
		iterator.next();
		iterator.next();
		iterator.next();
		iterator.next();

		var called = try {
			iterator.next();
			false;
		} catch (error : NoSuchElementError) {
			true;
		}
		called.isTrue();
	}

	@Test
	public function when_calling_productIterator_on_list_should_nextOption_be_1() : Void {
		var iterator : MapIterator<Int, Int> = cast actual.productIterator();
		iterator.nextOption().get()._2.areEqual(1);
	}

	@Test
	public function when_calling_productIterator_on_list_should_nextOption_be_2() : Void {
		var iterator : MapIterator<Int, Int> = cast actual.productIterator();
		iterator.next();
		iterator.nextOption().get()._2.areEqual(2);
	}

	@Test
	public function when_calling_productIterator_on_list_should_nextOption_be_3() : Void {
		var iterator : MapIterator<Int, Int> = cast actual.productIterator();
		iterator.next();
		iterator.next();
		iterator.nextOption().get()._2.areEqual(3);
	}

	@Test
	public function when_calling_productIterator_on_list_should_nextOption_be_4() : Void {
		var iterator : MapIterator<Int, Int> = cast actual.productIterator();
		iterator.next();
		iterator.next();
		iterator.next();
		iterator.nextOption().get()._2.areEqual(4);
	}

	@Test
	public function when_calling_productIterator_on_list_should_return_Option() : Void {
		var iterator : MapIterator<Int, Int> = cast actual.productIterator();
		iterator.next();
		iterator.next();
		iterator.next();
		iterator.next();

		iterator.nextOption().isType(IOption);
	}

	@Test
	public function when_calling_productIterator_on_list_should_return_None() : Void {
		var iterator : MapIterator<Int, Int> = cast actual.productIterator();
		iterator.next();
		iterator.next();
		iterator.next();
		iterator.next();

		iterator.nextOption().isEmpty().isTrue();
	}
}
