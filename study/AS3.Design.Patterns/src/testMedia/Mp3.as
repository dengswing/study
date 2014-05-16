package testMedia
{
	//Concrete Media subclass: Audio
	public class Mp3 extends AbstractMedia
	{		
		public function Mp3( )
		{
			//Inherits composition references from superclass
			playMedia = new PlayAudio( );
			recordMedia = new RecordAudio( );
		}
	}
}