package testMedia
{
	import flash.display.Sprite;
	
	public class TestMedia extends Sprite
	{
		public function TestMedia()
		{
			var delVideo:AbstractMedia=new VideoFlash();
			delVideo.doPlayMedia();
			delVideo.doRecordMedia();
			
			var recordMedia:IRecordMedia;		
			recordMedia = new RecordVideo();
			recordMedia.recordNow();
			
			var delAudio:AbstractMedia = new Mp3();			
			delAudio.doPlayMedia();
			delAudio.doRecordMedia();
			
		}
	}
}