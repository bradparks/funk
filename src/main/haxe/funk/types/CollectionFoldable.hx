package funk.types;

using funk.extensions.Collection;
using funk.extensions.Option;

abstract CollectionFoldable<T>(Collection<T>) from Collection<T> {

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
}
