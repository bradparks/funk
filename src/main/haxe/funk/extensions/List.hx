package funk.extensions;

enum Lists<T> {
    Cons(head : T, tail : Lists<T>);
    Nil;
}

abstract List<T>(Lists<T>) from Lists<T> to Lists<T> {

    inline function new(list : Lists<T>) {
        this = list;
    }

    inline public function head() : T {
        return switch(this) {
            case Cons(value, _): value;
            case Nil: null;
        }
    }

    inline public function tail() : T {
        return switch(this) {
            case Cons(_, value): value;
            case Nil: null;
        }
    }

    inline public function isNonEmpty() : Bool {
        return switch(this) {
            case Cons(_, _): true;
            case Nil: false;
        }
    }

    inline public function isEmpty() : Bool {
        return switch (this) {
            case Cons(_, _): false;
            case Nil: true;
        }
    }

    @:from
    inline public static function fromArray<T>(array : Array<T>) : List<T> {
        var p = Nil;
        for(i in 0...array.length) {
            p = Cons(array[i], p);
        }
        return new List(p);
    }

    @:to
    inline public static function toString<T>(list : Lists<T>) : String {
        return 'List($list)';
    }
}
