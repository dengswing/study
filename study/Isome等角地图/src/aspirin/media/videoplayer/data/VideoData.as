package aspirin.media.videoplayer.data {
	import aspirin.media.videoplayer.interfaces.IVideoData;	

	public class VideoData implements IVideoData {

		public function VideoData(url : String, duration : Number, startParamName : String = "start", endParamName : String = null) {
			this.url = url;
			
			this.duration = duration;
			
			this.startParamName = startParamName;
			
			this.endParamName = endParamName;
		}

		private var _url : String;

		public function set url( url : String) : void {
			_url = url;
		}

		public function get url() : String {
			return _url;
		}

		private var _duration : Number;

		public function set duration( duration : Number) : void {
			_duration = duration;
		}

		public function get duration() : Number {
			return _duration;
		}

		private var _startParamName : String;

		public function set startParamName( name : String) : void {
			_startParamName = name;
		}

		public function get startParamName() : String {
			return _startParamName;
		}

		private var _endParamName : String;

		public function set endParamName( name : String) : void {
			_endParamName = name;
		}

		public function get endParamName() : String {
			return _endParamName;
		}

	}
}