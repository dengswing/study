package 
{
	import com.touchmypixel.peepee.utils.Animation;
	import com.touchmypixel.peepee.utils.AnimationCache;
	import fl.controls.Button;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.utils.getDefinitionByName

	public class Test extends Sprite
	{
		public var e_button1:Button;
		public var e_button2:Button;
		public var e_button3:Button;
		
		public var clips:Array = [];
		
		public var memoryBase:Number ;
		private var fps;
		
		public function Test() 
		{
			memoryBase = System.totalMemory;
			trace(memoryBase);
			
			
			fps = new FPS();
			fps.x = 50
			addChild(fps)
			
			createCachedSpriteSheet(null);
			
			
			e_button1.addEventListener(MouseEvent.CLICK, createNormal);
			e_button2.addEventListener(MouseEvent.CLICK, createCached);
			e_button3.addEventListener(MouseEvent.CLICK, createCachedSpriteSheet);
			
		}

		
		public function clear()
		{
			for each(var clip in clips)
			{
				clip.stop();
				removeChild(clip)
			}
			clips = [];
		}
		
		public function createNormal(e)
		{
			trace("create normal");
			clear();
			
			for (var i = 0; i < 6; i++)  {
				for (var j = 0; j < 8; j++)  {
					var cache = new (getDefinitionByName("Animation_Zombie"))();
					cache.x = j * 100+100;
					cache.y = i * 100+153;
					cache.gotoAndPlay(Math.floor(Math.random() * 45));
					addChild(cache);
					clips.push(cache);
				}
			}
			trace("mem: ", (System.totalMemory - memoryBase));
			
			addChild(e_button1);
			addChild(e_button2);
			addChild(e_button3);
			addChild(fps);
		}
		
		
		public function createCached(e)
		{
			trace("create caches");
			clear();
			
			var animationCache:AnimationCache = AnimationCache.getInstance();
			animationCache.replaceExisting = true;
			animationCache.cacheAnimation("Animation_Zombie")			
			
			for (var i = 0; i < 6; i++)  {
				for (var j = 0; j < 8; j++)  {
					var clip:Animation = animationCache.getAnimation("Animation_Zombie");
					clip.x = j * 100 +100;
					clip.y = i * 100 +153;
					clip.gotoAndPlay(Math.floor(Math.random() * 45));
					//clip.scaleX = -1;
					addChild(clip);
					clips.push(clip);
				}
			}
			trace("mem: ", (System.totalMemory - memoryBase));
			
			addChild(e_button1);
			addChild(e_button2);
			addChild(e_button3);
			addChild(fps);
		}
		
				
		private function createCachedSpriteSheet(e:MouseEvent):void 
		{
			trace("create caches spritesheet");
			clear();
			
			var animationCache:AnimationCache = AnimationCache.getInstance();
			animationCache.replaceExisting = true;
			animationCache.cacheAnimation("Animation_Zombie", true)			
			
			for (var i = 0; i < 6; i++)  {
				for (var j = 0; j < 8; j++)  {
					var clip:Animation = animationCache.getAnimation("Animation_Zombie");
					clip.x = j * 100;
					clip.y = i * 100;
					clip.gotoAndPlay(Math.floor(Math.random() * 45));
					//clip.scaleX = -1;
					addChild(clip);
					clips.push(clip);
				}
			}
			trace("mem: ", (System.totalMemory - memoryBase));
			
			addChild(e_button1);
			addChild(e_button2);
			addChild(e_button3);
			addChild(fps);
			
			
		}
	}
}