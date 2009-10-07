package org.coderepos.oembed
{
    import com.adobe.net.URI;

    public class OEmbedProviders
    {
        public static const YOUTUBE:OEmbedProvider =
            new OEmbedProvider(new URI("http://www.youtube.com/oembed"), new URI("http://www.youtube.com/watch"));
        public static const FLICKR:OEmbedProvider =
            new OEmbedProvider(new URI("http://www.flickr.com/services/oembed/"), new URI("http://*.flickr.com/*"));
    }
}

