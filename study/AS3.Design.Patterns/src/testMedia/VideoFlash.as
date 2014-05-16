package testMedia
{
	//Concrete Media subclass: Video
	class VideoFlash extends AbstractMedia
	{
		public function VideoFlash( )
		{
			//Inherits composition references from superclass
			playMedia = new PlayVideo( );
			recordMedia = new RecordVideo( );
		}
	}
}