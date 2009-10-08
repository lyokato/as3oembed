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
    import com.adobe.net.URI;

    public class RequestURLBuilder
    {
        public static function build(endpoint:URI, itemURI:URI, option:OEmbedRequestOption):String
        {
            var params:Object = new Object();
            params.url = itemURI.toString();

            if (option.maxwidth)
                params.maxwidth = option.maxwidth;
            if (option.maxheight)
                params.maxheight = option.maxheight;

            var path:String = endpoint.path;
            if (path.match(/%7Bformat%7D/)) {
                endpoint.path = path.replace(/%7Bformat%7D/, option.format);
            } else {
                params.format = option.format;
            }
            endpoint.setQueryByMap(params);
            return endpoint.toString();
        }
    }
}
