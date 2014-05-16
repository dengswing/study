package
{
	
	import flash.display.Sprite;
	import context.ApplicationFacade;
	
	public class HelloPureMvc extends Sprite
	{
		public function HelloPureMvc()
		{
			ApplicationFacade.getInstance().startup(this.stage);
		}
	}
}