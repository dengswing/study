package factory.weapons {
	internal class HeroCannonBall extends Projectile {
		override internal function drawProjectile( ):void
		{
			graphics.beginFill(0xFFFF00);
			graphics.drawCircle(0, 0, 5);
			graphics.endFill( );
		}
		
		override internal function arm( ):void {
			nSpeed = -10; // set the speed
		}
	}
}