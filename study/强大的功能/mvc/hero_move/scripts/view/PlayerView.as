package scripts.view
{
	import flash.events.Event;
	import flash.geom.Point;
	import scripts.interfaceI.*;
	
	/**
	 * ...
	 * @author 恋水泥人-2009-9-26
	 */
	public class PlayerView extends CompontView 
	{
		private var hero:Hero;
		public function PlayerView(aModel:Iplayer, aController:Object = null)
		{
			super(aModel, aController);
			hero = new Hero(); 
			addChild(hero);
			hero.stop();
			this.update();
			
		}
		override public function update(evt:Event = null):void
		{
			
			//trace("gengxin");
			var ptLoc:Point = (model as Iplayer).getLoc();
			this.x = ptLoc.x;
			this.y = ptLoc.y;
			switch((model as Iplayer).getMove())
			{
				case (true):
				    switch((model as Iplayer).getDirection())
					{
						case ("font"):
						    hero.gotoAndStop("walk_font");
						     break;
						case ("back"):
						    hero.gotoAndStop("walk_back");
						     break;
						case ("left"):
						    hero.gotoAndStop("walk_left");
						     break;
						case ("right"):
						    hero.gotoAndStop("walk_right");
						     break;	 
						case ("left_back"):
						    hero.gotoAndStop("walk_lb");
						     break;
						case ("left_font"):
						    hero.gotoAndStop("walk_lf");
						     break;	 
						case ("right_back"):
						    hero.gotoAndStop("walk_rb");
						     break;	 
						case ("right_font"):
						    hero.gotoAndStop("walk_rf");
						     break;	 
							 
					}
				     break;
					
				case (false):
				    switch((model as Iplayer).getDirection())
					{
						case ("font"):
						    hero.gotoAndStop("stand_font");
						     break;
						case ("back"):
						    hero.gotoAndStop("stand_back");
						     break;
						case ("left"):
						    hero.gotoAndStop("stand_left");
						     break;
						case ("right"):
						    hero.gotoAndStop("stand_right");
						     break;	 
						case ("left_back"):
						    hero.gotoAndStop("stand_lb");
						     break;
						case ("left_font"):
						    hero.gotoAndStop("stand_lf");
						     break;	 
						case ("right_back"):
						    hero.gotoAndStop("stand_rb");
						     break;	 
						case ("right_font"):
						    hero.gotoAndStop("stand_rf");
						     break;	 
							 
					}
				     break;
			}
			
		}
	}
	
}