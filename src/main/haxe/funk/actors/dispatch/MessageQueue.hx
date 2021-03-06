package funk.actors.dispatch;

import funk.actors.ActorRef;
import funk.actors.dispatch.EnvelopeMessage;
import funk.actors.dispatch.SystemMessage;

using funk.types.Option;
using funk.collections.immutable.List;

interface MessageQueue {

  function enqueue(receiver : ActorRef, handle : EnvelopeMessage) : Void;

  function dequeue() : Option<EnvelopeMessage>;

  function numberOfMessages() : Int;

  function hasMessages() : Bool;
}

interface SystemMessageQueue {

    function systemEnqueue(receiver : ActorRef, handle : SystemMessage) : Void;

    function systemDequeue() : Option<SystemMessage>;

    function numberOfSystemMessages() : Int;

    function hasSystemMessages() : Bool;
}

class MailboxMessageQueue {

    public static function create(actor : Option<ActorCell>) : MessageQueue {
        return switch(actor) {
            case Some(_): new UnboundedMessageQueue();
            case _: Funk.error(ActorError("Expected ActorCell but received none"));
        }
    }
}

private class UnboundedMessageQueue implements MessageQueue {

    private var _list : List<EnvelopeMessage>;

    public function new() {
        _list = Nil;
    }

    public function enqueue(receiver : ActorRef, handle : EnvelopeMessage) : Void _list = _list.append(handle);

    public function dequeue() : Option<EnvelopeMessage> {
        var head = _list.headOption();
        _list = ListTypes.tail(_list);
        return head;
    }

    public function numberOfMessages() : Int return _list.size();

    public function hasMessages() : Bool return _list.nonEmpty();
}
