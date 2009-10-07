package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.oembed.OEmbedXMLResponseParser;
    import org.coderepos.oembed.IOEmbedResponseParser;
    import org.coderepos.oembed.OEmbedResponse;
    import org.coderepos.oembed.OEmbedResponseType;
    import com.adobe.net.URI;

    public class OEmbedXMLResponseParserTest extends TestCase {

        public function OEmbedXMLResponseParserTest(method:String) {
            super(method);
        }

        public static function suite():TestSuite {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new OEmbedXMLResponseParserTest("testParse"));
            return ts;
        }

        public function testParse():void {
            var src:String = '<?xml version="1.0" encoding="utf-8"?><oembed><provider_url>http://www.youtube.com/</provider_url><title>Jude Law:  My Take On Peace Video Contest</title><html>&lt;object width="480" height="295"&gt;&lt;param name="movie" value="http://www.youtube.com/v/-UUx10KOWIE&amp;fs=1"&gt;&lt;/param&gt;&lt;param name="allowFullScreen" value="true"&gt;&lt;/param&gt;&lt;param name="allowscriptaccess" value="always"&gt;&lt;/param&gt;&lt;embed src="http://www.youtube.com/v/-UUx10KOWIE&amp;fs=1" type="application/x-shockwave-flash" width="480" height="295" allowscriptaccess="always" allowfullscreen="true"&gt;&lt;/embed&gt;&lt;/object&gt;</html><author_name>PeaceOneDay</author_name><height>295</height><width>480</width><version>1.0</version><author_url>http://www.youtube.com/user/PeaceOneDay</author_url><provider_name>YouTube</provider_name><type>video</type></oembed>';
            var parser:IOEmbedResponseParser = new OEmbedXMLResponseParser();
            var res:OEmbedResponse = parser.parse(src);
            assertEquals(OEmbedResponseType.VIDEO, res.type);
            assertEquals(480, res.width);
            assertEquals(295, res.height);
        }

    }
}

