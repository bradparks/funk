package ;

using funk.extensions.Collection;
using funk.types.CollectionAccess;
using funk.types.CollectionFoldable;

class Tmp {

    public static function main() {
        var collection : Collection<Int> = [1, 2, 3];
        var access : CollectionAccess<Int> = collection;
        var foldable : CollectionFoldable<Int> = collection;

        trace(foldable.foldLeft(1, function(a, b) return a + b));


    }
}
