package funk.types;

using funk.extensions.Collection;
using funk.extensions.Foldable;
using funk.extensions.Iterators;
using funk.extensions.Option;

abstract ArrayFoldable<T>(Array<T>) from Array<T> to Array<T> {

    inline function new(array : Array<T>) {
        this = array;
    }

    inline public function foldLeft<T>(value : T, func : T -> T -> T) : Option<T> {
        var result = value;

        for(i in 0...this.length) {
            result = func(result, this[i]);
        }

        return Option.fromValue(result);
    }

    inline public function foldRight<T>(value : T, func : T -> T -> T) : Option<T> {
        var result = value;

        var total = this.length;
        for(i in 0...total) {
            result = func(result, this[total - 1 - i]);
        }

        return Option.fromValue(result);
    }

    @:from
    inline public static function fromArray<T>(array : Array<T>) : ArrayFoldable<T> {
        return new ArrayFoldable(array);
    }

    @:to
    inline public static function toString<T>(array : Array<T>) : String {
        return 'ArrayFoldable($array)';
    }
}
