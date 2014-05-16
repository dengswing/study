package testMedia
{
	//Concrete RecordMedia: Video
	class RecordVideo implements IRecordMedia
	{
		public function recordNow():void
		{
			trace("I'm recording this tornado live! Holy....crackle, crackle\n");
		}
	}
}