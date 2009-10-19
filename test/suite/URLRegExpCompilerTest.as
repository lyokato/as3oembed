package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.oembed.URLRegExpCompiler;
    import com.adobe.net.URI;

    public class URLRegExpCompilerTest extends TestCase {

        public function URLRegExpCompilerTest(method:String) {
            super(method);
        }

        public static function suite():TestSuite {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new URLRegExpCompilerTest("testRunRegExp"));
            ts.addTest(new URLRegExpCompilerTest("testCompile"));
            return ts;
        }

        public function testRunRegExp():void {
            assertEquals("www\\.youtube\\.com", URLRegExpCompiler.runRegExp("www.youtube.com", "[0-9a-zA-Z-]+"));
            assertEquals("[0-9a-zA-Z-]+\\.youtube\\.com", URLRegExpCompiler.runRegExp("*.youtube.com", "[0-9a-zA-Z-]+"));
        }

        public function testCompile():void {
            assertEquals("http://www\\.youtube\\.com\\/watch", URLRegExpCompiler.compileToString(new URI("http://www.youtube.com/watch")));
            assertEquals("http://[0-9a-zA-Z-]+\\.flickr\\.com\\/[\\;\\/\\?\\:\\@\\&\\=\\+\\$\\,\\[\\]A-Za-z0-9\\-_\\.\\!\\~\\*\\'\\(\\)%]+",
                URLRegExpCompiler.compileToString(new URI("http://*.flickr.com/*")));
        }

    }
}

