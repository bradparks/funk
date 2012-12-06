package funk.collections.extensions;

import Type;
import Lambda;
import funk.Funk;
import funk.collections.Collection;
import funk.collections.immutable.List;
import funk.collections.immutable.extensions.Lists;
import funk.types.extensions.Strings;

using Lambda;
using funk.collections.immutable.extensions.Lists;

class CollectionsUtil {

	inline private static var NAME : String = 'Collection';

	inline private static var REFLECT_NAME : String = '__reflect__';

	public static function zero<T>() : Collection<T> {
		// TODO (Simon) : We could optimise this.
		return toCollection([]);
	}

	public static function toCollection<T, R>(x : T) : Collection<R> {
		var valueType : ValueType = Type.typeof(x);

		var size : Int = -1;
		var iterable : Iterable<R> = null;

		switch (valueType) {
			case TEnum(e):
				if (e == List) {
					return (cast e).collection();
				} 
			case TObject:
				if (Reflect.hasField(x, REFLECT_NAME)) {
					var reflect = Reflect.field(x, REFLECT_NAME);
					if (Reflect.field(reflect, 'id') == NAME) {
						return cast x;
					}
				} 
			case TClass(c):
				if (c == Array) {
					var array : Array<R> = cast x;
					size = array.length;
					iterable = array;
				} else if (c == String) {
					var string : String = cast x;
					size = string.length;
					iterable = {
						iterator: function() {
							return cast Strings.iterator(string);
						}
					};
				} else {
					var instanceFields : Array<String> = Type.getInstanceFields(c);
					if (instanceFields.indexOf('size') >= 0 && instanceFields.indexOf('iterator') >= 0) {
						// We have a possible match
						return cast x;
					}
				}

			default:
		}

		// If none exist, create it.
		if (size == -1 && null == iterable) {
			iterable = cast [x];
			size = 1;
		}

		var collection : Collection<R> = {
			iterator: function () {
				return iterable.iterator();
			},
			size: function() {
				return size;
			}
		};

		Reflect.setField(collection, REFLECT_NAME, {
			id: NAME,
			type: valueType
		});

		return collection;
	}
}