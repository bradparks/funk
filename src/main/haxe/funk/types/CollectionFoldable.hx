package funk.types;

using funk.extensions.Collection;
using funk.extensions.Foldable;

abstract CollectionFoldable<T>(Foldable<T>) from Foldable<T> to Foldable<T> {

    public function new(collection : Foldable<T>) {
        this = collection;
    }
}
