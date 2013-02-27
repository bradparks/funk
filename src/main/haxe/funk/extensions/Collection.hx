package funk.extensions;

typedef Collections<T> = {> Iterable<T>,
    function size() : Int;
};

abstract Collection<T>(Collections<T>) from Collections<T> to Collections<T> {

    public function new(option : Collections<T>) {
        this = option;
    }

    @:to
    inline public static function toString<T>(collection : Collections<T>) : String {
        return 'Collection($collection)';
    }
}
