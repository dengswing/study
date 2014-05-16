package factory.weapons
{
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	// ABSTRACT Class (should be subclassed and not instantiated)
	public class Weapon
	{
		public function fire(cWeapon:uint, target:Stage, xLoc:int, yLoc:int):void
		{
			var projectile:Projectile = this.createProjectile(cWeapon);
			trace("Firing " + projectile.toString( ));
			
			// draw projectile
			projectile.drawProjectile( );
			
			// set the starting x and y location
			projectile.setLoc(xLoc, yLoc);
			
			// arm the projectile (override the default speed)
			projectile.arm( );
			
			// add the projectile to the display list
			target.addChild(projectile);
			
			// make the projectile move by attaching enterframe event handler
			projectile.release( );			
		}
		
		// ABSTRACT Method (must be overridden in a subclass)
		protected function createProjectile(cWeapon:uint):Projectile
		{
			throw new IllegalOperationError("Abstract method:must be overridden in a subclass");			
			return null;
		}
	}
}