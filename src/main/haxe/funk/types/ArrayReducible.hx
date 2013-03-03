package funk.types;

using funk.extensions.Reducible;
using funk.extensions.Iterators;
using funk.extensions.Option;

abstract ArrayReducible<T>(Array<T>) from Array<T> to Array<T> {

    inline function new(array : Array<T>) {
        this = array;
    }

    inline public function reduceLeft<T>(func : T -> T -> T) : Option<T> {
        return None;
    }

    inline public function reduceRight<T>(func : T -> T -> T) : Option<T> {
        return None;
    }

    @:from
    inline public static function fromArray<T>(array : Array<T>) : ArrayReducible<T> {
        return new ArrayReducible(array);
    }

    @:to
    inline public static function toString<T>(array : Array<T>) : String {
        return 'ArrayReducible($array)';
    }
}
