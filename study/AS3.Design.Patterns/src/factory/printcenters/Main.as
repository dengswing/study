package factory.printcenters 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Main extends Sprite
	{
		
		public function Main() 
		{
			var pcHighVol:PrintCenter = new HighVolPrintCenter( );
			var pcLowhVol:PrintCenter = new LowVolPrintCenter( );
			pcHighVol.print("LongThesis.doc");
			pcLowhVol.print("ShortVita.doc");
		}
		
	}

}