package funk.reactives;

import funk.reactives.Behaviour;
import massive.munit.util.Timer;

using funk.types.Option;
using funk.collections.Collection;
using funk.collections.CollectionUtil;
using funk.reactives.Stream;
using massive.munit.Assert;
using unit.Asserts;

class CollectionTest extends ProcessAsyncBase {

    @Test
    public function when_creating_an_empty_stream__should_size_be_zero() : Void {
        var stream = CollectionUtil.toStream([].toCollection(), BehaviourTypes.constant(1));
        var values = stream.values();

        advanceProcessBy(1, false);

        values.size().areEqual(0);
    }

    @Test
    public function when_creating_an_empty_stream__should_calling_emitWithDelay_throw_error() : Void {
        var stream = CollectionUtil.toStream([].toCollection(), BehaviourTypes.constant(1));
        var values = stream.values();

        var called = try {

            stream.dispatchWithDelay(3, 1);

            advanceProcessBy(1);

            false;
        } catch(error : Dynamic) {
            true;
        }

        called.isTrue();
    }

    @Test
    public function when_creating_a_stream__should_calling_emitWithDelay() : Void {
        var stream = CollectionUtil.toStream([1, 2].toCollection(), BehaviourTypes.constant(1));
        var values = stream.values();

        stream.dispatchWithDelay(3, 1);

        advanceProcessBy(1);

        values.last().areEqual(Some(3));
    }

    @Test
    public function when_creating_a_stream_from_a_collection__should_calling_first_value_be_1() : Void {
        var stream = CollectionUtil.toStream([1, 2].toCollection(), BehaviourTypes.constant(1));
        var values = stream.values();

        advanceProcessBy(1);

        values.get(0).areEqual(Some(1));
    }

    @Test
    public function when_creating_a_stream_from_a_collection__should_calling_second_value_be_2() : Void {
        var stream = CollectionUtil.toStream([1, 2].toCollection(), BehaviourTypes.constant(1));
        var values = stream.values();

        advanceProcessByWithIncrements(1, 2);

        values.get(1).areEqual(Some(2));
    }

    @Test
    public function when_creating_a_stream_from_a_collection__should_stream_length_be_1_after_first_iteration() : Void {
        var stream = CollectionUtil.toStream([1, 2].toCollection(), BehaviourTypes.constant(1));
        var values = stream.values();

        advanceProcessBy(1);

        values.size().areEqual(1);
    }

    @Test
    public function when_creating_a_stream_from_a_collection__should_stream_length_be_2_after_second_iteration() : Void {
        var stream = CollectionUtil.toStream([1, 2].toCollection(), BehaviourTypes.constant(1));
        var values = stream.values();

        advanceProcessByWithIncrements(1, 2);

        values.size().areEqual(2);
    }

    @Test
    public function when_creating_a_stream_from_a_collection__should_stream_length_be_10_after_tenth_iteration() : Void {
        var stream = CollectionUtil.toStream([0, 1, 2, 3, 4, 5, 6, 7, 8, 9].toCollection(), BehaviourTypes.constant(1));
        var values = stream.values();

        advanceProcessByWithIncrements(1, 10);

        values.size().areEqual(10);
    }

    @Test
    public function when_creating_a_stream_from_a_collection__should_merging_streams_equal_result() : Void {
        var stream = CollectionUtil.toStream([1, 2, 3, 4].toCollection(), BehaviourTypes.constant(1));
        var streams = [stream, stream.delay(BehaviourTypes.constant(5))].toCollection();
        var merged = StreamTypes.merge(streams).values();

        advanceProcessByWithIncrements(1, 4);
        advanceProcessBy(5);

        merged.areIterablesEqual([1, 2, 3, 4, 1, 2, 3, 4]);
    }

    @Test
    public function when_creating_a_stream_from_a_collection__should_calm_not_allow_events_through() : Void {
        var stream = CollectionUtil.toStream([1, 2, 3, 4].toCollection(), BehaviourTypes.constant(1));
        var calmed = stream.calm(BehaviourTypes.constant(5)).values();

        advanceProcessByWithIncrements(1, 4);

        calmed.areIterablesEqual([]);
    }
}
