package aspirin.managers
{
	import aspirin.ui.UIComponentBase;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class StageManager
	{
		protected const SINGLETON_MSG : String = "Manager Singleton already constructed!";

		protected const NULL_ROOT_MSG : String = "Stage manager need a container to hold the ui components!";

		private static var instance : StageManager;

		private static var _root : DisplayObjectContainer;
		
		private static const MIN_WIDTH : int = 240; 
		private static const MIN_HEIGHT : int = 180; 

		public function StageManager(root : DisplayObjectContainer) : void
		{
			if (instance != null)
				throw Error(SINGLETON_MSG);
			instance = this;

			if (root == null)
				throw Error(NULL_ROOT_MSG);
			_root = root;

			_root.stage.scaleMode = StageScaleMode.NO_SCALE;
			_root.stage.align = StageAlign.TOP_LEFT;

			_root.stage.addEventListener(Event.RESIZE, onResize);
		}

		public static function getInstance(root : DisplayObjectContainer = null) : StageManager
		{
			if (instance == null)
				instance = new StageManager(root);
			return instance;
		}

		public static function setChild(displayObject : UIComponentBase, depth : int) : void
		{
			displayObject.depth = depth;
			if( _root ){
			if (_root.contains(displayObject))
			{
				_root.removeChild(displayObject);
			}

			for (var i : int = 0; i < _root.numChildren; i++)
			{
				var child : UIComponentBase = _root.getChildAt(i)as UIComponentBase;
				if (child.depth >= displayObject.depth)
				{
					_root.addChildAt(displayObject, i);
					return ;
				}
			}

			_root.addChild(displayObject);
			
			displayObject.resize(width, height);
			}
			
		}

		public static function get width() : int
		{
			return _root.stage.stageWidth > MIN_WIDTH ?  _root.stage.stageWidth : MIN_WIDTH;
		}

		public static function get height() : int
		{
			return _root.stage.stageHeight > MIN_HEIGHT ?  _root.stage.stageHeight : MIN_HEIGHT;
		}

		public static function get root() : DisplayObjectContainer
		{
			return _root;
		}

		//-----------------------------------------------------------------------------------------
		private function onResize(evt : Event) : void {
			if( _root ) {
				for (var i : int = 0;i < _root.numChildren; i++) {
					var displayObj : UIComponentBase = _root.getChildAt(i) as UIComponentBase;
					displayObj.resize(width, height);
				}
			}
		}
	}
}