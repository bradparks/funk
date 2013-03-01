package funk.extensions;

abstract Iterators<T>(Iterator<T>) from Iterator<T> to Iterator<T> {

    inline function new(iterator : Iterator<T>) {
        this = iterator;
    }

    inline public function reverse() : Iterator<T> {
        var p = this;
        var stack = toArray(p);
        stack.reverse();
        return stack.iterator();
    }

    @:to
    inline public static function toArray<T>(iterator : Iterator<T>) : Array<T> {
        var stack = [];
        for(i in iterator) {
            stack.push(i);
        }
        return stack;
    }
}
