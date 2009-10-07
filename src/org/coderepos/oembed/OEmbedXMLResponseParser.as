package org.coderepos.oembed
{
    public class OEmbedXMLResponseParser implements IOEmbedResponseParser
    {
        public function OEmbedXMLResponseParser()
        {

        }

        public function parse(data:*):OEmbedResponse
        {
            if (!(data is XML))
                throw new Error("for XML Parser, response data should be XML format");
            var res:OEmbedResponse = new OEmbedResponse();
            var resXML:XML = data as XML;
            var root:XML = resXML.oembed;
            return res;
        }
    }
}
