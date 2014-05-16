package 
{	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import control.Controller;
	import model.ModelLocator;
	import view.View;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Main extends Sprite 
	{
		private var _model:ModelLocator;
        private var _controller:Controller;
        private var _view:View;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_model = new ModelLocator();
            _controller = new Controller(_model);
			
            _view = new View(_model,_controller);
            addChild(_view);
		}
		
	
	}
	
}