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
        private var _uriRegExp:RegExp;
        private var _apiEndpoint:URI;
        private var _schemeURI:URI;

        public function OEmbedProvider(apiEndpoint:URI, schemeURI:URI)
        {
            _apiEndpoint = apiEndpoint;
            _schemeURI = schemeURI;
            _uriRegExp = URLRegExpCompiler.compile(schemeURI);
        }


        public function get apiEndpoint():URI
        {
            return _apiEndpoint;
        }

        public function matchURI(uri:URI):Boolean
        {
            return _uriRegExp.test(uri.toString());
        }

    }
}

