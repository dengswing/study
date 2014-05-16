package factory 
{
	import flash.errors.IllegalOperationError;
	import interfaceI.IFactoryShops;
	import interfaceI.IShops;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class AbstractFactoryShops implements IFactoryShops
	{
		
		//上衣、帽子、鞋、裤子
		protected var myCoat:IShops, myHat:IShops, myShoes:IShops, myTrouser:IShops;
		
		/**
		 * 抽象工厂商店
		 */
		public function AbstractFactoryShops() 
		{
			
		}
		
		/**
		 * 显示商品
		 */
		public function showShops():void {
			throw new IllegalOperationError("abstract func showShops can not operation!");
		}
		
	}

}