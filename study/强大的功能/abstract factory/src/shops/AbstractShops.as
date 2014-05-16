package shops 
{
	import flash.errors.IllegalOperationError;
	import interfaceI.IShops;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class AbstractShops implements IShops
	{
		/**
		 * 抽象商店类
		 */
		public function AbstractShops() 
		{
			
		}
		
		/**
		 * 创建商品
		 */
		public function createShops():void {
			throw new IllegalOperationError("abstract func createShops can not operation!");
		}
		
	}

}