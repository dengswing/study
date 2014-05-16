package {
	import fl.transitions.Tween;
	import fl.transitions.easing.None;
	import fl.transitions.easing.Regular;
	import fl.transitions.easing.Strong;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF(backgroundColor = 0xffffff)]
	
	public class FlashTween extends Sprite
	{
		private var tween:Tween;
		
		private var sprite:Sprite;
		
		public function FlashTween()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			sprite = new Sprite();
			sprite.graphics.beginFill(0xff0000);
			sprite.graphics.drawRect(-50, -25, 100, 50);
			sprite.graphics.endFill();
			sprite.x = 100;
			sprite.y = 100;			
			
			addChild(sprite);
		   tween = new Tween(sprite, "x", None.easeIn, 100, 500, 1, true);			
		}
	}
}