package testMedia
{
	//Concrete PlayMedia: Audio
	class PlayAudio implements IPlayMedia
	{
		public function playNow( ):void
		{
			trace("My MP3 is cranking out great music!");
		}
	}
}