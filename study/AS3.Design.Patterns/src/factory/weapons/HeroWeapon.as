package factory.weapons
{
	public class HeroWeapon extends Weapon
	{
		public static const CANNON :uint = 0;
		override protected function createProjectile(cWeapon:uint):Projectile
		{
			if (cWeapon == CANNON)
			{
				trace("Creating new Hero cannonball");
				return new HeroCannonBall( );
			} else {
				throw new Error("Invalid kind of projectile specified");
				return null;
			}
		}
	}
}