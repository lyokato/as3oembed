package org.coderepos.oembed
{
    import flash.events.Event;

    public class OEmbedEvent extends Event
    {
        public static const PROVIDER_NOT_FOUND:String = "provider_not_found";
        public static const COMPLETE:String = "complete";
        public static const RESPONSE_PARSE_ERROR:String = "response_parse_error";
    }
}
