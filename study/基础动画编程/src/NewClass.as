package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author dengSwing
	 */
	public class NewClass extends Sprite
	{
		
		public function NewClass() 
		{
			var tmpArr:Array=[1,2];

			for (var i:int = 0, j:int = tmpArr.length; i < j; i++) {
				trace(tmpArr[i]);
			}
		}
		
	}

}