package com.cn
{
	import flash.display.Sprite;
	import flash.text.TextField;

	public class TT extends Sprite
	{
		public var _tf:TextField;
		public function TT()
		{
			super();
			_tf.autoSize ="left";
			_tf.text = "這個是預載類中構造函數的行為";
		}
		
	}
}