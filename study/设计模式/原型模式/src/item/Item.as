package item 
{
	/**
	 * @author dengswing
	 * @date 2012-2-20 16:26
	 */
	public class Item 
	{
		private var _id:int;	//物品id
		private var _name:String;	// 物品名称
		private var _price:Number;	//价格
		
		/**
		 * 物品
		 */
		public function Item() 
		{
			
			
		}
		
		public function get id():int { return _id; }
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get price():Number { return _price; }
		
		public function set price(value:Number):void 
		{
			_price = value;
		}
		
		public function clone():Item
		{
			var tItem:Item = new Item();
			tItem.id = id;
			tItem.name = name;
			tItem.price = price;
			return tItem;
		}
		
	}

}