package aspirin.media.videoplayer.interfaces
{
	import flash.media.Video;

	public interface IPlayerSkin
	{
		function getVideoContainer() : Video;

		function setState(state : String) : void;
		
		function setPlayingProgress( startTime : int, playheadTime : int, totalTime : int) : void
		
		function setLoadingProgress(startTime : int, totalTime : int, bytesLoaded : int, bytesTotal : int) : void
	}
}