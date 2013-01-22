package ;

import funk.collections.immutable.List;
import funk.collections.immutable.extensions.ListsUtil;
import funk.types.Function1;
import funk.types.Pass;
import funk.types.Wildcard;
import funk.reactive.events.Events;
import support.HtmlDivElement;
import CommonJS;
import UserAgentContext;

using funk.collections.immutable.extensions.Lists;
using funk.reactive.events.MouseEvents;
using funk.reactive.extensions.Streams;
using funk.types.extensions.Tuples2;
using support.HtmlWildcards;

class Example03 {

    public function new() {
        // Create a list of 6 elements instances.
        var elements = ListsUtil.fill(6)(Pass.instanceOf(HtmlDivElement));

        // Map the elements to their styles object and apply a
        // function on each of them.
        elements.map(_.styles()).foreach(function(s) {
            s.backgroundColor = "red";
            s.position = "absolute";
            s.width = "20px";
            s.height = "20px";
        });

        // Combine the Elements objects with their index, resulting
        // in a List.&lt;Tuple2.&lt;Element, Int&gt;&gt;
        //
        // Apply a function on each tuple in order to position the
        // sprite based on its index in the list.
        elements.zipWithIndex().foreach(function(tuple) {
            var element : HtmlDivElement = tuple._1();
            var index : Int = tuple._2();

            var pos = index * 21;

            element.style().left = pos + "px";
            element.style().top = pos + "px";

        });

        // Add all elements to the dom
        elements.foreach(_.addElement(getBody()));

        // Attach a mouse down event to all the sprites.
        elements.foreach(_.mouseDown(function (event) {
            var left = Std.parseInt(event.target.style.left);
            event.target.style.left = left + 10 + "px";
        }));
    }

    public function getBody() : HTMLElement {
        return CommonJS.getHtmlDocument().body;
    }

    public static function main() {
        new Example03();
    }
}