package funk.types;

using funk.extensions.Collection;
using funk.extensions.Foldable;
using funk.extensions.Option;

abstract CollectionFoldable<T>(Collection<T>) from Collection<T> to Collection<T> {

    inline function new(collection : Collection<T>) {
        this = collection;
    }

    inline public function foldLeft<T>(value : T, func : T -> T -> T) : Option<T> {
        var result = value;

        var iterator = this.iterator();
        while(iterator.hasNext()) {
            result = func(result, iterator.next());
        }

        return Option.fromValue(result);
    }

    inline public function foldRight<T>(value : T, func : T -> T -> T) : Option<T> {
        var result = value;

        var iterator = this.iterator();
        while(iterator.hasNext()) {
            result = func(result, iterator.next());
        }

        return Option.fromValue(result);
    }

    @:from
    inline public static function fromCollection<T>(collection : Collection<T>) : CollectionFoldable<T> {
        return new CollectionFoldable(collection);
    }

    @:to
    inline public static function toString<T>(collection : Collections<T>) : String {
        return 'CollectionFoldable($collection)';
    }
}
