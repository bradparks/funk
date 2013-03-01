package funk.types;

using funk.extensions.Collection;
using funk.extensions.Reducible;
using funk.extensions.Iterators;
using funk.extensions.Option;

abstract CollectionReducible<T>(Collection<T>) from Collection<T> to Collection<T> {

    inline function new(collection : Collection<T>) {
        this = collection;
    }

    inline public function reduceLeft<T>(func : T -> T -> T) : Option<T> {
        return None;
    }

    inline public function reduceRight<T>(func : T -> T -> T) : Option<T> {
        return None;
    }

    @:from
    inline public static function fromCollection<T>(collection : Collection<T>) : CollectionReducible<T> {
        return new CollectionReducible(collection);
    }

    @:to
    inline public static function toString<T>(collection : Collections<T>) : String {
        return 'CollectionReducible($collection)';
    }
}
