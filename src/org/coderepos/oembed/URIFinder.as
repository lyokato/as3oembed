package org.coderepos.oembed
{
    import com.adobe.utils.StringUtil;

    public class URIFinder
    {

        public static const URI:uint = 0;
        public static const TEXT:uint = 1;

        private static const URLRESTRING:String = "\\b(?:https?|shttp)://(?:(?:[-_.!~*'()a-zA-Z0-9;:&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*@)?(?:(?:[a-zA-Z0-9](?:[-a-zA-Z0-9]*[a-zA-Z0-9])?\\.)*[a-zA-Z](?:[-a-zA-Z0-9]*[a-zA-Z0-9])?\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(?::[0-9]*)?(?:/(?:[-_.!~*'()a-zA-Z0-9:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*(?:;(?:[-_.!~*'()a-zA-Z0-9:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*)*(?:/(?:[-_.!~*'()a-zA-Z0-9:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*(?:;(?:[-_.!~*'()a-zA-Z0-9:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*)*)*)?(?:\\?(?:[-_.!~*'()a-zA-Z0-9;/?:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*)?(?:#(?:[-_.!~*'()a-zA-Z0-9;/?:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*)?";

        private static const URLRE:RegExp = new RegExp(URLRESTRING, "gi");


        public function URIFinder()
        {

        }

        public static function find(str:String):Array
        {
            return str.match(URLRE).map(decruft);
        }

        public static function decruft(str:String, i:int, array:Array):String
        {
            return str.replace(/[\\Q,\]\)\,\.\'\"\\E]+$/, "");
        }

        public static function process(str:String, callback:Function,
            trim:Boolean=true):void
        {
            if (callback==null)
                callback = function(s:String):void { };
            var i:uint;
            var urls:Array = find(str);
            var filter:Function = function(s:String):String {
                    return (trim) ? StringUtil.trim(s) : s;
                };
            for each(var url:String in urls) {
                i = str.indexOf(url);
                if (i > 0)
                    callback(new URIFinderElem(filter(str.substring(0, i)), TEXT));
                callback(new URIFinderElem(filter(url), URI));
                str = str.substring(i + url.length);
            }
            if (str.length > 0)
                callback(new URIFinderElem(filter(str), TEXT));
        }

        public static function split(str:String, trim:Boolean=true):Array
        {
            var i:uint;
            var urls:Array = find(str);
            var results:Array = new Array();
            var filter:Function = function(s:String):String {
                    return (trim) ? StringUtil.trim(s) : s;
                };
            for each(var url:String in urls) {
                i = str.indexOf(url);
                if (i > 0)
                    results.push(new URIFinderElem(filter(str.substring(0, i)), TEXT));
                results.push(new URIFinderElem(filter(url), URI));
                str = str.substring(i + url.length);
            }
            if (str.length > 0)
                results.push(new URIFinderElem(filter(str), TEXT));
            return results;
        }

    }
}
