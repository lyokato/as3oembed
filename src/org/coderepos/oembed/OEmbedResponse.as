package org.coderepos.oembed
{
    import com.adobe.net.URI;

    public class OEmbedResponse
    {

        // common properties
        public var type:String;
        public var version:String;
        public var title:String;
        public var authorName:String;
        public var authorURL:URI;
        public var providerName:String;
        public var providerURL:URI;
        public var cacheAge:uint;
        public var thumbnailURL:URI;
        public var thumbnailHeight:uint;
        public var thumbnailWidth:uint;

        // for photo
        public var url:URI;
        // for video
        public var html:String;

        // for photo and video
        public var width:uint;
        public var height:uint;

        public function OEmbedResponse()
        {

        }
    }
}

