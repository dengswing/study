package aspirin.media.videoplayer.events {
	import flash.events.Event;
	
	public class PlayerSkinEvent extends Event
	{
		public static const PLAY : String = "play";
		
		public static const PAUSE : String = "pause";
		
		public static const START_SEEK : String = "start_seek";
		
		public static const END_SEEK : String = "end_seek";
		
		public static const SET_VOLUME : String = "set_volume";
		
		public static const EXIT_FULL_SCREEN : String = "exit_full_screen";
		
		public static const ENTER_FULL_SCREEN : String = "enter_full_screen";
		
		public function PlayerSkinEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type, bubbles, cancelable );
		}
		
		private var _time : Number;
		public function set time( seekTime : Number ) : void
		{
			_time = seekTime;
		}
		
		public function get time() : Number
		{
			return _time;
		}
		
		private var _volume : Number;
		public function set volume( volume : Number ) : void
		{
			_volume = volume;
		}
		
		public function get volume() : Number
		{
			return _volume;
		}

	}
}