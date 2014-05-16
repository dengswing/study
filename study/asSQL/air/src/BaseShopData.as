package 
{	
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class BaseShopData 
	{		
		//物品id
		private var _id:int;
		
		//名称
		private var _name:String;		
		
		//物品主类型
		private var _type:int;		
		
		//扩展分类
		private var _iTypeExt:int;
		
		//楼层(在哪卖)
		private var _iFloor:int;
		
		//排序类型(小分类)
		private var _iSort:int;
		
		//价格
		private var _price:int;
		
		//宝石
		private var _stone:int;
		
		//等级
		private var _level:int;
		
		//堆叠类型
		private var _iHandup:int;		
		
		//flash显示类型
		private var _iDisplay:int;
		
		//跳跃属性
		private var _iAnimation:int;
	
		//扩展数据
		private var _iExtData:int;
		
		//道具路径
		private var _iSwf:String;
		
		//出售价格
		private var _salePrice:int;		
		
		//墙纸图片路径
		private var _wallPath:String;
		
		/*'iId' => '1',
		'iName' => 'Bowl',
		'iType' => '5',
		'iTypeExt' => '0',
		'iFloor' => '0',
		'iSort' => '0',
		'iPrice' => '0',
		'iStone' => '0',
		'iLevel' => '1',
		'iHandup' => '4',
		'iDisplay' => '7',
		'iAnimation' => '0',
		'iExtData' => NULL,
		'iSwf' => 'bowl_1',
		*/
	
		/**
		 * 商品数据
		 * @param	id			物品id
		 * @param	name		名称
		 * @param	type		物品主类型
		 * @param	iTypeExt	扩展分类
		 * @param	iFloor		楼层
		 * @param	iSort		排序类型
		 * @param	price		价格
		 * @param	stone		宝石	
		 * @param	level		等级
		 * @param	iHandup		堆叠类型
		 * @param	iDisplay	flash显示类型
		 * @param	iAnimation	跳跃属性
		 * @param	iExtData	扩展数据
		 * @param	iSwf		道具路径
		 */ 
		public function BaseShopData(id:int, name:String, type:int, iTypeExt:int, iFloor:int, iSort:int, price:int, stone:int, level:int, iHandup:int, iDisplay:int, iAnimation:int, iExtData:int, iSwf:String)
		{
			_id = id;
			_name = name;
			_type = type;
			_iTypeExt = iTypeExt;
			_iFloor = iFloor;
			_iSort = iSort;
			_price = price;
			_stone = stone;
			_level = level;
			_iHandup = iHandup;
			_iDisplay = iDisplay;
			_iAnimation = iAnimation;
			_iExtData = iExtData;			
			_iSwf = iSwf + ".swf";			
			_salePrice = Math.floor(_price / 10);		
		}
		
		/**
		 * 物品id
		 */
		public function get id():int { return _id; }
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		/**
		 * 名称
		 */
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		/**
		 * 物品主类型
		 */
		public function get type():int { return _type; }
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
		/**
		 * 扩展分类
		 */
		public function get iTypeExt():int { return _iTypeExt; }
		
		public function set iTypeExt(value:int):void 
		{
			_iTypeExt = value;
		}
		
		/**
		 * 楼层(在哪卖)
		 */
		public function get iFloor():int { return _iFloor; }
		
		public function set iFloor(value:int):void 
		{
			_iFloor = value;
		}
		
		/**
		 * 排序类型(小分类)
		 */
		public function get iSort():int { return _iSort; }
		
		public function set iSort(value:int):void 
		{
			_iSort = value;
		}
		
		/**
		 * 价格
		 */
		public function get price():int { return _price; }
		
		public function set price(value:int):void 
		{
			_price = value;
		}
		
		/**
		 * 宝石
		 */
		public function get stone():int { return _stone; }
		
		public function set stone(value:int):void 
		{
			_stone = value;
		}
		
		/**
		 * 等级
		 */
		public function get level():int { return _level; }
		
		public function set level(value:int):void 
		{
			_level = value;
		}
		
		/**
		 * 堆叠类型
		 */
		public function get iHandup():int { return _iHandup; }
		
		public function set iHandup(value:int):void 
		{
			_iHandup = value;
		}	
		
		/**
		 * flash显示类型
		 */
		public function get iDisplay():int { return _iDisplay; }
		
		public function set iDisplay(value:int):void 
		{
			_iDisplay = value;
		}
		
		/**
		 * 跳跃属性
		 */
		public function get iAnimation():int { return _iAnimation; }
		
		public function set iAnimation(value:int):void 
		{
			_iAnimation = value;
		}
		
		/**
		 * 扩展数据
		 */
		public function get iExtData():int { return _iExtData; }
		
		public function set iExtData(value:int):void 
		{
			_iExtData = value;
		}
		
		/**
		 * 道具路径
		 */
		public function get iSwf():String { return _iSwf; }
		
		public function set iSwf(value:String):void 
		{
			_iSwf = value;
		}
		
		/**
		 * 出售价格
		 */
		public function get salePrice():int { return _salePrice; }
		
		public function set salePrice(value:int):void 
		{
			_salePrice = value;
		}
		
		/**
		 * 墙纸图片路径
		 */
		public function get wallPath():String { return _wallPath; }
		
		public function set wallPath(value:String):void 
		{
			_wallPath = value;
		}
		
	}

}