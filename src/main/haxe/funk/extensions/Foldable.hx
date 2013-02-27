package funk.extensions;

typedef Foldables<T> = {
    function fold(value : T, func : T -> T -> T) : T;
    function foldLeft(value : T, func : T -> T -> T) : T;
};

abstract Foldable<T>(Foldables<T>) from Foldables<T> to Foldables<T> {

    public function new(foldable : Foldables<T>) {
        this = foldable;
    }

    public function foldLeft(value : T, func : T -> T -> T) : T {

    }

    public function foldRight(value : T, func : T -> T -> T) : T {

    }

    @:to
    inline public static function toString<T>(foldable : Foldables<T>) : String {
        return 'Foldable($foldable)';
    }
}
