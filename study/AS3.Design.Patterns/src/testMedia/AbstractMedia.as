package testMedia
{
	//Abstract class
	class AbstractMedia
	{
		//Composition: Reference to two interfaces
		
		var playMedia:IPlayMedia;
		var recordMedia:IRecordMedia;
		
		public function AbstractMedia( ) { }
		
		public function doPlayMedia( ):void
		{
			//Delegates to PlayMedia
			playMedia.playNow( );
		}
		
		public function doRecordMedia( ):void
		{
			//Delegates to RecordMedia
			recordMedia.recordNow( );
		}
	}
}