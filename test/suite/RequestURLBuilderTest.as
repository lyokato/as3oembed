package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.oembed.RequestURLBuilder;
    import org.coderepos.oembed.OEmbedRequestOption;
    import org.coderepos.oembed.OEmbedFormat;
    import com.adobe.net.URI;

    public class RequestURLBuilderTest extends TestCase {

        public function RequestURLBuilderTest(method:String) {
            super(method);
        }

        public static function suite():TestSuite {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new RequestURLBuilderTest("testBuild"));
            return ts;
        }

        public function testBuild():void {
            var option:OEmbedRequestOption = new OEmbedRequestOption();
            option.format = OEmbedFormat.JSON;
            var url:String = RequestURLBuilder.build(new URI("http://www.youtube.com/oembed"), new URI("http://www.youtube.com/watch?v=-UUx10KOWIE"), option);
            assertEquals("http://www.youtube.com/oembed?url=http://www.youtube.com/watch?v%3D-UUx10KOWIE&format=json", url);
        }

    }
}
