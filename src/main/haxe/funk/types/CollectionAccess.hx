package funk.types;

using funk.extensions.Collection;
using funk.extensions.Option;

abstract CollectionAccess<T>(Collection<T>) from Collection<T> {

    inline function new(collection : Collection<T>) {
        this = collection;
    }

    @:arrayAccess
    inline public function get(index : Int) : Option<T> {
        var result = null;
        var iterator = this.iterator();
        while(--index >= -1) {
            if(iterator.hasNext()) {
                var value = iterator.next();
                if (index == -1) {
                    result = value;
                }
            }
        }

        return Option.fromValue(result);
    }
}
