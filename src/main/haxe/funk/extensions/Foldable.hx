package funk.extensions;

using funk.types.CollectionFoldable;

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
    inline public static function fromFoldable<T>(collection : CollectionFoldable<T>) : Foldable<T> {
        return new Foldable({
            foldLeft: collection.foldLeft,
            foldRight: collection.foldRight
        });
    }
}
