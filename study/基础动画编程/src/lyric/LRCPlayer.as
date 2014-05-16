package lyric{	
	import com.hexagonstar.util.debug.Debug;
	import flash.display.Sprite; 
	import flash.net.URLRequest;
	import flash.net.URLLoader; 
	import flash.media.Sound; 
	import flash.media.SoundChannel;
	import flash.events.Event; 
	import flash.text.TextField;
	import flash.system.System; 
	
	public class LRCPlayer extends Sprite {
		
		private var lrc_txt:TextField = new TextField();
		private var LRCarray:Array = new Array();
		private var sc:SoundChannel; 
		
		public function LRCPlayer() {
			System.useCodePage = true; 
			
			lrc_txt.width = 500; 
			lrc_txt.selectable = false; 
			addChild(lrc_txt); 
			
			var loader:URLLoader = new URLLoader(); 
			loader.load(new URLRequest("music/周迅-爱恨恢恢.lrc"));
			Debug.timerStart("加载歌词")
			loader.addEventListener(Event.COMPLETE, LoadFinish);
			
			var sound:Sound = new Sound(); 
			sound.load(new URLRequest("music/周迅-爱恨恢恢.mp3"));
			Debug.timerStart("加载歌曲")
			sc = sound.play(); 
			
			//Debug.timerStopToString();
			stage.addEventListener(Event.ENTER_FRAME, SoundPlaying); 
		}
		
		private function SoundPlaying(evt:Event):void { 			
			for (var i:int = 1; i < LRCarray.length; i++) {
				if (sc.position < LRCarray[i].timer) { 
					lrc_txt.text = LRCarray[i - 1].lyric; 
					break; 
				} 
				lrc_txt.text = LRCarray[LRCarray.length - 1].lyric; 
			} 
		} 
		
		private function LoadFinish(evt:Event):void { 
			Debug.timerStopToString();
			
			var list:String = evt.target.data; 
			var listarray:Array = list.split("\n"); 
			var reg:RegExp =/\[[0-5][0-9]:[0-5][0-9].[0-9][0-9]\]/g;			
			for (var i:int = 0; i < listarray.length; i++) { 
				var info:String = listarray[i]; 
				var len:int = info.match(reg).length;
				var timeAry:Array = info.match(reg); 
				
				var lyricStr:String = info.substr(len * 10); 
				
				for (var k:int = 0; k < timeAry.length; k++) {
					var obj:Object = new Object(); 
					var ctime:String = timeAry[k]; 
					var ntime:Number = Number(ctime.substr(1, 2)) * 60 + Number(ctime.substr(4, 5)); 
					
					obj.timer = ntime * 1000;
					obj.lyric = lyricStr;
					
					LRCarray.push(obj); 
				}
			}
			
			LRCarray.sort(compare); 
		} 
		
		private function compare(paraA:Object, paraB:Object):int { 
			if (paraA.timer > paraB.timer) { 
				return 1;
			} 
			
			if (paraA.timer < paraB.timer) { 
				return -1;
			}
			
			return 0; 
		} 
	} 
}