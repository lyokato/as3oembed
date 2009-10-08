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
