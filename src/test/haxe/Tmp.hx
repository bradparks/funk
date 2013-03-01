package ;

using funk.extensions.Collection;
using funk.extensions.Foldable;
using funk.types.ArrayFoldable;
using funk.types.CollectionAccess;
using funk.types.CollectionFoldable;

class Tmp {

    public static function main() {

        // Collection

        var collection : Collection<Int> = [1, 2, 3];
        var access : CollectionAccess<Int> = collection;
        var foldable0 : CollectionFoldable<Int> = collection;

        trace(foldable0.foldLeft(1, function(a, b) return a + b));

        var foldable1 : Foldable<Int> = collection;

        trace(foldable1);
        trace(foldable1.foldLeft(100, function(a, b) return a + b));

        // Array

        var array : Array<Int> = [1, 2, 3];
        var foldable2 : ArrayFoldable<Int> = array;

        trace(foldable2.foldLeft(1, function(a, b) return a + b));

        var foldable3 : Foldable<Int> = array;

        trace(foldable3);
        trace(foldable3.foldLeft(100, function(a, b) return a + b));
    }
}
