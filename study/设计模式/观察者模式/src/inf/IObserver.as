package inf 
{
	import observable.Beauty;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public interface IObserver 
	{
		function update(beauty:Beauty):void;
	}
	
}