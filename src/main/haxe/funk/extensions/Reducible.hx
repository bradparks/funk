package funk.extensions;

using funk.types.CollectionReducible;

typedef Reducibles<T> = {
    function reduceLeft(func : T -> T -> T) : Option<T>;
    function reduceRight(func : T -> T -> T) : Option<T>;
}

abstract Reducible<T>(Reducibles<T>) {

    inline function new(reducibles : Reducibles<T>) {
        this = reducibles;
    }

    inline public function reduceLeft(func : T -> T -> T) : Option<T> {
        return this.reduceLeft(func);
    }

    inline public function reduceRight(func : T -> T -> T) : Option<T> {
        return this.reduceRight(func);
    }

    @:from
    inline public static function fromReducible<T>(collection : CollectionReducible<T>) : Reducible<T> {
        return new Reducible({
            reduceLeft: collection.reduceLeft,
            reduceRight: collection.reduceRight
        });
    }
}
