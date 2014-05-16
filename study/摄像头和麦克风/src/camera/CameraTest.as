package camera {
	import flash.display.Sprite;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	
	public class CameraTest extends Sprite
	{
		private var _cam:Camera;
		private var _vid:Video;
		
		public function CameraTest()
		{
			_cam = Camera.getCamera();
			//trace(_cam.name);
			
			Security.showSettings(SecurityPanel.CAMERA);		
			
			_cam.setMode(640, 480, 15);
			_vid = new Video(640, 480);
			_vid.attachCamera(_cam);
			addChild(_vid);
		}
	}
}