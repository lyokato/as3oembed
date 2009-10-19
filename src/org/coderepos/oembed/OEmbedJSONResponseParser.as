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
    import com.adobe.serialization.json.JSON;
    import com.adobe.net.URI;

    public class OEmbedJSONResponseParser implements IOEmbedResponseParser
    {
        public function OEmbedJSONResponseParser()
        {

        }

        public function parse(data:String):OEmbedResponse
        {
            var res:OEmbedResponse = new OEmbedResponse();
            res.src = data;
            var obj:Object = JSON.decode(data);
            if (obj == null)
                throw new Error("Invalid JSON format string");
            if ("type" in obj)
                res.type = obj.type;
            if ("version" in obj)
                res.version = obj.version;
            if ("title" in obj)
                res.title = obj.title;
            if ("author_name" in obj)
                res.authorName = obj.author_name;
            if ("author_url" in obj)
                res.authorURL = new URI(obj.author_url);
            if ("provider_name" in obj)
                res.providerName = obj.provider_name;
            if ("provider_url" in obj)
                res.providerURL = new URI(obj.provider_url);
            if ("cache_age" in obj)
                res.cacheAge = uint(obj.cache_age);
            if ("thumbnail_url" in obj)
                res.thumbnailURL = new URI(obj.thumbnail_url);
            if ("thumbnail_height" in obj)
                res.thumbnailHeight = uint(obj.thumbnail_height);
            if ("thumbnail_width" in obj)
                res.thumbnailWidth = uint(obj.thumbnail_width);
            if ("url" in obj)
                res.url = new URI(obj.url);
            if ("html" in obj)
                res.html = obj.html;
            if ("width" in obj)
                res.width = uint(obj.width);
            if ("height" in obj)
                res.height = uint(obj.height);
            return res;
        }
    }
}
