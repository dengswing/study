package {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.media.Microphone;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	
	//[ SWF (backgroundColor='#000000') ]
	
	public class MicrophoneTest extends Sprite
	{
		private var _mic:Microphone;
		private var _bmpd:BitmapData;
		
		public function MicrophoneTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_bmpd = new BitmapData(400, 50, false, 0xffffff);
			addChild(new Bitmap(_bmpd));

			_mic = Microphone.getMicrophone();
			
		//	Security.showSettings(SecurityPanel.MICROPHONE);//设置麦克风	
					
			_mic.setLoopBack(true);//开启麦克风
			addEventListener(Event.ENTER_FRAME, onEnterFrame);	
			
			trace(_mic.name);
		}		
		
		private function onEnterFrame(event:Event):void {
			//trace(_mic.activityLevel);	//读取麦克风活跃级数
			
			_bmpd.setPixel(289, 50 - _mic.activityLevel / 2, 0);
			_bmpd.scroll(-1, 0);
		}
		
		
	}
}