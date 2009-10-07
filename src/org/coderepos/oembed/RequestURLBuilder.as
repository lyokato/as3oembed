package org.coderepos.oembed
{
    import com.adobe.net.URI;

    public class RequestURLBuilder
    {
        public static function build(endpoint:URI, itemURI:URI, option:OEmbedRequestOption):String
        {
            var params:Object = new Object();
            params.url = itemURI.toString();

            if (option.maxwidth)
                params.maxwidth = option.maxwidth;
            if (option.maxheight)
                params.maxheight = option.maxheight;

            var path:String = endpoint.path;
            if (path.match(/%7Bformat%7D/)) {
                endpoint.path = path.replace(/%7Bformat%7D/, option.format);
            } else {
                params.format = option.format;
            }
            endpoint.setQueryByMap(params);
            return endpoint.toString();
        }
    }
}
