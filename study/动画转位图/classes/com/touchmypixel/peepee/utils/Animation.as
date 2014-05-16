package com.touchmypixel.peepee.utils 
{
	import com.bit101.display.BigAssCanvas;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	
	public class Animation extends Sprite
	{
		public var bitmap:Bitmap;
		public var clip:MovieClip;
		public var frames:Array = [];
		public var currentFrame:Number = 1;
		private var _playing:Boolean = false;
		private var _cache:Boolean = true;
		
		public var repeat:Boolean = true;
		public var onEnd:Function;
		private var clipData:MovieClip;
		public var reverse:Boolean = false;
		
		public var speed:Number = 1;
		
		public var treatAsLoopedGraphic:Boolean = false;
		public var bigBitmap:BigAssCanvas;
		
		public var cols:Number = 0;
		public var rows:Number = 0
		public var r:Rectangle
		private var _totalFrames;
		
		public var useSpriteSheet:Boolean = false;
		
		public function Animation() 
		{
			bitmap = new Bitmap();
			bitmap.smoothing = false;
			addChild(bitmap);
		}
		
		
		public function set bitmapData(value:BitmapData){ bitmap.bitmapData = value; }
		public function get bitmapData():BitmapData{ return bitmap.bitmapData; }
		
		public function get playing():Boolean { return _playing; }
		
		public function get totalFrames():Number { return clip.totalFrames; }
		
		public function buildCacheFromLibrary(identifier:String):void
		{
			if (useSpriteSheet) {
				buildCacheFromClip2(new (getDefinitionByName(identifier))());
				
			} else {
				buildCacheFromClip(new (getDefinitionByName(identifier))());
			}
		}
		public function buildCacheFromClip(_clip:MovieClip):void
		{			
			clip = _clip;
			
			if (clip["e_bounds"] != null)
			{
				var c = clip["e_bounds"];
				r = new Rectangle(c.x, c.y, c.width, c.height);
				clip["e_bounds"].visible = false;
			} else {
				r = clip.getRect(clip)
			}
			
			for (var i = 1; i <= clip.totalFrames; i++)
			{
				clip.gotoAndStop(i)
				makeAllChildrenGoToFrame(clip, i);
				var bitmapData:BitmapData = new BitmapData(r.width, r.height, true, 0x00000000);
				var m:Matrix = new Matrix();
				m.translate(-r.x, -r.y);
				m.scale(clip.scaleX, clip.scaleY);
				bitmapData.draw(clip,m);
				frames.push(bitmapData);
			}
			bitmap.x = r.x;
			bitmap.y = r.y;
		}
		
		public function buildCacheFromClip2(_clip:MovieClip):void
		{
			clip = _clip;
			
			if (clip["e_bounds"] != null)
			{
				var c = clip["e_bounds"];
				r = new Rectangle(c.x, c.y, c.width, c.height);
				clip["e_bounds"].visible = false;
			} else {
				r = clip.getRect(clip)
			}
			
			cols= Math.floor(2880 / r.width);
			rows= Math.ceil(clip.totalFrames / cols);
			
			bigBitmap = new BigAssCanvas( Math.ceil(cols * clip.width), Math.ceil(rows * clip.height), true);
			
			for (var i = 0; i <= clip.totalFrames-1; i++)
			{
				clip.gotoAndStop(i+1)
				makeAllChildrenGoToFrame(clip, i+1);
				
				var xx = i % cols * r.width;
				var yy = Math.floor(i/cols) * r.height;
				
				var m:Matrix = new Matrix();
				m.translate(-r.x, -r.y);
				
				m.scale(clip.scaleX, clip.scaleY);
				m.translate(xx, yy)
				
				bigBitmap.draw(clip, m, null, null);
			}
			_totalFrames = clip.totalFrames;
		}
		
		private function makeAllChildrenGoToFrame(m:MovieClip, f:int):void
		{
			for (var i:int = 0; i < m.numChildren; i++) {
				var c:* = m.getChildAt(i);
				if (c is MovieClip) {
					makeAllChildrenGoToFrame(c, f);
					c.gotoAndStop(f);
				}
			}
		}
		
		public function play():void
		{
			_playing = true;
			addEventListener(Event.ENTER_FRAME, enterFrame, false, 0, true);
		}
		
		public function stop():void
		{
			_playing = false;
			removeEventListener(Event.ENTER_FRAME, enterFrame)
		}
		
		public function gotoAndStop(frame:Number):void
		{
			if (treatAsLoopedGraphic) {
				if (frame > totalFrames) {
					frame = frame % totalFrames;
				}
			}
			currentFrame = frame;
			
			goto(currentFrame);
			stop();
		}
		
		public function gotoAndPlay(frame:Number):void
		{
			currentFrame = frame;
			goto(currentFrame);
			play();
		}
		
		public function gotoAndPlayRandomFrame():void
		{
			gotoAndPlay(Math.ceil(Math.random() * totalFrames));
		}
		
		public function nextFrame(useSpeed:Boolean = false):void
		{
			useSpeed ? currentFrame += speed : currentFrame++;
			if (currentFrame > totalFrames) currentFrame = 1;
			goto(Math.floor(currentFrame));
		}
		public function prevFrame(useSpeed:Boolean = false):void
		{
			useSpeed ? currentFrame -= speed : currentFrame--;
			
			if (currentFrame < 1) currentFrame = totalFrames;
			goto(Math.floor(currentFrame));
		}
		import flash.utils.getQualifiedClassName;
		
		private function goto(frame:Number):void
		{
			if (!_cache)
			{
				if (!clipData)
				{
					var c = getQualifiedClassName(clip);
					clipData = new(getDefinitionByName(c))();
					var rect:Rectangle = clipData.getRect(clipData);
					clipData.x = rect.x;
					clipData.y = rect.y;
					addChild(clipData);
				}
				clipData.gotoAndStop(frame);
			} else {
				
					if (useSpriteSheet) {
						var temp:Rectangle = r.clone();
						temp.x = ((currentFrame-1) % cols) * r.width;
						temp.y = Math.floor((currentFrame-1) / cols) * r.height;
						
						if(bitmapData)bitmapData.dispose();
						bitmapData = bigBitmap.copyPixelsOut(temp);
						bitmap.bitmapData = bitmapData;
						bitmap.smoothing = true;
					} else {
						bitmap.bitmapData = frames[currentFrame-1];
						bitmap.smoothing = true;
					}
			}
		}
		
		public function enterFrame(e:Event = null):void
		{
			if(reverse){
				prevFrame(true)
			}else {
				nextFrame(true);
			}
			
			if (currentFrame >= totalFrames) {
				
				if (!repeat) {
					stop();
				}
				dispatchEvent(new Event(Event.COMPLETE))
				if (onEnd != null) onEnd();
			}
		}
		
		public function update():void
		{
			//addChild(bigBitmap);
			stop();
			frames = [];
			buildCacheFromClip(clip);
		}
		
		public function destroy()
		{
			stop();
			if (parent) parent.removeChild(this);
		}
	}
}