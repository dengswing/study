package aspirin.media.videoplayer.events {
	import flash.events.Event;
	
	public class VideoLoaderEvent extends Event
	{
		public static const UNLOAD_VIDEO : String = "unload_video";
		
		public static const BUFFER_EMPTY : String = "buffer_empty";
		
		public static const BUFFER_FULL : String = "buffer_full";
		
		public static const LOAD_NEW_VIDEO : String = "load_new_video";
		
		public static const NET_STREAM_STATUS : String = "net_stream_status";
		
		public static const STREAM_NOT_FOUND : String = "stream_not_found";
		
		public static const PLAYING_PROGRESS : String = "playing_progress";
		
		public static const DOWNLOAD_PROGRESS : String = "download_progress";
		
		public static const PREPARING : String = "preparing";
		
		public static const PREPARED : String = "prepared";
		
		public static const STARTED : String = "started";
		
		public static const PAUSED : String = "paused";
		
		public static const STOPPED : String = "stopped";
		
		public static const PLAYBACK_COMPLETED : String = "playback_completed";
		
		public static const END : String = "end";
		
		public static const ERROR : String = "error";
		
		public static const META_LOAD : String = "meta_load";
		
		public function VideoLoaderEvent(type : String, data : Object = null, bubbles : Boolean = false, cancelable : Boolean = true)
		{
			super(type, bubbles, cancelable);
			
			_data = data;
		}
		
		private var _data : Object;
		
		public function set data( obj : Object) : void
		{
			_data = obj;
		}
		
		public function get data() : Object
		{
			return _data;
		}

	}
}