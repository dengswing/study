package testMedia
{
	//Concrete RecordMedia: Audio
	class RecordAudio implements IRecordMedia
	{
		public function recordNow( ):void
		{
			trace("Rats! I can't record MP3 by itself.\n");
		}
	}
}