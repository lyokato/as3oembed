package org.coderepos.oembed
{
    public class OEmbedFormat {

        public static const JSON:String = "json";
        public static const XML:String = "xml";

        public static function getContentTypeForFormat(format:String):String
        {
            var format:String = "*/*";
            switch(format) {
                case JSON:
                    format = "application/json";
                    break;
                case XML:
                    format = "text/xml";
                    break;
            }
            /* XXX: for default, throw UnknownFormatException? */
            return format;
        }

        public static function getResponseParserForFormat(format:String):IOEmbedResponseParser {
            var parser:IOEmbedResponseParser;
            switch(format) {
                case JSON:
                    parser = new OEmbedJSONResponseParser();
                    break;
                case XML:
                    parser = new OEmbedXMLResponseParser();
                    break;
            }
            return parser;
        }
    }
}
