package  
{
	import org.superkaka.kakalib.optimization.BitmapMovie;
	import org.superkaka.kakalib.struct.BitmapFrameInfo;
	
	/**
	 * ...
	 * @author ｋａｋａ
	 * 带速度属性的BitmapMovie
	 */
	public class VBitmapMovie extends BitmapMovie
	{
		
		public var vx:Number;
		public var vy:Number;
		
		public function VBitmapMovie(frameInfo:Vector.<BitmapFrameInfo> = null):void
		{
			super(frameInfo);
		}
		
	}

}