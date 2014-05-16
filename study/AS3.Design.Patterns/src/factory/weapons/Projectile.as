package factory.weapons
{
	import flash.display.Sprite;
	import flash.events.*;
	
	// ABSTRACT Class (should be subclassed and not instantiated)
	internal class Projectile extends Sprite
	{
		internal var nSpeed:Number // holds speed of projectile
		// ABSTRACT Method (must be overridden in a subclass)
		internal function drawProjectile( ):void { }
		
		internal function arm( ):void
		{
			// set the default speed for the projectile (5 pixels / fame)
			nSpeed = 5;
		}
		
		internal function release( ):void
		{
			// attach EnterFrame event handler doMoveProjectile( )
			this.addEventListener(Event.ENTER_FRAME, this.doMoveProjectile);
		}
		
		internal function setLoc(xLoc:int, yLoc:int):void
		{
			this.x = xLoc;
			this.y = yLoc;
		}
		
		// update the projectile sprite
		internal function doMoveProjectile(event:Event):void
		{
			this.y += nSpeed; // move the projectile
			// remove projectile if it extends off the top or bottom of the stage
			if ((this.y < 0) || (this.y > this.stage.stageHeight))
			{
				// remove the event listener
				this.removeEventListener(Event.ENTER_FRAME,	this.doMoveProjectile);				
				this.stage.removeChild(this); // remove sprite from stage
			}
		}
	}
}