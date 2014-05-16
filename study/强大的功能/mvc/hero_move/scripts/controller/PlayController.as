package scripts.controller
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.events.Event;
	import scripts.interfaceI.*;
	/**
	 * ...
	 * @author 恋水泥人-2009-9-26
	 */
	public class  PlayController implements IMouseInputHandler
	{
		private var model:Iplayer;
		private var ptLoc:Point;
		private var directionFace:String;
		private var newPos:Point;
		private var move:Boolean;
		
		public function PlayController(aModel:Iplayer)
		{
			this.model = aModel;
			this.ptLoc = aModel.getLoc();
			this.newPos = new Point();
		}
		
		public function mousePressHandler(evt:MouseEvent):void
		{
            this.newPos.x = evt.stageX;
			this.newPos.y = evt.stageY;
			
				if (evt.stageX < ptLoc.x -30 && evt.stageY < ptLoc.y -30)
				{
					this.directionFace = "left_back";
					move = true;
					
				}
			    else if (evt.stageX < ptLoc.x-30 && evt.stageY > ptLoc.y+30)
				{
					this.directionFace = "left_font";
					move = true;
					
				}
				else if (evt.stageX > ptLoc.x+30 && evt.stageY < ptLoc.y-30)
				{
					this.directionFace = "right_back";
					move = true;
					
				}
				else if (evt.stageX > ptLoc.x+30 && evt.stageY > ptLoc.y+30)
				{
					this.directionFace = "right_font";
					move = true;
				
				}
				else if (evt.stageX <= ptLoc.x + 30 && evt.stageX >= ptLoc.x -30 && evt.stageY > ptLoc.y + 30)
				{
					this.directionFace = "font";
					move = true;
				}
				else if (evt.stageX <= ptLoc.x + 30 && evt.stageX >= ptLoc.x -30 && evt.stageY < ptLoc.y -30)
				{
					this.directionFace = "back";
					move = true;
				}
				else if (evt.stageY <= ptLoc.y+30 && evt.stageY >= ptLoc.y-30 && evt.stageX < ptLoc.x)
				{
					this.directionFace = "left";
					move = true;
				}
				else if (evt.stageY <= ptLoc.y+30 && evt.stageY >= ptLoc.y-30 && evt.stageX > ptLoc.x)
				{
					this.directionFace = "right";
					move = true;
				}
				
			
		
		}
		
		
		public function enterFrameHandler(evt:Event):void
		{
			//this.ptLoc = this.model.getLoc();
			
			model.movePlayer(directionFace,move,newPos);
		}
	}
	
}