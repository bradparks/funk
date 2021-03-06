package funk.collections.immutable;

import funk.collections.CollectionTestBase;
import funk.collections.extensions.FoldableTestBase;

using funk.collections.Collection;
using funk.collections.CollectionUtil;
using massive.munit.Assert;

class ListFoldableTest extends FoldableTestBase {

    @Before
    public function setup() : Void {
        var list : List<Int> = [1, 2, 3];
        foldable = list;
    }
}
