package org 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.media.Video;
	import flash.media.Camera;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.events.Event;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	/**
	* ...
	* @author ezshine
	*/
	public class CamDetector extends Sprite
	{
		
		private var sv:Video;
		private var svs:Sprite;
		private var sc:Camera;
		private var _ShowEdge:Boolean;
		private var EdgeMC:Sprite;
		private var intervalId:uint;
		
		private var nowBMP:BitmapData;
		private var outBMP:BitmapData;
		private var doneBMP:BitmapData;
		private var beforeBMP:BitmapData;
		
		private var depth_num:Number;
		private var list_array:Array;
		
		
		public function CamDetector(_container:DisplayObjectContainer) 
		{
			if (_container)
			{
				_container.addChild(this);
				connectCamera();
			}
		}
		public function connectCamera(deviceName:String=null)
		{
			sc = Camera.getCamera(deviceName);
			sc.setMode(sc.width, sc.height, 60, false);
			sv = new Video(sc.width, sc.height); 
			svs = new Sprite();
			sv.attachCamera(sc);
			svs.addChild(sv);
			addChild(svs);
			showEdge = false;
		}
		public function set showEdge(bl:Boolean)
		{
			_ShowEdge = bl;
			if (bl)
			{
				EdgeMC = new Sprite();
				
				depth_num = 0;
				list_array = new Array();
				
				nowBMP = new BitmapData(svs.width, svs.height);
				outBMP = new BitmapData(svs.width, svs.height);
				
				var EdgeBitmap:Bitmap = new Bitmap(outBMP);
				EdgeMC.addChild(EdgeBitmap);
				addChild(EdgeMC);
				updateTime();
				intervalId = setInterval(updateTime, 50);
			}else
			{
				if (EdgeMC)
				{;
					nowBMP.dispose();
					outBMP.dispose();
					removeChild(EdgeMC);
					clearInterval(intervalId);
				}
			}
		}
		public function get showEdge():Boolean
		{
			return _ShowEdge;
		}
		public function changeVideoSize(_w:Number,_h:Number)
		{
			sv.width = _w;
			sv.height = _h;
			
			if (showEdge)
			{
				removeChild(EdgeMC);
				clearInterval(intervalId);
				
				showEdge = true;
			}
		}
		
		private function updateTime()
		{
			nowBMP.draw(svs, new Matrix(),null,null,null,false);
			doneBMP = nowBMP.clone();
			if(beforeBMP){
				doneBMP.draw(beforeBMP, new Matrix(), null, "difference", null, false);
			}
			doneBMP.threshold(doneBMP, doneBMP.rect, doneBMP.rect.topLeft, ">", 0xff1112c8, 0xffff00f0, 0xffffff, false);
			list_array.push(doneBMP.clone());
			if (list_array.length>5) {
				list_array.shift().dispose();
			}
			outBMP.fillRect(outBMP.rect, 0);
			beforeBMP = nowBMP.clone();
			for (var d:Number = 0; d<list_array.length; d++) {
				outBMP.threshold(list_array[d], outBMP.rect, outBMP.rect.topLeft, "==", 0xffff00f0,0xff1112c8, 0xffffff, false);
			}
		}
		
		public function getCameraBitmap():BitmapData{
			var myBitmapData:BitmapData=new BitmapData(sv.width, sv.height);
			myBitmapData.draw(sv,new Matrix());
			return myBitmapData;
		}
		public function getEdgeBitmap():BitmapData
		{
			var myBitmapData:BitmapData=new BitmapData(sv.width, sv.height);
			myBitmapData.draw(EdgeMC, new Matrix());
			return myBitmapData;
		}
	}
	
}