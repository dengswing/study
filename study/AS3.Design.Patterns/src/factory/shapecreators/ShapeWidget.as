package factory.shapecreators
{
	import flash.display.Sprite;
	// ABSTRACT Class (should be subclassed and not instantiated)
	
	internal class ShapeWidget extends Sprite
	{
		// ABSTRACT Method (should be implemented in subclass)
		internal function drawWidget( ):void { }
		
		internal function setLoc(xLoc:int, yLoc:int):void {
			this.x = xLoc;
			this.y = yLoc;
		}
	}
}