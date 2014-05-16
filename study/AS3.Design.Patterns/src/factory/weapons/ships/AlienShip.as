package factory.weapons.ships
{
	import flash.display.*;
	import flash.events.*;
	import factory.weapons.AlienWeapon;

	public class AlienShip extends Ship
	{
		private var weapon:AlienWeapon;
		// available projectiles
		private const aProjectiles:Array = [AlienWeapon.CANNON, AlienWeapon.MINE];
		
		override internal function drawShip( ):void
		{
			graphics.beginFill(0xFFFFFF); // white color
			graphics.drawRect(-5, -10, 10, 5);
			graphics.drawRect(-20, -5, 40, 10);
			graphics.drawRect(-20, 5, 10, 5);
			graphics.drawRect(10, 5, 10, 5);
			graphics.endFill( );
		}
		
		override internal function initShip( ):void
		{
			// instantiate the alien projectile creator
			weapon = new AlienWeapon( );
			// attach the doFire( ) method on this object
			// as an ENTER_FRAME handler of the stage
			this.stage.addEventListener(Event.ENTER_FRAME, this.doFire);
		}
		
		protected function doFire(event:Event):void
		{
			// fire randomly (4% chance of firing on each enterframe)
			if (Math.ceil(Math.random( ) * 25) == 1)
			{
				// select random projectile
				var cProjectile:uint = aProjectiles[Math.floor(Math.random( ) * aProjectiles.length)];
				weapon.fire(cProjectile, this.stage, this.x, this.y + 15);
			}
		}
	}
}