package ;

using funk.extensions.Collection;
using funk.extensions.Foldable;
using funk.types.CollectionAccess;
using funk.types.CollectionFoldable;

class Tmp {

    public static function main() {
        var collection : Collection<Int> = [1, 2, 3];
        var access : CollectionAccess<Int> = collection;
        var foldable0 : CollectionFoldable<Int> = collection;

        trace(foldable0.foldLeft(1, function(a, b) return a + b));

        var foldable1 : Foldable<Int> = collection;

        trace(foldable1);
        trace(foldable1.foldLeft(100, function(a, b) return a + b));
    }
}
