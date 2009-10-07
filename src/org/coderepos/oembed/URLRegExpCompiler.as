package org.coderepos.oembed
{
    import com.adobe.net.URI;

    public class URLRegExpCompiler
    {
        public static function compile(url:URI):RegExp
        {
            return new RegExp(compileToString(url));
        }

        public static function compileToString(url:URI):String {
            var scheme:String = url.scheme;
            var authority:String = runRegExp(url.authority, "[0-9a-zA-Z-]+");
            var path:String = runRegExp(url.path, "[\\;\\/\\?\\:\\@\\&\\=\\+\\$\\,\\[\\]A-Za-z0-9\\-_\\.\\!\\~\\*\\'\\(\\)%]+");
            return scheme + "://" + authority + path;
        }

        public static function runRegExp(str:String, escaper:String):String {
            return str.replace(/(?:(\*)|([^\*]+))/g, function():String {
                if (arguments[1]) {
                    return escaper;
                } else {
                    return arguments[2].replace(/([^0-9a-zA-Z_])/g, "\\$1");
                }
            });
        }
    }
}

