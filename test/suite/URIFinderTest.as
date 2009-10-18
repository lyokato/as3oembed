package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import org.coderepos.text.URIFinder;
    import org.coderepos.text.URIFinderElem;
    import com.adobe.net.URI;

    public class URIFinderTest extends TestCase {

        public function URIFinderTest(method:String) {
            super(method);
        }

        public static function suite():TestSuite {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new URIFinderTest("testFind"));
            ts.addTest(new URIFinderTest("testSplit"));
            ts.addTest(new URIFinderTest("testSplitWithoutTrimming"));
            ts.addTest(new URIFinderTest("testProcess"));
            return ts;
        }

        public function testFind():void {
            var str:String = "hogehoge http://hoge.com/, aaa http://example.com/hoge?v=q aaaaa";
            var results:Array = URIFinder.find(str);
            assertEquals(2, results.length);
            assertEquals("http://hoge.com/", results[0]);
            assertEquals("http://example.com/hoge?v=q", results[1]);

            str = "hogehttp://hoge.com/http://example.com";
            results = URIFinder.find(str);
            assertEquals(1, results.length);
            assertEquals('http://example.com', results[0]);

            str = "hogehttp://example.com";
            results = URIFinder.find(str);
            assertEquals(0, results.length);

            str = "Lyo Kato (http://d.hatena.ne.jp/lyokato)";
            results = URIFinder.find(str);
            assertEquals(1, results.length);
            assertEquals('http://d.hatena.ne.jp/lyokato', results[0]);
        }

        public function testProcess():void {
            var str:String = "hoge http://hoge.com/, aaa http://example.com/hoge?v=q aaaaa";
            var results:Array = new Array();
            URIFinder.process(str, function(e:URIFinderElem):void {
                switch (e.type) {
                    case URIFinder.URI:
                        results.push("<a href=\""+ e.data +"\">" + e.data + "</a>");
                        break;
                    case URIFinder.TEXT:
                        results.push("<p>" + e.data + "</p>");
                        break;
                }
            });
            assertEquals('<p>hoge</p><a href="http://hoge.com/">http://hoge.com/</a><p>, aaa</p><a href="http://example.com/hoge?v=q">http://example.com/hoge?v=q</a><p>aaaaa</p>', results.join(''));
        }

        public function testSplit():void {
            var str:String = "hoge http://hoge.com/, aaa http://example.com/hoge?v=q aaaaa";
            var results:Array = URIFinder.split(str);
            assertEquals(5, results.length);
            assertEquals("hoge", results[0].data);
            assertEquals("http://hoge.com/", results[1].data);
            assertEquals(", aaa", results[2].data);
            assertEquals("http://example.com/hoge?v=q", results[3].data);
            assertEquals("aaaaa", results[4].data);
        }

        public function testSplitWithoutTrimming():void {
            var str:String = "hoge http://hoge.com/, aaa http://example.com/hoge?v=q aaaaa";
            var results:Array = URIFinder.split(str, false);
            assertEquals(5, results.length);
            assertEquals("hoge ", results[0].data);
            assertEquals("http://hoge.com/", results[1].data);
            assertEquals(", aaa ", results[2].data);
            assertEquals("http://example.com/hoge?v=q", results[3].data);
            assertEquals(" aaaaa", results[4].data);
        }

    }
}
