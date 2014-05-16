package aspirin.media.videoplayer.core {
	import aspirin.media.videoplayer.events.VideoLoaderEvent;
	import aspirin.media.videoplayer.interfaces.IVideoData;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.LocalConnection;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Dictionary;
	import flash.utils.Timer;		

	/**
	 * @author ashi
	 */
	public class VideoLoaderSingle extends EventDispatcher {

		////////////////////////////
		//PLAYER STATES
		////////////////////////////
		
		public static const IDLE : int = 0;
		
		public static const INITIALIZED : int = 1;
		
		public static const PREPARING : int = 3;
		
		public static const PREPARED : int = 4;
		
		public static const STARTED : int = 5;
		
		public static const PAUSED : int = 6;
		
		public static const STOPPED : int = 7;
		
		public static const PLAYBACK_COMPLETED : int = 8;
		
		public static const ERROR : int = 9;
		
		public static const END : int = 10;
		
		//LOADING STATE CONSTs		
		public static const VIDEO_LOAD_STATUS_UNLOADED : int = 0;

		public static const VIDEO_LOAD_STATUS_LOADED : int = 1;
		
		//BUFFERING STATE CONSTs		
		public static const BUFFER_LOAD_STATUS_BUFFERING : int = 0;

		public static const BUFFER_LOAD_STATUS_PLAYING : int = 1;
		
		////////////////////////////
		//STATIC VARS
		////////////////////////////
		
		public static const DEFAULT_VIDEO_WIDTH : int = 320;

		public static const DEFAULT_VIDEO_HEIGHT : int = 240;

		public static const STALL_LIMIT_SHORT : int = 5;

		public static const STALL_LIMIT : int = 15;

		public static const PROGRESS_INTERVAL : int = 250;

		public static const SEEK_TOLERANCE : Number = PROGRESS_INTERVAL / 1000;
		
		////////////////////////////
		//PRIVATE VARS
		////////////////////////////
		
		private var _state : int;
		
		private var playing : Boolean = false;
		
		private var seeking : Boolean = false;
		
		private var bufferState : int;
		
		private var videoContainer : Video;
		
		private var netStream : NetStream;

		private var netConnection : NetConnection;
		
		private var soundTransform : SoundTransform;

		private var videoData : IVideoData;

		private var videoMetaDataLoaded : Boolean = false;

		private var videoMetaData : Object;
		
		private var videoVolume : Number = 0.5;

		private var videoFileStartSeconds : Number = 0;

		private var videoFileStartLocation : int = 0;

		private var lengthInSeconds : Number = -1;

		private var totalBytes : int = -1;

		private var lastTime : Number = 0;

		private var internalVideoWidth : int = -1;

		private var internalVideoHeight : int = -1;

		private var bufferEmptyCount : int = 0;

		private var loaderInterval : Timer;

		private var presumedBytesPerSecond : int = 4000;

		private var stallCount : int = 0;

		private var unstallAttempted : Boolean = false;

		private var keyframeFileLocations : Dictionary;
		
		
		////////////////////////////
		//CONSTRUCTOR
		////////////////////////////
		
		public function VideoLoaderSingle() {
			reset();
		}
		
		////////////////////////////
		//RESET AND RELEASE
		////////////////////////////
		public function reset() : void
		{
			
			videoMetaDataLoaded = false;
			
			playing = false;
			
			seeking = false;
			
			bufferState = -1;
			
			videoFileStartSeconds = 0;
			
			videoFileStartLocation = 0;
			
			lengthInSeconds = -1;
			
			totalBytes = -1;
			
			lastTime = 0;
			
			internalVideoWidth = -1;
			
			internalVideoHeight = -1;
			
			bufferEmptyCount = 0;
			
			stallCount = 0;
			
			videoVolume = 0.5;
			
			unstallAttempted = false;
			
			getNetStream();
			
			setState(IDLE);
		}
		
		public function release() : void
		{
			if(netConnection){
			   netConnection.close();
			   netConnection = null;
			}

			if (netStream)
			{
				netStream.close();
				netStream = null;
			}
			
			if( videoContainer )
			{
				videoContainer.clear();
			}
			
			if( videoData )
			{
				videoData = null;
			    videoMetaData = null;
			}
			
			if( soundTransform )
			{
				//soundTransform = null
			}
			
			
			if(keyframeFileLocations){
				for (var i : String in keyframeFileLocations)
				{
					keyframeFileLocations[i] = null;
				}

				keyframeFileLocations = null;
			}
			
			if (loaderInterval) {
				stopLoaderInterval();
				loaderInterval = null;
			}
			
			gc();
			
			setState(END);
		}
		
		////////////////////////////
		//PUBLIC FUNCTIONS
		////////////////////////////
		
		public function prepare() : void
		{
			getNetStream().play(videoData.url);
			dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PREPARED));
		}
		
		public function prepareAsync() : void {

            getNetStream().play(videoData.url);
            
			bufferState = BUFFER_LOAD_STATUS_BUFFERING;
			dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.BUFFER_EMPTY));
			
			setState(PREPARING);
			dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PREPARING));
		}
		
		public function setDataSouce( vd : IVideoData ) : void {
			if( getState() == IDLE )
			{
				videoData = vd;
				setState(INITIALIZED);
			} else{
				throw( new IllegalOperationError("Can not call 'setVideoData' function when the state is not in 'IDLE'"));
			}
		}
		
		public function getCurrentPosition() : Number {
			if(getState() != ERROR) {
				var time : Number = this.getNetStream().time;
				return Number(Math.min(time, getDuration()));
			}else{
				throw( new IllegalOperationError("Can not call 'getCurrentPosition' function when the state is in 'ERROR'"));
			}
		}
		
		public function getDuration() : Number {
			if(getState() != ERROR || getState() != IDLE) {
				if (lengthInSeconds > 0)
				return lengthInSeconds;
				if (videoData.duration)
				return videoData.duration;

				return (totalBytes / presumedBytesPerSecond);
			}else{
				throw( new IllegalOperationError("Can not call 'getCurrentPosition' function when the state is in 'ERROR, IDLE'"));
			}
		}

		public function getVideoHeight() : int {
			if(getState() != ERROR) {
				return internalVideoHeight;
			}else{
				throw( new IllegalOperationError("Can not call 'getVideoHeight' function when the state is in 'ERROR'"));
			}
		}

		public function getVideoWidth() : int
		{
			if(getState() != ERROR) {
				return internalVideoWidth;
			}else{
				throw( new IllegalOperationError("Can not call 'getVideoWidth' function when the state is in 'ERROR'"));
			}
		}
		
		public function getVideoContainer() : Video
		{
			return videoContainer;
		}
		
		public function isPlaying() : Boolean {
			if(getState() != ERROR) {
				return playing;
			} else {
				throw( new IllegalOperationError("Can not call 'isPlaying' function when the state is in 'ERROR'"));
			}
		}
		
		public function set volume(v : Number) : void {
			videoVolume = Math.max(0, Math.min(1, v));
			soundTransform.volume = videoVolume;
			getNetStream().soundTransform = soundTransform;
		}

		public function get volume() : Number {
			return videoVolume;
		}


		public function setDisplay(video : Video) : void {
			videoContainer = video;
			
			var stream : NetStream = getNetStream();
			video.attachNetStream(stream);
		}
		
		public function getState() : int {
			return _state;
		}
		
		////////////////////////////
		//PUBLIC FUNCTIONS
		////////////////////////////
		public function seekTo(seconds : Number, allowSeekAhead : Boolean = false) : void {
			if( getState() == PREPARED || getState() == STARTED || getState() == PAUSED || getState() == PLAYBACK_COMPLETED ) {
				if(!videoMetaDataLoaded) {
					return;
				}
			
				var duration : Number = getDuration();
				if (duration > 0) {
					seconds = Math.min(seconds, duration - 1);
				}

				var currentTime : Number = currentTime;
				if (currentTime >= seconds && currentTime - seconds <= SEEK_TOLERANCE) {
					return ;
				}
			
				if ( videoMetaData["keyframes"]) {
					var keyTime : Number = findClosestCuePointBefore(seconds);

					var location : int = getFileLocationForKeyFrameTime(keyTime);
				
					location = seconds == 0 ? 0 : location;
					
					if ((location <= bytesLoaded + videoFileStartLocation) && (location >= videoFileStartLocation))
					{
						if(!allowSeekAhead)
						{
							playing = getState() == STARTED || getState() == PLAYBACK_COMPLETED;
							getNetStream().pause();
						}else{
							if( playing )
							{
							getNetStream().resume();	
							}
						}
						getNetStream().seek(keyTime);
					}
					else if (allowSeekAhead)
					{
						stopLoaderInterval();
						seekFromServer(location);

						videoFileStartLocation = location;
						videoFileStartSeconds = keyTime;

						var currentSeconds : Number = allowSeekAhead ? seconds : videoFileStartSeconds;

						dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PLAYING_PROGRESS, {currentTime : currentSeconds, duration : duration, startSeconds : videoFileStartSeconds}));
						dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.BUFFER_EMPTY));

						bufferState = BUFFER_LOAD_STATUS_BUFFERING;

						if (getState() == PLAYBACK_COMPLETED)
						{
							setState(STARTED);
							dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.STARTED));
						}

						seeking = true;
					}
				} else {
					getNetStream().seek(seconds);
				}

			}else{
				throw( new IllegalOperationError("Can not call 'seekTo' function when the state is in 'ERROR, IDLE, INITIALIZED, STOPPED'"));
			}
		}

		public function start() : void {
			if( getState() == PREPARED || getState() == STARTED || getState() == PAUSED || getState() == PLAYBACK_COMPLETED )
			{
				getNetStream().resume();
				
			    setState(STARTED);
			    dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.STARTED));
			}else{
				throw( new IllegalOperationError("Can not call 'seekTo' function when the state is in 'ERROR, IDLE, INITIALIZED, STOPPED'"));
			}
			
		}

		public function pause() : void {
			if( getState() == PREPARED || getState() == STARTED || getState() == PAUSED || getState() == PLAYBACK_COMPLETED ) {
				getNetStream().pause();
			
				setState(PAUSED);
				dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PAUSED));
			} else{
				throw( new IllegalOperationError("Can not call 'seekTo' function when the state is in 'ERROR, IDLE, INITIALIZED, STOPPED'"));
			}
		}
		
		public function stop() : void {
			if( getState() == PREPARED || getState() == STARTED || getState() == INITIALIZED || getState() == PAUSED || getState() == PLAYBACK_COMPLETED ) {
				getNetStream().close();
				
				dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.DOWNLOAD_PROGRESS, {bytesLoaded : bytesLoaded, bytesTotal : totalBytes, duration : getDuration(), startSeconds : videoFileStartSeconds, startPosition : videoFileStartLocation}));
				
				setState(STOPPED);
				dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.STOPPED));
			} else{
				throw( new IllegalOperationError("Can not call 'seekTo' function when the state is in 'ERROR, IDLE, STOPPED'"));
			}
		}

		////////////////////////////
		//PRIVATE FUNCTIONS
		////////////////////////////
		private function setState(the_state : int) : void {
			_state = the_state;
		}
		
		private function seekFromServer(location : int) : void {
			var url : String = getVideoUrl(this.videoData, location);
			getNetStream().play(url);
		}

		private function stopLoaderInterval() : void {
			if (loaderInterval) {
				loaderInterval.removeEventListener(TimerEvent.TIMER, onProgress);
				loaderInterval.stop();
				loaderInterval = null;
			}
		}

		private function startLoaderInterval() : void {
			if (!loaderInterval) {
				loaderInterval = new Timer(PROGRESS_INTERVAL, 0);
				loaderInterval.addEventListener(TimerEvent.TIMER, onProgress);
			}
			loaderInterval.start();
		}

		private function getVideoUrl(videoData : IVideoData, startValue : Number = 0) : String {
			var url : String = videoData.url;
			if (startValue > 0) {
				if(videoMetaDataLoaded) {
					var endString : String = videoData.endParamName != null ? (videoData.endParamName + "=" + totalBytes) : "";
					if (url.indexOf("?") < 0) {
						url = url + "?" + videoData.startParamName + "=" + startValue + (endString == null ? "" : "&" + endString);
					} else {
						url = url + "&" + videoData.startParamName + "=" + startValue + (endString == null ? "" : "&" + endString);
					}
				}
			}
			return url;
		}

		private function findClosestCuePointBefore(seconds : Number) : Number {
			var times : Array = videoMetaData["keyframes"].times;
			return findKeyframeForSeconds(times, seconds, 0, times.length - 1);
		}

		private function findKeyframeForSeconds(kf : Array, targetSeconds : Number, startIndex : int, endIndex : int) : Number {
			if (!targetSeconds) {
				return (0);
			}
			if (startIndex >= endIndex) {
				if (targetSeconds < kf[endIndex]) {
					return (kf[endIndex - 1]);
				}
				return (kf[endIndex]);
			}
			var floor : int = Math.floor((startIndex + endIndex) / 2);
			if (targetSeconds < kf[floor]) {
				return (this.findKeyframeForSeconds(kf, targetSeconds, startIndex, floor));
			}
			else if (targetSeconds > kf[floor]) {
				return (this.findKeyframeForSeconds(kf, targetSeconds, floor + 1, endIndex));
			} else {
				return (kf[floor]);
			}
		}
		
		public function getNetStream() : NetStream {
			if (!netStream) {
				
				netConnection = new NetConnection();
				netConnection.connect(null);
					
				netStream = new NetStream(netConnection);
				netStream.bufferTime = 2;
				
				soundTransform = new SoundTransform();
				soundTransform.volume = videoVolume;
				netStream.soundTransform = soundTransform;

				var client : Object = new Object();
				client["onMetaData"] = onMetaData;
				netStream.client = client;

				netStream.addEventListener(NetStatusEvent.NET_STATUS, onNsStatus);

				if (videoContainer)
				{
					videoContainer.attachNetStream(netStream);
				}

			}

			return netStream;
		}
		
		private function onProgress(evt : Event = null) : void
		{
			dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.DOWNLOAD_PROGRESS, {bytesLoaded : bytesLoaded, bytesTotal : totalBytes, duration : getDuration(), startSeconds : videoFileStartSeconds, startPosition : videoFileStartLocation}));
			
			if (getCurrentPosition() > videoFileStartSeconds && lastTime != videoFileStartSeconds && getState() != PAUSED && bufferState == BUFFER_LOAD_STATUS_PLAYING) {
				dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PLAYING_PROGRESS, {currentTime : getCurrentPosition(), duration : getDuration(), startSeconds : videoFileStartSeconds}));
			}
			
			if (lastTime == getCurrentPosition() && (getState() == STARTED && getTimeDifference(getCurrentPosition(), getDuration()) < 3 && getCurrentPosition() > 1))
			{
				++stallCount;
			}
			else
			{
				lastTime = getCurrentPosition();
				this.stallCount = 0;
				unstallAttempted = false;
			}
			
			if (stallCount > STALL_LIMIT_SHORT && (!unstallAttempted && getTimeDifference(getCurrentPosition(), getDuration()) > 1))
			{
				unstallAttempted = true;
				seekTo(getCurrentPosition() + 0.001);
				lastTime = getCurrentPosition();
			}
			if (stallCount > STALL_LIMIT && getState() != PLAYBACK_COMPLETED) {
				stopLoaderInterval();
				setState(PLAYBACK_COMPLETED);
				dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PLAYBACK_COMPLETED));
			}
		}
		
		private function onMetaData(infoObj : Object) : void
		{
			videoMetaData = infoObj;
			videoMetaDataLoaded = true;
			if (videoMetaData["keyframes"] && videoMetaData["keyframes"].filepositions)
			{
				var keyframes : Object = videoMetaData["keyframes"];
				keyframeFileLocations = new Dictionary();

				for (var i : int = 0; i < keyframes["times"].length; i++)
				{
					keyframeFileLocations[keyframes["times"][i]] = keyframes["filepositions"][i];
				}
			}

			if (infoObj["width"] && infoObj["height"])
			{
				internalVideoWidth = infoObj["width"];
				internalVideoHeight = infoObj["height"];
			}
			if (totalBytes == -1 && infoObj["bytelength"])
			{
				totalBytes = infoObj["bytelength"];
			}
			else if (totalBytes == -1)
			{
				totalBytes = getNetStream().bytesTotal;
			}
			
			if (lengthInSeconds < 0 && infoObj["totalduration"])
			{
				lengthInSeconds = infoObj["totalduration"];
			}
			else if (lengthInSeconds < 0 && infoObj["duration"])
			{
				lengthInSeconds = infoObj["duration"];
			}

			infoObj["duration"] = getDuration();
			dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.META_LOAD, infoObj));

			if (getState() == PREPARING)
			{
				setState(PREPARED);
				dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PREPARED));
			}
		}
		
		private function onNsStatus(evt : NetStatusEvent) : void
		{
			switch (evt.info["code"])
			{
				case "NetStream.Seek.Notify" : 
				   dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.NET_STREAM_STATUS, evt.info));
				   
				case "NetStream.Play.Start" :
					if((getState() == PAUSED || getState() == PREPARED) && seeking)
					{
						getNetStream().pause();
					}
					
					if( seeking )
					{
						seeking = false;
						getNetStream().seek(videoFileStartSeconds);
					}
					startLoaderInterval();
					break;

				case "NetStream.Buffer.Empty" : 
					if (getState() == PLAYBACK_COMPLETED) {
						break;
					}
					else if (!Math.ceil(getDuration()) || Math.ceil(getDuration()) != Math.ceil(getCurrentPosition()))
					{
						++bufferEmptyCount;
						dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.BUFFER_EMPTY));
						bufferState = BUFFER_LOAD_STATUS_BUFFERING;
						break;
					}
					setState(PLAYBACK_COMPLETED);
					dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PLAYBACK_COMPLETED, evt.info));
					dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PLAYING_PROGRESS, {currentTime : getDuration(), duration : getDuration(), startSeconds : videoFileStartSeconds}));
					break;

				case "NetStream.Buffer.Full" : 
				    bufferState = BUFFER_LOAD_STATUS_PLAYING;
				    dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.BUFFER_FULL));
				    
					setState(STARTED);
					dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.STARTED, evt.info));
					break;

				case "NetStream.Buffer.Flush" : 
					if (getDuration() < netStream.bufferTime && getState() != PAUSED) {
						setState(STARTED);
						dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.STARTED, evt.info));
					}
					break;

				case "NetStream.Play.Stop" : 
				   if (getState() != PAUSED && getState() != PLAYBACK_COMPLETED && getTimeDifference(getDuration(), getCurrentPosition()) <= 1)
					{
						stopLoaderInterval();
						setState(PLAYBACK_COMPLETED);
						dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PLAYING_PROGRESS, {currentTime : getDuration(), duration : getDuration(), startSeconds : videoFileStartSeconds}));
						dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.PLAYBACK_COMPLETED, evt.info));
					}
					break;

				case "NetStream.Play.StreamNotFound" : 
				case "NetStream.Play.FileStructureInvalid" :
				    dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.STREAM_NOT_FOUND, evt.info));
					setState(ERROR); 
					dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.ERROR, evt.info));
					break;

				case "NetStream.Seek.InvalidTime" : 
					break;
				default : 
				    startLoaderInterval();
					dispatchEvent(new VideoLoaderEvent(VideoLoaderEvent.NET_STREAM_STATUS, evt.info));
			}
		}
		
		private function get bytesLoaded() : int {
			var total : int = totalBytes - this.videoFileStartLocation;
			return Math.min(total, this.getNetStream().bytesLoaded);
		}
		
		private function getFileLocationForKeyFrameTime(seconds : Number) : int
		{
			return keyframeFileLocations[seconds];
		}
		
		private function getTimeDifference(time1 : Number, time2 : Number) : Number
		{
			return (Math.abs(time1 - time2));
		}
		
		private function gc( ) : void {
			try {
				new LocalConnection().connect("foo");
				new LocalConnection().connect("foo");
			}catch(error : Error) {
			}                       
		}
	}
}
