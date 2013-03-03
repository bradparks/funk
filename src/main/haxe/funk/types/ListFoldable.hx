package funk.types;

using funk.extensions.List;
using funk.extensions.Foldable;
using funk.extensions.Iterators;
using funk.extensions.Option;

abstract ListFoldable<T>(List<T>) from List<T> to List<T> {

    inline function new(list : List<T>) {
        this = list;
    }

    inline public function foldLeft<T>(value : T, func : T -> T -> T) : Option<T> {
        var result = value;

        var p : List<T> = this;
        while(p.isNonEmpty()) {
            result = func(result, p.head());
            p = p.tail();
        }

        return Option.fromValue(result);
    }

    inline public function foldRight<T>(value : T, func : T -> T -> T) : Option<T> {
        var result = value;

        // TODO (Simon) : Reverse this list.
        var p = this;
        while(p.isNonEmpty()) {
            result = func(result, p.head());
            p = p.tail();
        }

        return Option.fromValue(result);
    }

    @:from
    inline public static function fromList<T>(list : List<T>) : ListFoldable<T> {
        return new ListFoldable(list);
    }

    @:to
    inline public static function toString<T>(list : Lists<T>) : String {
        return 'ListFoldable($list)';
    }
}
