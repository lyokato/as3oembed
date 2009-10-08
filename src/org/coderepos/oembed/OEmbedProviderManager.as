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

    public class OEmbedProviderManager
    {
        private var _store:Vector.<OEmbedProvider>;

        public function OEmbedProviderManager()
        {
            _store = new Vector.<OEmbedProvider>();
        }

        public function registerProvider(provider:OEmbedProvider):void
        {
            _store.push(provider);
        }

        public function findProviderByURI(uri:URI):OEmbedProvider
        {
            for each(var provider:OEmbedProvider in _store) {
                if (provider.matchURI(uri))
                    return provider;
            }
            return null;
        }

    }
}
