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

    public class OEmbedProviders
    {
        public static const YOUTUBE:OEmbedProvider =
            new OEmbedProvider(
                new URI("http://www.youtube.com/oembed"),
                Vector.<URI>([new URI("http://www.youtube.com/watch")])
            );

        public static const FLICKR:OEmbedProvider =
            new OEmbedProvider(
                new URI("http://www.flickr.com/services/oembed/"),
                Vector.<URI>([new URI("http://*.flickr.com/*")])
            );

        public static const HULU:OEmbedProvider =
            new OEmbedProvider(
                new URI("http://www.hulu.com/api/oembed.{format}"),
                Vector.<URI>([new URI("http://www.hulu.com/watch/*")])
            );

        public static const OOHEMBED:OEmbedProvider =
            new OEmbedProvider(
                new URI("http://www.oohembed.com/oohembed/"),
                Vector.<URI>([
                    new URI("http://video.google.com/videoplay?*"),
                    new URI("http://*.twitpic.com/*"),
                    new URI("http://*.slideshare.net/*"),
                    new URI("http://*.amazon.(com|co.uk|de|ca|jp)/*/(gp/product|o/ASIN|obidos/ASIN|dp)/*")])
                );
    }
}

