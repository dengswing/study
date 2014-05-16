package org
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.net.FileReference;
    import flash.utils.ByteArray;
    
    import mx.graphics.codec.IImageEncoder;
    import mx.graphics.codec.JPEGEncoder;
    import mx.graphics.codec.PNGEncoder;
 
    public class SavingBitmap extends Bitmap
    {
        private var _fileRef:FileReference;
        private var _encoder:IImageEncoder;
        private var _jpegQuality:Number = 100;
        private var _encoderType:String = JPEG;
        
        public static const JPEG:String = "jpeg";
        public static const PNG:String = "png";
        
        
        public function SavingBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
        {
            super(bitmapData, pixelSnapping, smoothing);
            _fileRef = new FileReference();
            _encoder = new JPEGEncoder(_jpegQuality);
        }
        
        public function set jpegQuality(value:Number):void
        {
            _jpegQuality = value;
            if(_encoder is JPEGEncoder)
            {
                _encoder = new JPEGEncoder(_jpegQuality);
            }
        }
        public function get jpegQuality():Number
        {
            return _jpegQuality;
        }
        
        public function set encoderType(value:String):void
        {
            _encoderType = value;
            if(_encoderType == JPEG)
            {
                _encoder = new JPEGEncoder(_jpegQuality);
            }
            else
            {
                _encoder = new PNGEncoder();
            }
        }
        public function get encoderType():String
        {
            return _encoderType;
        }
        
        public function save(defaultFileName:String = null):void
        {
            var ba:ByteArray = _encoder.encode(bitmapData);
            _fileRef.save(ba, defaultFileName);
            ba.clear();
        }
		public function saveFile(_b:ByteArray,defaultFileName:String=null)
        {
            _fileRef.save(_b, defaultFileName);
            _b.clear();
        }
    }
} 