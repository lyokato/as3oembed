package suite {
  import flexunit.framework.TestSuite;
  public class AllTests extends TestSuite {
    public function AllTests() {
      super();
      // Add tests here
      // For examples, see: http://code.google.com/p/as3flexunitlib/wiki/Resources
      //addTest(SomeTest.suite());
      addTest( URLRegExpCompilerTest.suite() );
      addTest( URIFinderTest.suite() );
      addTest( OEmbedProviderTest.suite() );
      addTest( OEmbedProviderManagerTest.suite() );
      addTest( RequestURLBuilderTest.suite() );
      addTest( OEmbedJSONResponseParserTest.suite() );
      addTest( OEmbedXMLResponseParserTest.suite() );
      addTest( OEmbedClientTest.suite() );
    }
  }
}
