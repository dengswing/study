
package
{
	import flash.text.TextField
  // import flash.display.TextField;
   import flash.display.Sprite;
   import flash.utils.getTimer;
   import flash.events.*;

   public class FPS extends Sprite
   {
      private var fMillisecond:uint;
      private var sMillisecond:uint;
      private var frameCount:Number;
      private var lastMeasure:Number;
      private var output:String;
      private var counterDisplay:TextField;

      public function FPS()
      {
         counterDisplay=new TextField();
		 counterDisplay.selectable = false;
         addChild(counterDisplay);
         fMillisecond=getTimer();
         sMillisecond=fMillisecond+1000;
         frameCount=0;
         output="--";
         lastMeasure=0;
         addEventListener(Event.ENTER_FRAME, onEnterFrameEvent);
      }

      private function onEnterFrameEvent(event:Event):void
      {
         updateCounter();
      }

      private function updateCounter():void
      {
         fMillisecond=getTimer();
         if (fMillisecond>sMillisecond)
         {
            var fps:Number=frameCount/(fMillisecond-sMillisecond+1000)*1000;
            sMillisecond=fMillisecond+1000;
            frameCount=0;
            if (lastMeasure!=fps)
            {
               lastMeasure=fps;
               output="FPS : "+ fps.toFixed(1);
            }
         }
         else
         {
            frameCount+=1;
         }
         counterDisplay.text=output;
      }
   }
}