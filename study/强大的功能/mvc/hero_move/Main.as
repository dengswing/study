package 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import scripts.controller.PlayController;
	import scripts.interfaceI.*;
	import scripts.model.*;
	import scripts.view.*;
	
	import flash.events.*;
	
	/**
	 * ...
	 * @author 恋水泥人-2009-9-26
	 */
	public class  Main extends Sprite
	{
		
		public function Main()
		{
		    var playerModel:Iplayer = new Player();
			playerModel.setLoc(new Point(200, 200));
			
			var con:IMouseInputHandler = new PlayController(playerModel);
			
			
			var mouseInputView:CompositeView = new MouseInputView(playerModel, con, this.stage);
			
			
			var plView:CompontView = new PlayerView(playerModel);
			
			mouseInputView.add(plView);
			
			addChild(plView);
			//trace("bdddd");
			//var hero:Hero = new Hero();
			//addChild(hero);
			playerModel.addEventListener(Event.CHANGE, mouseInputView.update);
			
		}
	}
	
}