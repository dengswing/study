package factory 
{
	import shops.Coat;
	import shops.Trouser;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class ClothesShops extends AbstractFactoryShops
	{
		
		/**
		 * 衣服店(显示上衣、裤子)
		 */
		public function ClothesShops() 
		{
			myCoat = new Coat();
			myTrouser = new Trouser(); 
		}		
	
		override public function showShops():void 
		{
			myCoat.createShops();
			myTrouser.createShops();			
		}
		
	}

}