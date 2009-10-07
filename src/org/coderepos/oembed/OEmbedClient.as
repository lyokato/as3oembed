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
            _providerManager.registerProvider(provider):
        }

        public function get(itemURI:URI, option:OEmbedRequestOption=null):void
        {
            if (_isFetching)
                throw new Error("OEmbedClient is already fetching");
            clear();
            var provider:OEmbedprovider = _providerManager.findProviderByURI(itemURI);
            if (provider == null) {
                dispatchEvent(new OEmbedEvent(OEmbedEvent.PROVIDER_NOT_FOUND));
                return;
            }
            var r:URLRequest = buildRequest(provider, uri, option);
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
        }

        private function completeHandler(e:Event):void
        {
            _isFetching = false;
            var parser:IOEmbedResponseParser = OEmbedFormat.getResponseParserForFormat(_lastRequestFormat);
            var response:OEmbedResponse;
            try {
                response = parser.parse(e.target.data);
                dispatchEvent(new OEmbedEvent(OEmbedEvent.COMPLETE, response));
            } catch (e:Error) {
                dispatchEvent(new OEmbedEvent(OEmebedEvent.RESPONSE_PARSE_ERROR));
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

