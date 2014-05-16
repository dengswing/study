package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Shiu
	 */
	[SWF(width = 500, height = 400)]
	public class Scene1 extends Sprite
	{
		private var river:Sprite;
		
		private var troops:Vector.<Ball>;
		private var troopVelo:Vector.<Vector2D>;
		
		private var turret:Sprite;
		private var fieldOfView:Sprite;
		
		private var lineOfSight:Vector2D = new Vector2D (0, -300);
		private var sectorOfSight:Number = 	20		//Actually half of sector, in degrees
		private var turretRot:int;
		
		public function Scene1() {
			makeTroops();
			makeRiver();
			makeTurret();
			turret.addEventListener(MouseEvent.MOUSE_DOWN, start);
			function start ():void {
				stage.addEventListener(Event.ENTER_FRAME, move);
			}
		}
		
		private function makeTroops():void {
			troops = new Vector.<Ball>;				//Initiate troops
			troopVelo = new Vector.<Vector2D>;	//initiate velocity
			
			//local variables
			var center:Vector2D = new Vector2D(stage.stageWidth * 0.5, 150);
			var xApart:int = 20; var yApart:int = 15; 
			
			//Locating troops & velocities
			var a:Ball = new Ball; stage.addChild(a); troops.push(a);
			a.x = center.x; a.y = center.y; 
			var aV:Vector2D = new Vector2D(0, 1); troopVelo.push(aV);
			
			for (var i:int = 1; i < 11; i++) {
				var b:Ball = new Ball; stage.addChild(b); troops.push(b);
				b.x = center.x + i * xApart; b.y = center.y - i * yApart;
				var bV:Vector2D = new Vector2D(0, 1); troopVelo.push(bV);
				
				var c:Ball = new Ball; stage.addChild(c); troops.push(c);
				c.x = center.x - i * xApart; c.y = center.y - i * yApart; 
				var cV:Vector2D = new Vector2D(0, 1); troopVelo.push(cV);
			}
		}
		
		private function makeRiver():void {
			river = new Sprite; addChild(river);
			
			//Specify the location & draw graphics of river
			with (river) {
				x = 0; y = 150;	
				graphics.beginFill(0x22BBDD, 0.2);
				graphics.drawRect(0, 0, 500, 50);
				graphics.endFill();
			}
		}
		
		private function makeTurret():void {
			//instantiate, locate, orient turret
			turret = new Sprite; stage.addChild(turret); 
			turret.x = stage.stageWidth * 0.5, 
			turret.y = stage.stageHeight;
			turret.rotation = -90;
			turretRot = 2;				//rotation speed
			
			//Draw turret graphics
			var w:int = 30; var h:int = 10;
			turret.graphics.beginFill(0x9911AA); 
			turret.graphics.lineStyle(2); turret.graphics.moveTo( 0, -h / 2);
			turret.graphics.lineTo(w, -h / 2); turret.graphics.lineTo(w, h / 2); 
			turret.graphics.lineTo(0, h / 2); turret.graphics.lineTo(0, -h / 2);
			turret.graphics.endFill();
			
			//Setting data for field of view's graphics
			var point1:Vector2D = new Vector2D(0, 0); point1.polar(lineOfSight.getMagnitude(), Math2.radianOf(sectorOfSight));
			var point2:Vector2D = new Vector2D(1, 0); point2.setMagnitude(lineOfSight.getMagnitude()/Math.cos(Math2.radianOf(sectorOfSight)))
			var point3:Vector2D = new Vector2D(0, 0); point3.polar(lineOfSight.getMagnitude(), Math2.radianOf(-sectorOfSight));
			
			//instantiate, locate, orient field of view
			fieldOfView = new Sprite; addChild(fieldOfView); 
			fieldOfView.x = turret.x; fieldOfView.y = turret.y; 
			fieldOfView.rotation = -90;
			
			//draw turret's field of view
			fieldOfView.graphics.beginFill(0xff9933, 0.1); 
			fieldOfView.graphics.lineStyle(1); 
			fieldOfView.graphics.moveTo(0, 0); 
			fieldOfView.graphics.lineTo(point1.x, point1.y); 
			fieldOfView.graphics.curveTo(point2.x, point2.y, point3.x, point3.y);
			fieldOfView.graphics.lineTo(0, 0);
			fieldOfView.graphics.endFill();
		}
		
		private function move(e:Event):void {
			behaviourTroops();
			behaviourTurret();
		}
		
		//troops' behaviour
		private function behaviourTroops():void 
		{
			//for each troop
			for (var i:int = 0; i < troops.length; i++) {
				
				//If troop reach bottom of screen, respawn on top of screen
				if (troops[i].y > stage.stageHeight) {
					troops[i].y = 0; troops[i].x = Math.random() * (stage.stageWidth - 100) + 100;
				}
				
				//if wading through river, slow down
				//else normal speed
				if (river.hitTestObject(troops[i])) 	troops[i].y += troopVelo[i].y*0.3;
				else troops[i].y += troopVelo[i].y
				
				//If troop is dead ( alpha < 0.05 ), respawn on top of screen
				if (troops[i].alpha < 0.05) {
					troops[i].y = 0; troops[i].x = Math.random() * (stage.stageWidth - 100) + 100;
					troops[i].col = 0xCCCCCC; troops[i].draw(); troops[i].alpha = 1;
					//stage.removeChild(troops[i]); troops.splice(i, 1);
					//troopVelo.splice(i, 1);
				}
			}
		}
		
		//turret's behaviour
		private function behaviourTurret():void 
		{
			//rotate turret within boundaries of -135 & -45
			if (turret.rotation > -45)		turretRot = -2	
			else if (turret.rotation < -135) turretRot = 2
			
			//shoot closest enemy within sight
			graphics.clear();
			if (enemyWithinSight() != null) {
				
				//closest enemy in sight
				var target:Ball = enemyWithinSight();
				target.col = 0; target.draw(); 	//turns to black & 
				target.alpha -= 0.03;				//health deteriorates
				
				//orient turret towards enemy
				var turret2Target:Vector2D = new Vector2D(target.x - turret.x, target.y - turret.y);
				turret.rotation = Math2.degreeOf(turret2Target.getAngle());
				
				//draw laser path to enemy
				graphics.lineStyle(2);	graphics.moveTo(turret.x, turret.y);	graphics.lineTo(target.x, target.y);
			}
			
			//no enemy within sight, continue scanning
			else { turret.rotation += turretRot }
			//turn field of view and line of sight of turret according to turret's rotation
			fieldOfView.rotation = turret.rotation;		//Scenario2
			lineOfSight.setAngle(Math2.radianOf(turret.rotation));
		}
		
		//return the closest enemy within sight
		private function enemyWithinSight():Ball {
			var closestEnemy:Ball = null;
			var closestDistance:Number = lineOfSight.getMagnitude();
			
			for each (var item:Ball in troops) {
				var turret2Item:Vector2D = new Vector2D(item.x - turret.x, item.y - turret.y);
				
				//check if enemy is within sight
				//1. Within sector of view
				//2. Within range of view
				//3. Closer than current closest enemy
				var c1:Boolean = Math.abs(lineOfSight.angleBetween(turret2Item)) < Math2.radianOf(sectorOfSight) ;
				var c2:Boolean = turret2Item.getMagnitude() < lineOfSight.getMagnitude();
				var c3:Boolean = turret2Item.getMagnitude() < closestDistance;
				
				//if all conditions fulfilled, update closestEnemy
				if (c1 && c2&& c3){
						closestDistance = turret2Item.getMagnitude();
						closestEnemy = item;
				}
			}
			return closestEnemy;
		}
	}

}