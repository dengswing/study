package factory.weapons.ships
{
	import flash.display.Sprite;
	import flash.events.*;
	
	// ABSTRACT Class (should be subclassed and not instantiated)
	internal class Ship extends Sprite
	{
		internal function setLoc(xLoc:int, yLoc:int):void
		{
			this.x = xLoc;
			this.y = yLoc; 
		}
		// ABSTRACT Method (must be overridden in a subclass)
		internal function drawShip( ):void { }
		
		// ABSTRACT Method (must be overridden in a subclass)
		internal function initShip( ):void {}
	}
}