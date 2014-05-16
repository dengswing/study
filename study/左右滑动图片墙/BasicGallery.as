package  
{
	import fl.lang.Locale;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import com.greensock.TweenLite;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author winky
	 */
	public class BasicGallery extends MovieClip
	{
		public var imageHolder:MovieClip;
		protected var playDirection:String = "left";
		protected var imageAry:Array = [];
		protected var imageVoAry:Array = [];
		protected var allImageAry:Array = [];

		protected var centerX:int = 941 / 2 - 170;
		protected var centerY:int = 380 / 2 - 170;
		protected var xAry:Array = [0,140,350,560,700];
		protected var yAry:Array = [centerY + 100,centerY + 80,centerY + 50,centerY + 80,centerY + 100];
		protected var sizeAry:Array = [0.4,0.75,1,0.75,0.4];

		protected var tween1:Tween;
		protected var tween2:Tween;
		protected var tween3:Tween;
		protected var tween4:Tween;
		protected var tween5:Tween;
		public var imgSpeed:int = 25;
		protected var timer:Timer = new Timer(3000);
		
		protected var imageViewNum:int = 5;
		
		protected var lastImageX:int = 800;
		
		public function BasicGallery() 
		{
			imageHolder = new MovieClip();
			imageHolder.x = 120;
			imageHolder.y = 90;
			this.addChild(imageHolder);
			
		}
		
		public function loadXML(url:String):void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));
			urlLoader.addEventListener(Event.COMPLETE, loadComplete);
		}
		
		public function showTitleTxt(_title:String):void
		{
				
		}
		
		protected function showContentTxt(obj:Object):void
		{
			
		}
		
		protected function loadComplete(evt:Event):void
		{
			var xml:XML = new XML((evt.currentTarget as URLLoader).data);
			var imageXmlList:XMLList = parseXML(xml);
			var remainNum:int = imageViewNum-imageVoAry.length;
			var remainAry:Array = [];
			if(remainNum>0)
			{
				var index:int  = 0;
				for(var j:int = 0;j<remainNum;j++)
				{
					if(index>imageVoAry.length-1)
					{
						index = 0;
					}
					remainAry[j] = imageVoAry[index];
					index++;
				}
			}
			imageVoAry = imageVoAry.concat(remainAry);
			
			if (imageXmlList.length() > 0)
			{
				createGallery();

				timer.addEventListener(TimerEvent.TIMER, timerHd);
				timer.start();
			}
			
			this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}
	
		protected function parseXML(xml:XML):XMLList
		{
			return null;
		}
		
//创建图片墙，只创建5个
		private function createGallery():void
		{
			imageAry = [];
			allImageAry = [];
			var len:int = imageVoAry.length > imageViewNum ? imageViewNum:imageVoAry.length;
			for (var i:int = 0; i < imageVoAry.length; i++)
			{
				var img:Img = new Img();
				img.index = i;
				if (i < imageViewNum)
				{
					imageAry.push(img);
					img.x = xAry[i];
					img.y = yAry[i];
					img.scaleX = sizeAry[i];
					img.scaleY = sizeAry[i];
				}else {
					img.alpha = 0;	
					img.x = 200;
					img.y = 0;
				}
				allImageAry.push(img);
				imageHolder.addChild(img);
			
				var imgVo:Object = imageVoAry[i];
				loadImg(imgVo.imageUrl, img.thumbs);
				
			}
			swapDepth();
			var middleIndex:int = int(imageViewNum / 2);
			showContentTxt(imageVoAry[imageAry[middleIndex].index]);
		}
		
		
		private function loadImg(url:String,cav:MovieClip):void
		{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url));
			cav.addChild(loader);
		}
		
		
		private function move():void
		{
			if (playDirection == "right")
			{
				var newIndex:int = imageAry[0].index - 1;
				if (newIndex < 0)
				{
					newIndex = imageVoAry.length - 1;
				}
				var newImg:Img = allImageAry[newIndex];
				newImg.x = -50;
				newImg.y = centerY;
				newImg.scaleX = 0.1;
				newImg.scaleY = 0.1;
				newImg.alpha = 0;
				imageAry.unshift(newImg);
				for (var i:int = 0; i < imageAry.length; i++)
				{
					var img = imageAry[i];
					if (i < imageAry.length - 1)
					{
						TweenLite.to(img,0.3,{x:xAry[i],y:yAry[i],scaleX:sizeAry[i],scaleY:sizeAry[i],alpha:1});
						
					}
					else
					{//最后一个
						TweenLite.to(img,0.3,{x:lastImageX,y:centerY,scaleX:0.1,scaleY:0.1,alpha:0});
					}
				}

				imageAry.pop();
				swapDepth();
			}
			else if (playDirection == "left")
			{
				newIndex = imageAry[imageAry.length - 1].index + 1;
				if (newIndex > imageVoAry.length-1)
				{
					newIndex = 0;
				}
				newImg = allImageAry[newIndex];
				newImg.x = lastImageX;
				newImg.y = centerY;
				newImg.scaleX = 0.1;
				newImg.scaleY = 0.1;
				newImg.alpha = 0;
				imageAry.push(newImg);
				for (var j:int = 0; j < imageAry.length; j++)
				{
					img = imageAry[j];
					if (j >0)
					{
						TweenLite.to(img,0.3,{x:xAry[j - 1],y:yAry[j - 1],scaleX:sizeAry[j - 1],scaleY:sizeAry[j - 1],alpha:1});
					}
					else
					{//最后一个
						TweenLite.to(img,0.3,{x:-50,y:centerY,scaleX:0.1,scaleY:0.1,alpha:0});
					}
				}

				imageAry.shift();
				swapDepth();
			}
			var middleIndex:int = int(imageViewNum / 2);
			showContentTxt(imageVoAry[imageAry[middleIndex].index]);
		}

		//调整深度
		protected function swapDepth():void
		{
			imageHolder.addChild(imageAry[0]);
			if (imageAry[4])
			{
				imageHolder.addChild(imageAry[4]);
			}
			if (imageAry[1])
			{
				imageHolder.addChild(imageAry[1]);
			}
			if (imageAry[3])
			{
				imageHolder.addChild(imageAry[3]);
			}
			if (imageAry[2])
			{
				imageHolder.addChild(imageAry[2]);
			}
		}
		
		protected function rightHandler(evt:MouseEvent):void
		{
			playDirection = "right";
			timer.reset();
			timer.start();
			move();
		}

		protected function leftHandler(evt:MouseEvent):void
		{
			playDirection = "left";
			timer.reset();
			timer.start();
			move();
		}
		
		private var canRotate:Boolean = true
		protected function mouseWheelHandler(evt:MouseEvent):void
		{
			if (evt.delta > 1  && canRotate)
			{
				leftHandler(null);
				canRotate = false;
				setTimeout(canRotateHandler, 300);
			}else if(evt.delta<-1 && canRotate){
				rightHandler(null);
				canRotate = false;
				setTimeout(canRotateHandler, 300);
			}
		}
		
		protected function canRotateHandler():void
		{
			canRotate = true;
		}
		
		

		protected function timerHd(evt:TimerEvent):void
		{
			move();
		}
    }
	
}