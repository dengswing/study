package v
{
	import flash.display.Sprite;
	import flash.text.TextField;

	public class TextShow extends Sprite
	{
		private var textNum:TextField; 
		public function TextShow()
		{
			textNum = new TextField();
			addChild(textNum);
		}
		
		public function changeText(str:String):void
		{
			textNum.text = str;
		}
	}
}