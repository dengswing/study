package scripts.view
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 恋水泥人-2009-9-26
	 */
	public class CompontView extends Sprite
	{
		protected var model:Object;
		protected var controller:Object;
		
		public function CompontView(aModel:Object, aController:Object = null)
		{
			this.model = aModel;
			this.controller = aController;
		}
		public function add(c:CompontView):void
		{
			throw new IllegalOperationError("add operation not supported");
		}
		public function remove(c:CompontView):void
		{
			throw new IllegalOperationError("remove operation not supported");
		}
		public function getChild(n:int):CompontView
		{
			throw new IllegalOperationError("getChild operation not supported");
			return null;
		}
		public function update(evt:Event = null):void{}
	}
	
}