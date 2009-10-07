package org.coderepos.oembed
{
    import flash.events.*;

    public class OEmbedEvent extends Event
    {
        public static const PROVIDER_NOT_FOUND:String = "providerNotFound";
        public static const COMPLETE:String = "complete";
        public static const ERROR:String = "error";

        private var _result:OEmbedEventResult;

        public function OEmbedEvent(type:String, result:OEmbedEventResult, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            _result = result;
        }

        public function get result():OEmbedEventResult
        {
            return _result;
        }
    }
}
