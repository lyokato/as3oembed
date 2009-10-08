/*
Copyright (c) Lyo Kato (lyo.kato _at_ gmail.com)

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION 
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
*/

package org.coderepos.oembed
{
    import com.adobe.utils.StringUtil;

    /**
    * This library allows you to extract URI from text easily.
    *
    * @example
    * <listing version="3.0">
    * var str:String = "This site is cool, http://example.com/page1."
    *  + "And See also http://example.com/page2";
    * var urls:Array = URIFinder.find(str);
    * trace(urls[0]); // http://example.com/page1
    * trace(urls[1]); // http://example.com/page2
    *
    * var results:Array = URIFinder.split(str);
    * var elem1:URIFinderElem = results[0];
    * // elem1.type == URIFinder.TEXT
    * // elem1.data == "This site is cool,"
    * var elem2:URIFinderElem = results[1];
    * // elem2.type == URIFinder.URI
    * // elem2.data == "http://example.com/page1"
    * var elem3:URIFinderElem = results[2];
    * // elem3.type == URIFinder.TEXT
    * // elem3.data == ".And See also"
    * var elem4:URIFinderElem = results[3];
    * // elem4.type == URIFinder.URI
    * // elem4.data == "http://example.com/page2"
    *
    * </listing>
    */

    public class URIFinder
    {

        public static const URI:uint = 0;
        public static const TEXT:uint = 1;

        private static const URLRESTRING:String = "\\b(?:https?|shttp)://(?:(?:[-_.!~*'()a-zA-Z0-9;:&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*@)?(?:(?:[a-zA-Z0-9](?:[-a-zA-Z0-9]*[a-zA-Z0-9])?\\.)*[a-zA-Z](?:[-a-zA-Z0-9]*[a-zA-Z0-9])?\\.?|[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)(?::[0-9]*)?(?:/(?:[-_.!~*'()a-zA-Z0-9:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*(?:;(?:[-_.!~*'()a-zA-Z0-9:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*)*(?:/(?:[-_.!~*'()a-zA-Z0-9:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*(?:;(?:[-_.!~*'()a-zA-Z0-9:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*)*)*)?(?:\\?(?:[-_.!~*'()a-zA-Z0-9;/?:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*)?(?:#(?:[-_.!~*'()a-zA-Z0-9;/?:@&=+$,]|%[0-9A-Fa-f][0-9A-Fa-f])*)?";

        private static const URLRE:RegExp = new RegExp(URLRESTRING, "gi");


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
            var filtered:String = "";
            for each(var url:String in urls) {
                i = str.indexOf(url);
                if (i > 0) {
                    filtered = filter(str.substring(0, i));
                    if (filtered.length > 0)
                        callback(new URIFinderElem(filtered, TEXT));
                }
                callback(new URIFinderElem(filter(url), URI));
                str = str.substring(i + url.length);
            }
            if (str.length > 0) {
                filtered = filter(str);
                if (filtered.length > 0)
                    callback(new URIFinderElem(filtered, TEXT));
            }
        }

        public static function split(str:String, trim:Boolean=true):Array
        {
            var i:uint;
            var urls:Array = find(str);
            var results:Array = new Array();
            var filter:Function = function(s:String):String {
                    return (trim) ? StringUtil.trim(s) : s;
                };
            var filtered:String = "";
            for each(var url:String in urls) {
                i = str.indexOf(url);
                if (i > 0) {
                    filtered = filter(str.substring(0, i));
                    if (filtered.length > 0)
                        results.push(new URIFinderElem(filtered, TEXT));
                }
                results.push(new URIFinderElem(filter(url), URI));
                str = str.substring(i + url.length);
            }
            if (str.length > 0) {
                filtered = filter(str);
                if (filtered.length > 0)
                    results.push(new URIFinderElem(filtered, TEXT));
            }
            return results;
        }

    }
}
