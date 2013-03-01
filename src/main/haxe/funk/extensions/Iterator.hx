package funk.extensions;

private typedef StdIterator<T> = StdTypes.Iterator<T>;

abstract Iterator<T>(StdIterator<T>) {

    inline function new(iterator : StdIterator<T>) {
        this = iterator;
    }

    inline public function reverse() : StdIterator<T> {
        var p = iterator;
        var stack = toArray(p);
        stack.reverse();
        return stack.iterator();
    }

    @:to
    inline public static function toArray(iterator : StdIterator<T>) : Array<T> {
        var stack = [];
        for(i in iterator) {
            stack.push(i);
        }
        return stack;
    }
}
