package factory 
{
	import interfaceI.IFactoryShops;
	/**
	 * ...
	 * @author dengSwing
	 */
	public class ShopsShow
	{
		private var shops:IFactoryShops;
		
		/**
		 * 商店管理
		 * @param	shops
		 */
		public function ShopsShow(shops:IFactoryShops) 
		{
			this.shops = shops;
		}
		
		public function operateShow():void {		
			shops.showShops();
		}
		
	}

}