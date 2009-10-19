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

    public class OEmbedProvider
    {
        private var _apiEndpoint:URI;
        private var _uriRegExpList:Vector.<RegExp>;

        public function OEmbedProvider(apiEndpoint:URI, schemeURIs:Vector.<URI>)
        {
            _apiEndpoint = apiEndpoint;
            _uriRegExpList = new Vector.<RegExp>();
            for each(var schemeURI:URI in schemeURIs) {
               _uriRegExpList.push(URLRegExpCompiler.compile(schemeURI));
            }
        }


        public function get apiEndpoint():URI
        {
            return _apiEndpoint;
        }

        public function matchURI(uri:URI):Boolean
        {
            var urlString:String = uri.toString();
            for each(var regExp:RegExp in _uriRegExpList) {
                if (regExp.test(urlString))
                    return true;
            }
            return false;
        }
    }
}

