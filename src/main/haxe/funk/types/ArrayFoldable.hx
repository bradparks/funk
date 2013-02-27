package funk.types;

using funk.extensions.Collection;
using funk.extensions.Foldable;

abstract ArrayFoldable<T>(Foldable<T>) from Foldable<T> to Foldable<T> {

    public function new(array : Foldable<T>) {
        this = array;
    }
}
