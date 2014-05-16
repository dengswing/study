package factory.example
{
	import flash.display.Sprite;
	/**
	* Main Class
	* @ purpose: Document class for movie
	*/
	public class Main extends Sprite
	{
		public function Main( )
		{
			// instantiate concrete creators
			var cA:Creator = new CreatorA( );
			var cB:Creator = new CreatorB( );
			// creators operate on different products
			// even though they are doing the same operation
			cA.doStuff( );
			cB.doStuff( );
		}
	}
}
