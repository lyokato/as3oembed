package suite
{
    import flexunit.framework.TestCase;
    import flexunit.framework.TestSuite;

    import flash.events.*;

    import org.coderepos.oembed.OEmbedClient;
    import org.coderepos.oembed.OEmbedProviders;
    import org.coderepos.oembed.OEmbedEvent;
    import com.adobe.net.URI;

    public class OEmbedClientTest extends TestCase {

        public function OEmbedClientTest(method:String) {
            super(method);
        }

        public static function suite():TestSuite {
            var ts:TestSuite = new TestSuite();
            ts.addTest(new OEmbedClientTest("testGet"));
            return ts;
        }

        public function testGet():void {

            var client:OEmbedClient = new OEmbedClient();
            client.registerProvider( OEmbedProviders.YOUTUBE );
            client.registerProvider( OEmbedProviders.FLICKR  );
            client.addEventListener( OEmbedEvent.COMPLETE, addAsync( completeHandler, 1000 ) );
//            client.addEventListener( IOErrorEvent.IO_ERROR, addAsync( ioErrorHandler, 1000 ) );
 //           client.addEventListener( OEmbedEvent.ERROR, addAsync(errorHandler, 1000 ) );
            client.get( new URI("http://www.youtube.com/watch?v=-UUx10KOWIE") );
        }

        private function ioErrorHandler(e:IOErrorEvent):void {
            assertEquals('', e.toString());
        }

        private function completeHandler(e:OEmbedEvent):void {
            assertEquals('1.0', e.result.data.version);
        }

        private function errorHandler(e:OEmbedEvent):void {

        }

    }
}
