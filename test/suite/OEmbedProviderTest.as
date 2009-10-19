package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.oembed.OEmbedProvider;
    import com.adobe.net.URI;

    public class OEmbedProviderTest extends TestCase {

        public function OEmbedProviderTest(method:String) {
            super(method);
        }

        public static function suite():TestSuite {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new OEmbedProviderTest("testMatchURI"));
            return ts;
        }

        public function testMatchURI():void {
            var flickr:OEmbedProvider = new OEmbedProvider(
                new URI("http://www.flickr.com/oembed"),
                Vector.<URI>([new URI("http://*.flickr.com/*")])
            );
            assertTrue("check flickr valid url", flickr.matchURI(new URI("http://hoge.flickr.com/hoge")));
            assertFalse("check flickr invalid url", flickr.matchURI(new URI("http://hoge.youtube.com/hoge")));

            var youtube:OEmbedProvider = new OEmbedProvider(
                new URI("http://www.youtube.com/oembed"),
                Vector.<URI>([new URI("http://www.youtube.com/watch")])
            );
            assertTrue("check youtube valid url", youtube.matchURI(new URI("http://www.youtube.com/watch?v=HOGE")));
            assertFalse("check youtube invalid url", youtube.matchURI(new URI("http://www.flickr.com/watch?v=HOGE")));
        }

    }
}
