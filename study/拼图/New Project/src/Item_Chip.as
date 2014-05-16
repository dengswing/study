/**
 * @author yangwen
 * 碎片元素
 * **/
package 
{
	
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;

	public class Item_Chip extends BaseSprite
	{
		private var oldx			:Number;
		private var oldy			:Number;
		private var group			:Array			=	null;
		private var id				:Point			=	new Point;
		private var key				:int			=	-1;
		
		private var apTop			:Array			=	new Array(4);
		private var apRight			:Array			=	new Array(4);
		private var apFeet			:Array			=	new Array(4);
		private var apLeft			:Array			=	new Array(4);
		
		public function Item_Chip()
		{
			super();
			//this.filters			=	[new BevelFilter(2, 30, 0xffffff, 0.6, 0, 0.8), new DropShadowFilter(4, 30, 0, 0.6)]			
		}
		
		override public function removeFromStage(...rest):void
		{
			super.removeFromStage();
			this.group				=	null;
		}
		
		public final function get ID():Point
		{
			return this.id;
		}
		
		public final function set ID(value:Point):void
		{
			this.id					=	value;
		}
		
		public final function get Key():int
		{
			return this.key;
		}
		
		public final function set Key(value:int):void
		{
			this.key				=	value;
		}
		
		/** 连在一起的几个碎片 **/
		public final function get Group():Array
		{
			return this.group;
		}
		
		public final function set Group(value:Array):void
		{
			this.group				=	value;
		}
		
		/** 移动时的偏移距离 **/
		public final function get MoveGap():Point
		{
			return new Point(this.oldx, this.oldy);
		}
		
		public final function set MoveGap(value:Point):void
		{
			this.oldx				=	value.x;
			this.oldy				=	value.y;
		}
		
		public final function get ATop():Array
		{
			return this.apTop;
		}
		
		public final function set ATop(value:Array):void
		{
			this.apTop				=	value;
		}
		
		public final function get ARight():Array
		{
			return this.apRight;
		}
		
		public final function set ARight(value:Array):void
		{
			this.apRight			=	value;
		}
		
		public final function get AFeet():Array
		{
			return this.apFeet;
		}
		
		public final function set AFeet(value:Array):void
		{
			this.apFeet				=	value;
		}
		
		public final function get ALeft():Array
		{
			return this.apLeft;
		}
		
		public final function set ALeft(value:Array):void
		{
			this.apLeft				=	value;
		}
		
		override public function toString():String 
		{
			return ("x:" + x + " y:" + y);
		}
	}
}