package  
{
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.geom.Point;
	
	import gs.TweenMax;
	import org.FitStage;
	import org.CameraContainer;
	
	/**
	* ...
	* @author ezshine
	*/
	public class main extends MovieClip
	{
		private var myStage:FitStage;
		private var cam_container:CameraContainer;
		
		public function main() 
		{
			stop();
			myStage = FitStage.getInstance();
			myStage.setStage(this.stage);
			myStage.addFitObject(selfloadbar, "center",new Point(-selfloadbar.width/2,-selfloadbar.height/2));
			
			loaderInfo.addEventListener(ProgressEvent.PROGRESS,getSelfLoadinfo);
			loaderInfo.addEventListener(Event.COMPLETE, selfLoadComplete);
		}
		
		private function getSelfLoadinfo(e:ProgressEvent):void
		{
			selfloadbar.pernum.text="startup..."+Math.floor(e.bytesLoaded/e.bytesTotal*100).toString()+"%";
		}
		private function selfLoadComplete(e:Event)
		{
			loaderInfo.removeEventListener(Event.COMPLETE, selfLoadComplete);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS,getSelfLoadinfo);
			selfloadbar.pernum.text = "...init...";
			TweenMax.to(selfloadbar, 2, { alpha:0, onComplete:onFinishTween } );
		}
		private function onFinishTween()
		{
			myStage.removeFitObject(selfloadbar);
			setupWorkSpace();
		}
		private function setupWorkSpace()
		{
			cam_container = new CameraContainer(this);
		}
	}
}