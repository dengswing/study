package org 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.errors.IllegalOperationError;
	
	/**
	* ...
	* @author ezshine
	*/
	public class FitStage extends EventDispatcher
	{
		private static var _singleton:Boolean=true;
		private static var _instance:FitStage;
		private var theStage:Stage;
		private var FitObjectArray:Array;
		private var fitStarted:Boolean = false;
		public function FitStage() {
			if (_singleton) {
                 throw new Error("请使用getInstance()来获取实例");
            }
		}
		public function setStage(_st:Stage)
		{
			if (theStage==null)
			{
				theStage = _st;
				FitObjectArray = new Array();
				theStage.align = StageAlign.TOP_LEFT;
				theStage.scaleMode = StageScaleMode.NO_SCALE
				theStage.showDefaultContextMenu = false;
				startFit();
			}
		}
		public function addFitObject(...args):void//
		{
			if (args.length<2)
			{
				return;
			}
			var _t:DisplayObject =args[0];//displayObject
			var _a:String = args[1];//_a:topleft,topcenter,topright,left,center,right,bottomleft,bottomcenter.bottomright
			var offsetPoint:Point = args[2];//offset point
			var parentObject:DisplayObject = args[3];//function name string
			var refunc:Function = args[4];//function name string
			
			var tobject:Object={t:_t,a:_a};
			if (offsetPoint)
			{
				tobject.o=offsetPoint;
			}
			if (parentObject)
			{
				tobject.p = parentObject;
			}
			if (args[4]!=null)
			{
				tobject.r={runfunc:refunc};
			}
			if (parseFloat(checkTheSame(_t).toString())>=0)
			{
				FitObjectArray[checkTheSame(_t)] = tobject;
			}else{
				FitObjectArray.push(tobject);
			}
			onStageResize(new Event("active"));
		}
		private function checkTheSame(_t:DisplayObject)
		{
			for (var i:Number = 0; i <FitObjectArray.length; i++)
			{
				if (FitObjectArray[i].t==_t)
				{
					return i;
					break;
				}
			}
			return false;
		}
		public function removeFitObject(_t:DisplayObject)//_a:topleft,topcenter,topright,left,center,right,bottomleft,bottomcenter.bottomright
		{
			for (var i:Number = 0; i <FitObjectArray.length; i++)
			{
				if (FitObjectArray[i].t==_t)
				{
					FitObjectArray.splice(i,1);
					break;
				}
			}
		}
		public static function getInstance():FitStage
		{
			 if (!_instance) {
                _singleton=false;
                _instance=new FitStage();
                _singleton=true;
            }
			return _instance;
		}
		private function onStageResize(e:Event)
		{
			for (var i:Number = 0; i <FitObjectArray.length; i++)
			{
				var offsetx:Number = 0;
				var offsety:Number = 0;
				if(FitObjectArray[i].o){
					offsetx=FitObjectArray[i].o.x;
					offsety=FitObjectArray[i].o.y;
				}
				var nextx:Number;
				var nexty:Number;
				switch(FitObjectArray[i].a)
				{
					case "topleft":
						nextx = 0;
						nexty = 0;
						break;
					case "topcenter":
						nextx = Math.round(theStage.stageWidth / 2);
						nexty = 0;
						break;
					case "topright":
						nextx = theStage.stageWidth;
						nexty = 0;
						break;
					case "left":
						nextx = 0;
						nexty = Math.round(theStage.stageHeight / 2);
						break;
					case "center":
						nextx = Math.round(theStage.stageWidth / 2);
						nexty = Math.round(theStage.stageHeight / 2);
						break;
					case "right":
						nextx = theStage.stageWidth;
						nexty = Math.round(theStage.stageHeight / 2);
						break;
					case "bottomleft":
						nextx = 0;
						nexty = theStage.stageHeight;
						break;
					case "bottomcenter":
						nextx = Math.round(theStage.stageWidth / 2);
						nexty = theStage.stageHeight;
						break;
					case "bottomright":
						nextx = theStage.stageWidth;
						nexty = theStage.stageHeight;
						break;
				}
				if (FitObjectArray[i].p)
				{
					var parentPoint:Point = new Point(Math.round(FitObjectArray[i].p.x), Math.round(FitObjectArray[i].p.y));
					theStage.localToGlobal(parentPoint);
					nextx -= parentPoint.x;
					nexty -= parentPoint.y;
				}
				FitObjectArray[i].t.x = nextx+ offsetx;
				FitObjectArray[i].t.y = nexty+ offsety;
				if (FitObjectArray[i].r)
				{
					FitObjectArray[i].r.runfunc();
				}
			}
			getInstance().dispatchEvent(new Event("onStageFited"));
		}
		
		public function stopFit()
		{
			if (fitStarted)
			{
				fitStarted = false;
				theStage.removeEventListener(Event.RESIZE, onStageResize);
			}
		}
		public function startFit()
		{
			if (!fitStarted)
			{
				fitStarted = true;
				theStage.addEventListener(Event.RESIZE, onStageResize);
			}
		}
		
		public function getFitObjectList():Array
		{
			return FitObjectArray;
		}
	}
}