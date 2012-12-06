package funk.reactive.behaviours;

import funk.reactive.Behaviour;
import funk.reactive.streams.StreamBool;

using funk.reactive.streams.StreamBool;

class BehaviourBool {

	public static function not(behaviour : Behaviour<Bool>) : Behaviour<Bool> {
		return StreamBool.not(behaviour.stream()).startsWith(!behaviour.value());
	}

	public static function ifThen<T>(	condition : Behaviour<Bool>,
										thenBlock : Behaviour<T>) : Behaviour<T> {
		return StreamBool.ifThen(condition.stream(), thenBlock.stream()).startsWith(
			if(condition.value()) {
				thenBlock.value();
			});
	}

	public static function ifThenElse<T>(	condition : Behaviour<Bool>,
											thenBlock : Behaviour<T>,
											elseBlock : Behaviour<T>) : Behaviour<T> {
		return StreamBool.ifThenElse(condition.stream(), thenBlock.stream(), elseBlock.stream()).startsWith(
			if(condition.value()) {
				thenBlock.value();
			} else {
				elseBlock.value();
			});
	}
}