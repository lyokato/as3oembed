package org.coderepos.oembed
{
    public class URIFinderElem
    {
        private var _type:uint;
        private var _data:String;

        public function URIFinderElem(data:String, type:uint)
        {
            _data = data;
            _type = type;
        }

        public function get type():uint
        {
            return _type;
        }

        public function get data():String
        {
            return _data;
        }
    }
}
