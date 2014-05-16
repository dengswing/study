package Classes{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Chessman extends MovieClip{
		private var inc:uint = 0;
		public var bPlayer:Boolean = false;
		public function Chessman(){			
			this.addEventListener(Event.ENTER_FRAME,twinkle);
		}
		public function twinkle(e:Event):void{			
			if(!bPlayer){
				if(inc<15){
					this.alpha = ((inc%5)/5) + .2;
					inc ++;
				}else{				
					this.removeEventListener(Event.ENTER_FRAME,twinkle);
				}
			}
		}
	}
}