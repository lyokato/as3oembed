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
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import com.adobe.net.URI;

    /**
    * oEmbed consumer agent class
    *
    * @example
    * <listing version="3.0">
    *
    * import org.coderepos.oembed.OEmbedClient;
    * import org.coderepos.oembed.OEmbedEvent;
    * import org.coderepos.oembed.OEmbedProviders;
    * import org.coderepos.oembed.OEmbedProvider;
    * import org.coderepos.oembed.OEmbedResponse;
    * import flash.events.SecurityErrorEvent;
    * import flash.events.IOErrorEvent;
    * import com.adobe.net.URI;
    *
    * var client:OEmbedClient = new OEmbedClient();
    * // setup
    * client.registerProvider( OEmbedProviders.YOUTUBE );
    * client.registerProvider( OEmbedProviders.FLICKR );
    * // or build provider by yourself
    * client.registerProvider( new OEmbedProvider(...) );
    *
    * // setup listeners
    * client.addEventListener( OEmbedEvent.COMPLETE, completeHandler );
    * client.addEventListener( OEmbedEvent.ERROR, errorHandler );
    * client.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
    * client.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
    *
    * var itemURI:URI = new URI("http://www.youtube.com/watch?v=FOOBAR");
    * if (client.matchURI(itemURI))
    *   client.get(itemURI);
    *
    *  // or you can set option
    *  // var option:OEmbedRequestOption = new OEmbedRequestOption();
    *  // option.format = OEmbedFormat.XML; or you can set OEmbedFormat.JSON
    *  // option.maxheight = 300;
    *  // option.maxwidth  = 100;
    *  // client.get(itemURI, option);
    *
    * private function completeHandler(e:OEmbedEvent):void {
    *   var res:OEmbedResponse = e.result.data as OEmbedResponse;
    *   res.version;
    *   res.type;
    *   res.width;
    *   // ... see OEmbedResponse document for more detail
    * }
    * </listing>
    */

    public class OEmbedClient extends EventDispatcher
    {

        private var _defaultFormat:String;
        private var _lastRequestFormat:String;
        private var _providerManager:OEmbedProviderManager;
        private var _loader:URLLoader;
        private var _isFetching:Boolean;

        public function OEmbedClient(format:String=OEmbedFormat.JSON)
        {
            _defaultFormat = format;
            _providerManager = new OEmbedProviderManager();
            _isFetching = false;
        }

        public function registerProvider(provider:OEmbedProvider):void
        {
            _providerManager.registerProvider(provider);
        }

        public function matchURI(itemURI:URI):Boolean
        {
            var provider:OEmbedProvider = _providerManager.findProviderByURI(itemURI);
            return (provider != null);
        }

        public function get(itemURI:URI, option:OEmbedRequestOption=null):void
        {
            if (_isFetching)
                throw new Error("OEmbedClient is already fetching");
            clear();
            var provider:OEmbedProvider = _providerManager.findProviderByURI(itemURI);
            if (provider == null) {
                var result:OEmbedEventResult = new OEmbedEventResult();
                result.message = "Provider not found";
                dispatchEvent(new OEmbedEvent(OEmbedEvent.PROVIDER_NOT_FOUND, result));
                return;
            }
            var r:URLRequest = buildRequest(provider, itemURI, option);
            _loader = new URLLoader();
            _loader.addEventListener(Event.COMPLETE, completeHandler);
            _loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            // events for progress, open, httpstatus are also needed?

            var format:String = (option != null && option.format !=null)
                ? option.format : _defaultFormat;
            _isFetching = true;
            _lastRequestFormat = format;
            _loader.load(r);
        }

        public function get isFetching():Boolean
        {
            return _isFetching;
        }

        public function clear():void
        {
            _lastRequestFormat = null;
            _loader = null;
        }

        private function completeHandler(e:Event):void
        {
            _isFetching = false;
            var parser:IOEmbedResponseParser = OEmbedFormat.getResponseParserForFormat(_lastRequestFormat);
            var result:OEmbedEventResult = new OEmbedEventResult();
            try {
                result.data = parser.parse(e.target.data as String);
                dispatchEvent(new OEmbedEvent(OEmbedEvent.COMPLETE, result));
            } catch (e:Error) {
                result.message = e.toString();
                dispatchEvent(new OEmbedEvent(OEmbedEvent.ERROR, result));
                return;
            }
        }

        private function securityErrorHandler(e:SecurityErrorEvent):void {
            _isFetching = false;
            dispatchEvent(e.clone());
        }

        private function ioErrorHandler(e:IOErrorEvent):void
        {
            _isFetching = false;
            dispatchEvent(e.clone());
        }

        private function buildRequest(provider:OEmbedProvider, itemURI:URI,
            option:OEmbedRequestOption=null):URLRequest
        {

            option ||= new OEmbedRequestOption();
            option.format ||= _defaultFormat;

            var url:String = RequestURLBuilder.build(provider.apiEndpoint, itemURI, option);
            var req:URLRequest = new URLRequest(url);
            req.manageCookies = false;
            var contentType:String = OEmbedFormat.getContentTypeForFormat(option.format);
            req.requestHeaders.push(new URLRequestHeader("Accept", contentType));
            return req;
        }

    }
}

