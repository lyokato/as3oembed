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
