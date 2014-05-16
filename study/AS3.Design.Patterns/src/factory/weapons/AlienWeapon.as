package factory.weapons
{
	public class AlienWeapon extends Weapon
	{
		public static const CANNON :uint = 0;
		public static const MINE :uint = 1;
		override protected function createProjectile(cWeapon:uint):Projectile
		{
			if (cWeapon == CANNON)
			{
				trace("Creating new alien cannonball");
				return new AlienCannonBall( );
			} else if (cWeapon == MINE) {
				trace("Creating new alien mine");
				return new AlienMine( );
			} else {
				throw new Error("Invalid kind of projectile specified");
				return null;
			}
		}
	}
}