package org 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import org.gif.player.GIFPlayer;
	import org.gif.decoder.GIFDecoder;
	import org.gif.encoder.GIFEncoder;
	import org.gif.frames.GIFFrame;
	import org.gif.events.GIFPlayerEvent;
	import org.gif.events.FileTypeEvent;
	import org.gif.events.FrameEvent;
	import org.gif.events.TimeoutEvent;
	
	import flash.events.MouseEvent;
	
	import org.CamDetector;
	import org.FitStage;
	import org.FrameLib;
	
	import gs.TweenMax;
	import gs.easing.*;
	
	import fl.controls.Button;
	import org.SavingBitmap;
	
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	import org.FilterLib;
	
	import flash.display.Shader;
	import flash.filters.ShaderFilter;
	/**
	* ...
	* @author ezshine
	*/
	public class CameraContainer extends Sprite
	{
		private var myCamDetector:CamDetector;
		private var myFrameLib:FrameLib;
		private var myFilterLib:FilterLib;
		
		private var shader:Shader; 
		
		private var myFrame:Sprite;
		private var myStage:FitStage;
		private var infobar:Sprite;
		private var FrameContainer:Sprite;
		private var takePhotoBtn:Button;
		private var changeFrameBtn:Button;
		private var changeFilterBtn:Button;
		private var QameraSprite:Sprite;
		private var _bmp:SavingBitmap;
		private var _bw:Number;
		private var _bh:Number;
		private var nowFrame:Object;
		private var nowFilter:Object;
		private var myGIFEncoder:GIFEncoder;
		
		public function CameraContainer(parent_object:DisplayObjectContainer) 
		{
			myStage = FitStage.getInstance();
			parent_object.addChild(this);
			createinfoBar();
			QameraSprite = new Sprite();
			addChild(QameraSprite);
			addCamera();
			setupButton();
			myStage.addFitObject(this, "center", new Point( -160,-120));
			initFrameLib();
		}
		private function createinfoBar()
		{
			infobar = new Sprite();
			var infoText:TextField = new TextField();
			infoText.name = "infoText";
			infoText.selectable = false;
			infoText.background = true;
			infoText.backgroundColor = 0x66cc00;
			infoText.autoSize = TextFieldAutoSize.LEFT;
			infobar.addChild(infoText);
			addChild(infobar);
		}
		private function showInfoBar(str:String)
		{
			TweenMax.to(infobar, 2, { alpha:100} );
			(infobar.getChildByName("infoText") as TextField).text = str;
		}
		private function hideInfoBar()
		{
			TweenMax.to(infobar, 2, { alpha:0} );
		}
		private function initFrameLib()
		{
			myFrameLib = new FrameLib();
			myFrameLib.loadFrameLibrary("framelib.xml");
			showInfoBar("开始加载外框配置文件");
			myFrameLib.addEventListener("onLoadComplete", onLibLoaded);
		}
		private function initFilterLib()
		{
			myFilterLib = new FilterLib();
			myFilterLib.loadFilterLibrary("filterlib.xml");
			showInfoBar("开始加载特效配置文件");
			myFilterLib.addEventListener("onLoadComplete", onLibLoaded);
		}
		private function onLibLoaded(e:Event)
		{
			switch(e.target)
			{
				case myFrameLib:
					showInfoBar("外框配置文件加载完成");
					hideInfoBar();
					RandomFrame();
					initFilterLib();
					break;
				case myFilterLib:
					showInfoBar("特效配置文件加载完成");
					hideInfoBar();
					RandomFilter();
					break;
			}
		}
		private function RandomFrame()
		{
			var randomStyle:Array = myFrameLib.getStyle(myFrameLib.getStyleNames()[Math.floor(Math.random() * myFrameLib.getStyleNames().length)]);
			var targetframe:Object = randomStyle[Math.floor(Math.random() * randomStyle.length)];
			nowFrame = targetframe;
			loadFrame(targetframe.path,targetframe.isAni);
		}
		private function addCamera()
		{

			myCamDetector = new CamDetector(QameraSprite);
			myCamDetector.changeVideoSize(320, 240);
			
		}
		private function loadFrame(url:String,_isAni:Boolean)
		{
			if (FrameContainer)
			{
				QameraSprite.removeChild(FrameContainer);
				FrameContainer = null;
			}
			FrameContainer = new Sprite();
			QameraSprite.addChild(FrameContainer);
			
			//showInfoBar("开始加载外框");
			takePhotoBtn.enabled = false;
			var urlReq:URLRequest = new URLRequest(url);
			if (_isAni)
			{
				var myGIFPlayer:GIFPlayer = new GIFPlayer();
				myGIFPlayer.name = "myGIFPlayer";
				FrameContainer.addChild(myGIFPlayer);
				myGIFPlayer.load (urlReq);
				myGIFPlayer.addEventListener ( GIFPlayerEvent.COMPLETE, onAniFrameloaded );
			}else
			{
				var FrameLdr:Loader = new Loader();
				FrameContainer.addChild(FrameLdr);
				FrameLdr.load(urlReq);
				FrameLdr.contentLoaderInfo.addEventListener(Event.COMPLETE, onFrameloaded);
			}
		}
		
		private function RandomFilter()
		{
			var targetFilter:Object = myFilterLib.getFilter(myFilterLib.getFilterNames()[Math.floor(Math.random() * myFilterLib.getFilterNames().length)]);
			nowFilter = targetFilter;
			loadFilter(targetFilter.path);
		}
		
		private var Filterloader:URLLoader;
		private function loadFilter(url:String)
		{
			Filterloader = new URLLoader(); 
            Filterloader.dataFormat = URLLoaderDataFormat.BINARY; 
			Filterloader.load(new URLRequest(url)); 
			Filterloader.addEventListener(Event.COMPLETE, onFilterLoadComplete); 
		}
		private function onFilterLoadComplete(e:Event)
		{
			shader = new Shader(Filterloader.data); 
			if(nowFilter.param){
				shader.data[nowFilter.param].value = [parseFloat(nowFilter.value)];
			}
            var invertFilter:ShaderFilter = new ShaderFilter(shader); 
            myCamDetector.filters = [invertFilter]; 
		}
		private function setupButton()
		{
			takePhotoBtn = new Button();
			changeFrameBtn = new Button();
			changeFilterBtn = new Button();
			
			takePhotoBtn.x = (myCamDetector.width - takePhotoBtn.width) / 2;
			changeFrameBtn.x = (myCamDetector.width - changeFrameBtn.width) / 2;
			changeFilterBtn.x=(myCamDetector.width - changeFilterBtn.width) / 2;
			
			takePhotoBtn.y = myCamDetector.height + 5;
			changeFrameBtn.y = takePhotoBtn.y + takePhotoBtn.height + 5;
			changeFilterBtn.y=changeFrameBtn.y +changeFrameBtn.height+5;
			
			takePhotoBtn.label = "点击拍照";
			changeFrameBtn.label = "切换相框";
			changeFilterBtn.label = "切换特效";
			
			takePhotoBtn.addEventListener(MouseEvent.CLICK, btnClickHandle);
			changeFrameBtn.addEventListener(MouseEvent.CLICK, btnClickHandle);
			changeFilterBtn.addEventListener(MouseEvent.CLICK, btnClickHandle);
			
			addChild(takePhotoBtn);
			addChild(changeFrameBtn);
			addChild(changeFilterBtn);
		}
		private function btnClickHandle(e:MouseEvent)
		{
			switch(e.target)
			{
				case takePhotoBtn:
					if (nowFrame.isAni)
					{
						startSaveGIF();
					}else{
						saveToJpeg();
					}
					break;
				case changeFrameBtn:
					RandomFrame();
					break;
				case changeFilterBtn:
					RandomFilter();
					break;
			}
		}
		private function onFrameloaded(e:Event ):void
		{
			takePhotoBtn.enabled = true;
			showInfoBar("外框加载完成");
			hideInfoBar();
			e.target.removeEventListener(Event.COMPLETE, onFrameloaded);
			FrameContainer.x = Math.abs(e.target.width - myCamDetector.width) / 2;
			FrameContainer.y = Math.abs(e.target.height - myCamDetector.height) / 2;
			_bw = e.target.width;
			_bh = e.target.height;
		}
		private function onAniFrameloaded(e:GIFPlayerEvent ):void
		{
			takePhotoBtn.enabled = true;
			showInfoBar("外框加载完成");
			hideInfoBar();
			e.target.removeEventListener(GIFPlayerEvent.COMPLETE, onAniFrameloaded);
			var FrameRect:Rectangle = e.rect;
			FrameContainer.x = Math.abs(e.rect.width - myCamDetector.width) / 2;
			FrameContainer.y = Math.abs(e.rect.height - myCamDetector.height) / 2;
			_bw = e.rect.width;
			_bh = e.rect.height;
		}
		
		private function saveToJpeg()
		{
			var formBMP:BitmapData = new BitmapData(320, 240, false, 0);
			formBMP.draw(QameraSprite, new Matrix());
			var myPhoto:BitmapData = new BitmapData(_bw, _bh, false, 0);
			myPhoto.copyPixels(formBMP,new Rectangle(FrameContainer.x,FrameContainer.y,_bw,_bh),new Point(0,0),null,null);
			_bmp = new SavingBitmap(myPhoto);
			_bmp.save("myPhoto.jpg");
		}
		
		private var myTimer:Number;
		private var tempFrameIndex:Number;
		
		private function startSaveGIF()
		{
			takePhotoBtn.enabled = false;
			changeFrameBtn.enabled = false;
			myGIFEncoder = new GIFEncoder();
			myGIFEncoder.start();
			myGIFEncoder.setRepeat(0);
			myGIFEncoder.setQuality(10);
			
			var FrameGIF:GIFPlayer = (FrameContainer.getChildByName("myGIFPlayer") as GIFPlayer);
			tempFrameIndex = 1;
			myTimer = setInterval(convertToGIF, 10, FrameGIF,myGIFEncoder);
			convertToGIF(FrameGIF,myGIFEncoder);
		}
		private function convertToGIF(fg:GIFPlayer,gc:GIFEncoder)
		{
			if (tempFrameIndex <= fg.totalFrames)
			{
				var formBMP:BitmapData = new BitmapData(320, 240, false, 0);
				formBMP.draw(myCamDetector, new Matrix());
				var bp:BitmapData = new BitmapData(_bw, _bh, false, 0);
				bp.copyPixels(formBMP, new Rectangle(FrameContainer.x, FrameContainer.y, _bw, _bh), new Point(0, 0), null, null);
			
				var frame:GIFFrame = fg.getFrame(tempFrameIndex);
				var mixBMD:BitmapData = new BitmapData(bp.width, bp.height, true, 0xffffff);
				mixBMD.copyPixels(bp, new Rectangle(0, 0, bp.width, bp.height), new Point(0, 0),null,null,true);
				mixBMD.copyPixels(frame.bitmapData, new Rectangle(0, 0, bp.width, bp.height), new Point(0, 0),null,null,true);
				
				myGIFEncoder.addFrame(mixBMD);
			}else
			{
				saveToGif();
			}
			tempFrameIndex++;
		}
		private function saveToGif()
		{
			takePhotoBtn.enabled = true;
			changeFrameBtn.enabled = true;
			clearInterval(myTimer);
			myGIFEncoder.finish();
			_bmp = new SavingBitmap(new BitmapData(10,10,false,0));
			_bmp.saveFile(myGIFEncoder.stream,"myPhoto.gif");
		}
	}
	
}