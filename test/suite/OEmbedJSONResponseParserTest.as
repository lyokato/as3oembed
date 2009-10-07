package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.oembed.OEmbedJSONResponseParser;
    import org.coderepos.oembed.IOEmbedResponseParser;
    import org.coderepos.oembed.OEmbedResponse;
    import org.coderepos.oembed.OEmbedResponseType;
    import com.adobe.net.URI;

    public class OEmbedJSONResponseParserTest extends TestCase {

        public function OEmbedJSONResponseParserTest(method:String) {
            super(method);
        }

        public static function suite():TestSuite {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new OEmbedJSONResponseParserTest("testParse"));
            return ts;
        }

        public function testParse():void {
            var json:String = '{"provider_url": "http://www.youtube.com/", "title": "Jude Law:  My Take On Peace Video Contest", "html": "<object width=\\"480\\" height=\\"295\\"><param name=\\"movie\\" value=\\"http://www.youtube.com/v/-UUx10KOWIE&fs=1\\"></param><param name=\\"allowFullScreen\\" value=\\"true\\"></param><param name=\\"allowscriptaccess\\" value=\\"always\\"></param><embed src=\\"http://www.youtube.com/v/-UUx10KOWIE&fs=1\\" type=\\"application/x-shockwave-flash\\" width=\\"480\\" height=\\"295\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"></embed></object>", "author_name": "PeaceOneDay", "height": 295, "width": 480, "version": "1.0", "author_url": "http://www.youtube.com/user/PeaceOneDay", "provider_name": "YouTube", "type": "video"}';
            var parser:IOEmbedResponseParser = new OEmbedJSONResponseParser();
            var res:OEmbedResponse = parser.parse(json);
            assertEquals(res.type, OEmbedResponseType.VIDEO);
            assertEquals(res.width, 480);
            assertEquals(res.height, 295);
        }

    }
}

