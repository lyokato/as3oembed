package org.coderepos.oembed
{
    public interface IOEmbedResponseParser {
        function parse(data:*):OEmbedResponse;
    }
}
