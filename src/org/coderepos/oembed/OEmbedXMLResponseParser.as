package org.coderepos.oembed
{
    import com.adobe.net.URI;

    public class OEmbedXMLResponseParser implements IOEmbedResponseParser
    {
        public function OEmbedXMLResponseParser()
        {

        }

        public function parse(data:String):OEmbedResponse
        {
            var res:OEmbedResponse = new OEmbedResponse();
            var resXML:XML = new XML(data);
            if (resXML.type.length() > 0)
                res.type = resXML.type.toString();
            if (resXML.version.length() > 0)
                res.version = resXML.version[0].toString();
            if (resXML.title.length() > 0)
                res.title = resXML.title[0].toString();
            if (resXML.author_name.length() > 0)
                res.authorName = resXML.author_name[0].toString();
            if (resXML.author_url.length() > 0)
                res.authorURL = new URI(resXML.author_url[0].toString());
            if (resXML.provider_name.length() > 0)
                res.providerName = resXML.provider_name[0].toString();
            if (resXML.provider_url.length() > 0)
                res.providerURL = new URI(resXML.provider_url[0].toString());
            if (resXML.cache_age.length() > 0)
                res.cacheAge = uint(resXML.cache_age[0].toString());
            if (resXML.thumbnail_url.length() > 0)
                res.thumbnailURL = new URI(resXML.thumbnail_url[0].toString());
            if (resXML.thumbnail_height.length() > 0)
                res.thumbnailHeight = uint(resXML.thumbnail_height[0].toString());
            if (resXML.thumbnail_width.length() > 0)
                res.thumbnailWidth = uint(resXML.thumbnail_width[0].toString());
            if (resXML.url.length() > 0)
                res.url = new URI(resXML.url[0].toString());
            if (resXML.html.length() > 0)
                res.html = resXML.html[0].toString();
            if (resXML.width.length() > 0)
                res.width = uint(resXML.width[0].toString());
            if (resXML.height.length() > 0)
                res.height = uint(resXML.height[0].toString());
            return res;
        }
    }
}
