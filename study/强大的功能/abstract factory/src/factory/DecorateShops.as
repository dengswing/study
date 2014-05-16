package factory 
{
	import factory.AbstractFactoryShops;
	import shops.Hat;
	import shops.Shoes;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class DecorateShops extends AbstractFactoryShops
	{
		
		/**
		 * 装饰店(显示帽子、鞋)
		 */
		public function DecorateShops() 
		{
			myHat = new Hat();
			myShoes = new Shoes();
		}
		
		override public function showShops():void 
		{
			myHat.createShops();
			myShoes.createShops();
		}
		
	}

}