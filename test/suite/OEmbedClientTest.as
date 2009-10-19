package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import flash.events.*;

    import org.coderepos.oembed.OEmbedClient;
    import org.coderepos.oembed.OEmbedProviders;
    import org.coderepos.oembed.OEmbedResponse;
    import org.coderepos.oembed.OEmbedEvent;
    import com.adobe.net.URI;

    public class OEmbedClientTest extends TestCase {

        public function OEmbedClientTest(method:String) {
            super(method);
        }

        public static function suite():TestSuite {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new OEmbedClientTest("testYoutube"));
            ts.addTest(new OEmbedClientTest("testFlickr"));
            return ts;
        }
        
        public function testFlickr():void {
            var client:OEmbedClient = new OEmbedClient();
            client.registerProvider( OEmbedProviders.YOUTUBE );
            client.registerProvider( OEmbedProviders.FLICKR  );
            client.addEventListener( OEmbedEvent.COMPLETE, addAsync( flickrCompleteHandler, 1000 ) );
            client.get( new URI("http://www.flickr.com/photos/lyokato/2545807096/") );
        }

        private function flickrCompleteHandler(e:OEmbedEvent):void {
            var res:OEmbedResponse = e.result.data as OEmbedResponse;
            assertEquals('1.0', res.version);
            assertEquals('photo', res.type);
            assertEquals('hato', res.title);
            assertEquals('lyokato', res.authorName);
            assertEquals('http:\/\/www.flickr.com\/photos\/lyokato\/', res.authorURL.toString());
            assertEquals('3600', res.cacheAge);
            assertEquals('Flickr', res.providerName);
            assertEquals('http:\/\/www.flickr.com\/', res.providerURL);
            assertEquals('480', res.width);
            assertEquals('320', res.height);
            assertEquals('http:\/\/farm4.static.flickr.com\/3092\/2545807096_e854dec08f.jpg', res.url);
        }

        public function testYoutube():void {

            var client:OEmbedClient = new OEmbedClient();
            client.registerProvider( OEmbedProviders.YOUTUBE );
            client.registerProvider( OEmbedProviders.FLICKR  );
            client.addEventListener( OEmbedEvent.COMPLETE, addAsync( youtubeCompleteHandler, 1000 ) );
//            client.addEventListener( IOErrorEvent.IO_ERROR, addAsync( ioErrorHandler, 1000 ) );
 //           client.addEventListener( OEmbedEvent.ERROR, addAsync(errorHandler, 1000 ) );
            client.get( new URI("http://www.youtube.com/watch?v=-UUx10KOWIE") );
        }

        private function ioErrorHandler(e:IOErrorEvent):void {
            assertEquals('', e.toString());
        }

        private function youtubeCompleteHandler(e:OEmbedEvent):void {
            var res:OEmbedResponse = e.result.data as OEmbedResponse;

            //assertEquals('1.0', res.src);
            assertEquals('1.0', res.version);
            assertEquals('video', res.type);
            assertEquals('Jude Law:  My Take On Peace Video Contest', res.title);
            assertEquals('PeaceOneDay', res.authorName);
            assertEquals('http://www.youtube.com/user/PeaceOneDay', res.authorURL.toString());
            assertEquals('YouTube', res.providerName);
            assertEquals('0', res.cacheAge);
            assertNull(res.thumbnailURL);
            assertEquals('0', res.thumbnailHeight);
            assertEquals('0', res.thumbnailWidth);
            assertNull('url', res.url);
            //assertEquals('html', res.html);
            assertEquals('480', res.width);
            assertEquals('295', res.height);

            var x:XML = new XML(res.html);
            assertEquals('http://www.youtube.com/v/-UUx10KOWIE&fs=1', String(x.param.(hasOwnProperty("@name") && @name=="movie").@value[0]));
        }

        private function errorHandler(e:OEmbedEvent):void {

        }

    }
}
