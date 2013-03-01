package funk.extensions;

using funk.extensions.Foldable;
using funk.extensions.Reducible;
using funk.types.CollectionFoldable;
using funk.types.CollectionReducible;

typedef Collections<T> = {> Iterable<T>,
    function size() : Int;
};

abstract Collection<T>(Collections<T>) from Collections<T> to Collections<T> {

    inline function new(collection : Collections<T>) {
        this = collection;
    }

    inline public function iterator() : Iterator<T> {
        return this.iterator();
    }

    inline public function size() : Int {
        return this.size();
    }

    @:from
    inline public static function fromArray<T>(array : Array<T>) : Collection<T> {
        return new Collection({
            iterator: array.iterator,
            size: function() return array.length
        });
    }

    @:to
    inline public static function toFoldable<T>(collection : Collections<T>) : Foldable<T> {
        var foldable0 : CollectionFoldable<T> = CollectionFoldable.fromCollection(collection);
        var foldable1 : Foldable<T> = foldable0;
        return foldable1;
    }

    @:to
    inline public static function toReducible<T>(collection : Collections<T>) : Reducible<T> {
        var reducible0 : CollectionReducible<T> = CollectionReducible.fromCollection(collection);
        var reducible1 : Reducible<T> = reducible0;
        return reducible1;
    }

    @:to
    inline public static function toString<T>(collection : Collections<T>) : String {
        return 'Collection($collection)';
    }
}
