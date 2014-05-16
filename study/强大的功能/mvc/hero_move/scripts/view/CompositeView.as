package scripts.view
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 恋水泥人-2009-9-26
	 */
	public class  CompositeView extends CompontView
	{
		private var aChildren:Array;
		
		public function CompositeView(aModel:Object, aController:Object = null)
		{
			super(aModel, aController);
			this.aChildren = new Array();
		}
		override public function add(c:CompontView):void
		{
			aChildren.push(c);
		}
		
		override public function update(evt:Event = null):void
		{
			for each(var c:CompontView in aChildren)
			{
				c.update(evt);
			}
		}
	}
	
}