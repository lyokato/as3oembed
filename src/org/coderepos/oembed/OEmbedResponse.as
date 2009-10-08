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

    public class OEmbedResponse
    {

        // common properties
        public var type:String;
        public var version:String;
        public var title:String;
        public var authorName:String;
        public var authorURL:URI;
        public var providerName:String;
        public var providerURL:URI;
        public var cacheAge:uint;
        public var thumbnailURL:URI;
        public var thumbnailHeight:uint;
        public var thumbnailWidth:uint;

        // for photo
        public var url:URI;
        // for video
        public var html:String;

        // for photo and video
        public var width:uint;
        public var height:uint;

        public function OEmbedResponse()
        {

        }
    }
}

