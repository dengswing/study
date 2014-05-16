package util {
	import flash.display.MovieClip;
	public class Clear extends Object {

		public function Clear()
		{
		}
		
		/**
		 *	@public
		 *	@param	object	需要清理的 DisplayObject
		 *	@param	form		从第几个 children 开始删除
		 *	@default    0
		 *	@param	to			删到第几个 children 为止
		 *	@default    0
		 *	
		 *	清理 object 中的 childrens
		 */
		public static function removeChildAll(object:*, from:int = 0, to:int = 0):void
		{
			if (object && object.numChildren > 0)
			{
				var _num:int = object.numChildren;
				if (to == 0)
				{
					to = _num-1;
				}
				for (var i:int = to; i >= from; i--)
				{
					var _removeObj = object.getChildAt(i);
					if (_removeObj is MovieClip) _removeObj.stop();
					object.removeChild(_removeObj);
					_removeObj = null;
				}
			}
		}
		
		/**
		 *	@public
		 *	@param	object	 需要删除的 DisplayObject
		 *	
		 *	将 object 从场景中删除
		 */
		public static function removeChild(object:*):void
		{
			if (object && object.parent)
			{
				if (object is MovieClip) object.stop();
				object.parent.removeChild(object);
				object = null;
			}
		}
		
		/**
		 *	@public
		 *	@param	object		删除事件的对象
		 *	@param	evt	 			事件
		 *	@param	fun				事件的函数
		 *	
		 *	清除对象的事件
		 */
		public static function removeEvent(object:*, evt:String, fun:Function):void
		{
			if (object && object.hasEventListener(evt))
			{
				object.removeEventListener(evt, fun);
			}
		}
		
		
	}

}

