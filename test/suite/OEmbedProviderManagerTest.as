package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.oembed.OEmbedProviderManager;
    import org.coderepos.oembed.OEmbedProvider;
    import com.adobe.net.URI;

    public class OEmbedProviderManagerTest extends TestCase {

        public function OEmbedProviderManagerTest(method:String) {
            super(method);
        }

        public static function suite():TestSuite {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new OEmbedProviderManagerTest("testManager"));
            return ts;
        }

        public function testManager():void {
            var flickr:OEmbedProvider = new OEmbedProvider(new URI("http://www.flickr.com/oembed"), new URI("http://*.flickr.com/*"));
            var youtube:OEmbedProvider = new OEmbedProvider(new URI("http://www.youtube.com/oembed"), new URI("http://www.youtube.com/watch"));

            var manager:OEmbedProviderManager = new OEmbedProviderManager();
            manager.registerProvider(flickr);
            manager.registerProvider(youtube);
            var found:OEmbedProvider = manager.findProviderByURI(new URI("http://hoge.flickr.com/hoge"));
            assertEquals("http://www.flickr.com/oembed", found.apiEndpoint.toString());
            var found2:OEmbedProvider = manager.findProviderByURI(new URI("http://www.youtube.com/watch?v=HOGEHOGE"));
            assertEquals("http://www.youtube.com/oembed", found2.apiEndpoint.toString());
            var found3:OEmbedProvider = manager.findProviderByURI(new URI("http://unknown.com/"));
            assertNull(found3);
        }

    }
}
