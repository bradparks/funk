package funk.signal;

import funk.Funk;
import funk.errors.RangeError;
import funk.signal.Slot;
import funk.signal.Signal2;

interface ISlot2<T1, T2> implements ISlot {

	var listener(default, default) : Function2<T1, T2, Void>;

	function execute(value0 : T1, value1 : T2) : Void;
}

class Slot2<T1, T2> extends Slot, implements ISlot2<T1, T2> {

	public var listener(default, default) : Function2<T1, T2, Void>;

	private var _signal : ISignal2<T1, T2>;

	public function new(	signal : ISignal2<T1, T2>,
							listener : Function2<T1, T2, Void>,
							once : Bool) {
		super();

		_signal = signal;

		this.listener = listener;
		this.once = once;
	}

	public function execute(value0 : T1, value1 : T2) : Void {
		if(!enabled) {
			return;
		}
		if(once) {
			remove();
		}

		listener(value0, value1);
	}

	override public function remove() : Void {
		_signal.remove(listener);
	}

	override public function productElement(index : Int) : Dynamic {
		return switch(index){
			case 0: listener;
			default:
				throw new RangeError();
		}
	}

	override private function get_productArity() : Int {
		return 1;
	}
}
