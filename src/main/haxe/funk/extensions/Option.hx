package funk.extensions;

enum Options<T> {
    Some(value : T);
    None;
}

abstract Option<T>(Options<T>) from Options<T> to Options<T> {

    public function new(option : Options<T>) {
        this = option;
    }

    inline public function get() : T {
        return toValue(this);
    }

    @:from
    inline public static function fromValue<T>(value : T) : Option<T> {
        return new Option(value == null ? None : Some(value));
    }

    @:to
    inline public static function toValue<T>(option : Options<T>) : T {
        return switch (option) {
            case Some(value): value;
            case None: throw "No Such Element";
        }
    }

    @:to
    inline public static function toString<T>(option : Options<T>) : String {
        return switch(option) {
            case Some(value): 'Some($value)';
            case None: 'None';
        }
    }
}
