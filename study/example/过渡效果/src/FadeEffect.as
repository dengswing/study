package{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class FadeEffect extends Sprite{
		public var currentFadeOut:int = 00;
		public var currentSquares:int = 01;
		public var pauseTime:int = 01;
		public var tempNum:int = 00;
		public var fading:String = "in";
		public var fadeinTimer:Timer = new Timer(100);
		public var fadeoutTimer:Timer = new Timer(100);
		public var fadeArray:Array = [//top
										[[01,01,01,01,01,01,01,01,01,01],
								 		 [02,02,02,02,02,02,02,02,02,02],
								 		 [03,03,03,03,03,03,03,03,03,03],
								 		 [04,04,04,04,04,04,04,04,04,04],
								 		 [05,05,05,05,05,05,05,05,05,05]],
										//bottom
										[[05,05,05,05,05,05,05,05,05,05],
								 		 [04,04,04,04,04,04,04,04,04,04],
								 		 [03,03,03,03,03,03,03,03,03,03],
								 		 [02,02,02,02,02,02,02,02,02,02],
								 		 [01,01,01,01,01,01,01,01,01,01]],
										//left
										[[01,02,03,04,05,06,07,08,09,10],
								 		 [01,02,03,04,05,06,07,08,09,10],
								 		 [01,02,03,04,05,06,07,08,09,10],
								 		 [01,02,03,04,05,06,07,08,09,10],
								 		 [01,02,03,04,05,06,07,08,09,10]],
										//right
										[[10,09,08,07,06,05,04,03,02,01],
								 		 [10,09,08,07,06,05,04,03,02,01],
								 		 [10,09,08,07,06,05,04,03,02,01],
								 		 [10,09,08,07,06,05,04,03,02,01],
								 		 [10,09,08,07,06,05,04,03,02,01]],
										//top-left
										[[01,02,03,04,05,06,07,08,09,10],
								 		 [02,03,04,05,06,07,08,09,10,11],
								 		 [03,04,05,06,07,08,09,10,11,12],
								 		 [04,05,06,07,08,09,10,11,12,13],
								 		 [05,06,07,08,09,10,11,12,13,14]],
										//top-right
										[[10,09,08,07,06,05,04,03,02,01],
								 		 [11,10,09,08,07,06,05,04,03,02],
								 		 [12,11,10,09,08,07,06,05,04,03],
								 		 [13,12,11,10,09,08,07,06,05,04],
								 		 [14,13,12,11,10,09,08,07,06,05]],
										//bottom-left
										[[05,06,07,08,09,10,11,12,13,14],
								 		 [04,05,06,07,08,09,10,11,12,13],
								 		 [03,04,05,06,07,08,09,10,11,12],
								 		 [02,03,04,05,06,07,08,09,10,11],
								 		 [01,02,03,04,05,06,07,08,09,10]],
										//bottom-right
										[[14,13,12,11,10,09,08,07,06,05],
								 		 [13,12,11,10,09,08,07,06,05,04],
								 		 [12,11,10,09,08,07,06,05,04,03],
								 		 [11,10,09,08,07,06,05,03,03,02],
								 		 [10,09,08,07,06,05,04,03,02,01]]];
		public var squaresArray:Array = new Array();
		public function FadeEffect(){
			fadeinTimer.addEventListener("timer", fadeSquaresInTimer);
			fadeinTimer.start();
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		public function enterFrame(e:Event){
			for each(var s1 in squaresArray){
				tempNum+=1;
				if(fading=="in"){
					if(s1.scaleX<=1){
						s1.scaleX+=0.05;
						s1.scaleY+=0.05;
					}
				}else if(fading=="out"){
					if(tempNum<=currentFadeOut){
						if(s1.scaleX>=0.1){
							s1.scaleX-=0.05;
							s1.scaleY-=0.05;
						}else{
							if(s1.visible == true){
								s1.visible = false;
							}
						}
					}
				}
			}
			tempNum=00;
		}
		public function fadeSquaresInTimer(e:Event){
			fadeSquaresIn(fadeArray[Transitions.val]);
			currentSquares+=1;
		}
		public function fadeSquaresOutTimer(e:Event){
			fadeSquaresOut(fadeArray[Transitions.val]);
			currentSquares+=1;
		}
		public function fadeSquaresIn(s:Array){
			for (var row=0; row<s[0].length; row++) {
				for (var col=0; col<s.length; col++) {
					if(int(s[col][row]) == currentSquares){
						var s1:Sprite = new Square();
						s1.x = 20+(row*40);
						s1.y = 20+(col*40);
						addChild(s1);
						squaresArray.push(s1);
					}
				}
			}
			if(squaresArray.length == (s[0].length * s.length)){
				fadeinTimer.stop();
				addEventListener(Event.ENTER_FRAME, pauseBetween);
			}
		}
		public function fadeSquaresOut(s:Array){
			for (var row=0; row<s[0].length; row++) {
				for (var col=0; col<s.length; col++) {
					if(int(s[col][row]) == currentSquares){
						currentFadeOut+=1;
					}
				}
			}
			if(currentFadeOut == (s[0].length * s.length)){
				fadeoutTimer.stop();
				pauseTime=01;
				addEventListener(Event.ENTER_FRAME, delayedRemove);
			}
		}
		public function pauseBetween(e:Event){
			pauseTime+=1;
			if(pauseTime==60){
				currentSquares=01;
				fading="out";
				fadeoutTimer.addEventListener("timer", fadeSquaresOutTimer);
				fadeoutTimer.start();
				removeEventListener(Event.ENTER_FRAME, pauseBetween);
			}
		}
		public function delayedRemove(e:Event){
			pauseTime+=1;
			if(pauseTime==30){
				//Transitions.transitionAttached = false;
				removeEventListener(Event.ENTER_FRAME, delayedRemove);
				stage.removeChild(this);
			}
		}
	}
}