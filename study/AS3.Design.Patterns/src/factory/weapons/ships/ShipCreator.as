package factory.weapons.ships
{
	import flash.display.Stage;
	public class ShipCreator
	{
		public static const HERO :uint = 0;
		public static const ALIEN :uint = 1;
		
		public function addShip(cShipType:uint, target:Stage, xLoc:int, yLoc:int):void
		{
			var ship:Ship = this.createShip(cShipType);
			ship.drawShip( ); // draw ship
			ship.setLoc(xLoc, yLoc); // set the x and y location
			target.addChild(ship); // add the sprite to the stage
			ship.initShip( ); // initialize ship
		}
		
		private function createShip(cShipType:uint):Ship
		{
			if (cShipType == HERO)
			{
				trace("Creating new hero ship");
				return new HeroShip( );
			} else if (cShipType == ALIEN) {
				trace("Creating new alien ship");
				return new AlienShip( );
			} else {
				throw new Error("Invalid kind of ship specified");
				return null;
			}
		}
	}
}