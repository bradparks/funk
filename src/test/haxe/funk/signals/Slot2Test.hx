package funk.signals;

import funk.signals.Signal2;

using funk.types.Option;
using massive.munit.Assert;
using unit.Asserts;

class Slot2Test {

    public var signal : Signal2<Int, Int>;

    @Before
    public function setup() {
        signal = new Signal2<Int, Int>();
    }

    @After
    public function tearDown() {
        signal = null;
    }

    @Test
    public function when_calling_execute__should_call_listener() : Void {
        var called = false;
        var listener = function(value0, value1) {
            called = true;
        };
        var slot = new Slot2<Int, Int>(signal, listener, false);
        slot.execute(1, 2);
        called.isTrue();
    }

    @Test
    public function when_calling_execute__should_leave_signal_with_one() : Void {
        var listener = function(value0, value1) {};
        var slot = signal.add(listener).get();
        slot.execute(1, 2);
        signal.size().areEqual(1);
    }

    @Test
    public function when_calling_execute_with_once__should_leave_signal_with_zero() : Void {
        var listener = function(value0, value1) {};
        var slot = signal.addOnce(listener).get();
        slot.execute(1, 2);
        signal.size().areEqual(0);
    }

    @Test
    public function when_calling_remove_twice__should_signal_with_zero_listeners() : Void {
        var listener = function(value0, value1) {};
        var slot = signal.add(listener).get();
        slot.remove();
        slot.remove();
        signal.size().areEqual(0);
    }

    @Test
    public function when_calling_listener__should_return_same_listener() : Void {
        var listener = function(value0, value1) {};
        var slot = new Slot2<Int, Int>(signal, listener, false);
        slot.getListener().areEqual(listener);
    }
}
