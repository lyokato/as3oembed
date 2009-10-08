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
            var obj:Object = JSON.decode(String(data));
            if (obj == null)
                throw new Error("Invalid JSON format string");
            if (obj.type)
                res.type = obj.type;
            if (obj.version)
                res.version = obj.version;
            if (obj.title)
                res.title = obj.title;
            if (obj.author_name)
                res.authorName = obj.author_name;
            if (obj.author_url)
                res.authorURL = new URI(obj.author_url);
            if (obj.provider_name)
                res.providerName = obj.provider_name;
            if (obj.provider_url)
                res.providerURL = new URI(obj.provider_url);
            if (obj.cache_age)
                res.cacheAge = uint(obj.cache_age);
            if (obj.thumbnail_url)
                res.thumbnailURL = new URI(obj.thumbnail_url);
            if (obj.thumbnail_height)
                res.thumbnailHeight = uint(obj.thumbnail_height);
            if (obj.thumbnail_width)
                res.thumbnailWidth = uint(obj.thumbnail_width);
            if (obj.url)
                res.url = new URI(obj.url);
            if (obj.html)
                res.html = obj.html;
            if (obj.width)
                res.width = uint(obj.width);
            if (obj.height)
                res.height = uint(obj.height);
            return res;
        }
    }
}
