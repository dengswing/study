package factory.weapons.ships
{
	import flash.display.*;
	import factory.weapons.HeroWeapon;
	import flash.events.*;
	internal class HeroShip extends Ship
	{
		private var weapon:HeroWeapon;
		override internal function drawShip( ):void
		{
			graphics.beginFill(0x00FF00); // green color
			graphics.drawRect(-5, -15, 10, 10);
			graphics.drawRect(-12, -5, 24, 10);
			graphics.drawRect(-20, 5, 40, 10);
			graphics.endFill( );
		}
		
		override internal function initShip( ):void
		{
			// instantiate the hero projectile creator
			weapon = new HeroWeapon( );
			// attach the doMoveShip() and doFire( ) methods on this object
			// as MOUSE_MOVE and MOUSE_DOWN handlers of the stage
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.doMoveShip);
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.doFire);
		}
		
		protected function doMoveShip(event:MouseEvent):void
		{
			// set the x coordinate of the sprite to the
			// mouse relative to the stage
			this.x = event.stageX;
			event.updateAfterEvent( ); // process this event first
		}
		
		protected function doFire(event:MouseEvent):void
		{
			weapon.fire(HeroWeapon.CANNON, this.stage, this.x, this.y - 25);
			event.updateAfterEvent( ); // process this event first
		}
	}
}