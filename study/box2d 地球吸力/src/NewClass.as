package  
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class NewClass extends Sprite
	{
		
		public function NewClass() 
		{
			
			var dataArray:Array = String("78da6360,c40718a8,a068b55,44b903af,3cb25246,7a8051ab,46ad1ab5,6a185845,3f0000e2,34048500").split(",");
			var byteArray:ByteArray = new ByteArray();
			var item:String
			for each (item in dataArray)
			{
				byteArray.writeUnsignedInt(int("0x" + item));
			}
			
			trace(byteArray.length);//40
			byteArray.uncompress();
			trace(byteArray.length,byteArray.readUnsignedInt());//39
			byteArray.compress();
			
			byteArray.position = 0;
			trace(byteArray.length,byteArray.readUnsignedInt());//39
			//为啥压缩前跟我压缩后的长度不一样啊？
		}
		
	}

}