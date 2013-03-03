
package funk.extensions;

using funk.types.CollectionFoldable;
using funk.types.ListFoldable;

typedef Foldables<T> = {
    function foldLeft(value : T, func : T -> T -> T) : Option<T>;
    function foldRight(value : T, func : T -> T -> T) : Option<T>;
}

abstract Foldable<T>(Foldables<T>) {

    inline function new(foldable : Foldables<T>) {
        this = foldable;
    }

    inline public function foldLeft(value : T, func : T -> T -> T) : Option<T> {
        return this.foldLeft(value, func);
    }

    inline public function foldRight(value : T, func : T -> T -> T) : Option<T> {
        return this.foldRight(value, func);
    }

    @:from
    inline public static function fromListFoldable<T>(list : ListFoldable<T>) : Foldable<T> {
        return new Foldable({
            foldLeft: list.foldLeft,
            foldRight: list.foldRight
        });
    }

    @:from
    inline public static function fromCollectionFoldable<T>(collection : CollectionFoldable<T>) : Foldable<T> {
        return new Foldable({
            foldLeft: collection.foldLeft,
            foldRight: collection.foldRight
        });
    }
}
