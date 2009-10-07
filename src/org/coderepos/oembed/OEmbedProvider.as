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

