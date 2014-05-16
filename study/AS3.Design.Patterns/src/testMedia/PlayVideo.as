package testMedia
{ 
	//Concrete PlayMedia: Video
	class PlayVideo implements IPlayMedia
	{
		public function playNow( ):void
		{
			trace("Playing my video. Look at that!");
		}
	}
}