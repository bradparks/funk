package funk.extensions;

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
    inline public static function toString<T>(collection : Collections<T>) : String {
        return 'Collection($collection)';
    }
}
