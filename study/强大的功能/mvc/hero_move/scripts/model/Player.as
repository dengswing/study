package scripts.model
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import scripts.interfaceI.*;
	
	/**
	 * ...
	 * @author 恋水泥人-2009-9-26
	 */
	public class  Player extends EventDispatcher implements Iplayer
	{
		
		protected var ptLoc:Point;
		protected var newPos:Point;
		protected var moveState:Boolean = false;
		protected var direction:String = new String();
		
		
		public function Player()
		{
			ptLoc = new Point();			
		}
		
		public function setMove(ms:Boolean):void
		{
			moveState = ms;
			
			if (!ms)
				dispatchEvent(new Event(Event.DEACTIVATE));
		}
		
		public function getMove():Boolean
		{
			return moveState;
		}
		
		public function setLoc(pt:Point):void
		{
			ptLoc = pt;
		}
		public function getLoc():Point
		{
			return ptLoc;
		}
		
		public function setDirection(de:String):void
		{
			direction = de;
		}
		public function getDirection():String
		{
			return direction;
		}
		
		public function movePlayer(st:String,mo:Boolean,pt:Point):void
		{
			this.setMove(true);
			if (mo == true)
			{
			//trace("jieshou");
			switch(st)
			{
				case("font"):
				   if (ptLoc.y <= pt.y )
				   {
				   ptLoc.y += 3;
				   this.setDirection("font");
				   this.update();
				   }
				   else
				   {
					   mo = false;
					   this.setMove(false);
					   this.update();
				   }
				   break;
				case("back"):
				   if (ptLoc.y >= pt.y )
				   {
				   ptLoc.y -= 3;
				   this.setDirection("back");
				   this.update();
				   }
				   else
				   {
					   mo = false;
					   this.setMove(false);
					   this.update();
				   }
				   break;
				case("left"):
				   if (ptLoc.x >= pt.x )
				   {
				   ptLoc.x -= 5;
				   this.setDirection("left");
				   this.update();
				   }
				   else
				   {
					   mo = false;
					   this.setMove(false);
					   this.update();
				   }
				   //ptLoc.y -= 3;
				   break;
				case("right"):
				   if (ptLoc.x <= pt.x )
				   {
				   ptLoc.x += 5;
				   this.setDirection("right");
				   this.update();
				   }
				   else
				   {
					   mo = false;
					   this.setMove(false);
					   this.update();
				   }
				   //ptLoc.y -= 3;
				   break;
				case("left_back"):
				   if (ptLoc.x >= pt.x && ptLoc.y >= pt.y )
				   {
				   ptLoc.x -= 5;
				   ptLoc.y -= 3;
				   this.setDirection("left_back");
				   this.update();
				   }
				   else
				   {
					   mo = false;
					   this.setMove(false);
					   this.update();
				   }
				   break;   
				case("left_font"):
				   if (ptLoc.x >= pt.x && ptLoc.y <= pt.y )
				   {
				   ptLoc.x -= 5;
				   ptLoc.y += 3;
				   this.setDirection("left_font");
				   this.update();
				   }
				   else
				   {
					   mo = false;
					   this.setMove(false);
					   this.update();
				   }
				   break;
				case("right_back"):
				   if (ptLoc.x <= pt.x && ptLoc.y >= pt.y )
				   {
				   ptLoc.x += 5;
				   ptLoc.y -= 3;
				   this.setDirection("right_back");
				   this.update();
				   }
				   else
				   {
					   mo = false;
					   this.setMove(false);
					   this.update();
				   }
				   break;   
				case("right_font"):
				   if (ptLoc.x <= pt.x && ptLoc.y <= pt.y )
				   {
				   ptLoc.x += 5;
				   ptLoc.y += 3;
				   this.setDirection("right_font");
				   this.update();
				   }
				   else
				   {
					   mo = false;
					   this.setMove(false);
					   this.update();
				   }
				   break;   				   				   
			}
			}
			//this.update();
			trace(ptLoc.y);
		}

		protected function update():void
		{
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}
	
}