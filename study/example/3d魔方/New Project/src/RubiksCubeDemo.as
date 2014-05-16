package {
	import gs.TweenLite;
	
	import com.kvc.extend.papervision3d.RubiksCube;
	
	import org.papervision3d.core.proto.CameraObject3D;
	import org.papervision3d.core.proto.LightObject3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.shadematerials.PhongMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.stats.StatsView;
	
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.StageQuality;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;		

	/**
	 * @author Kevin Cao
	 */
	
	[SWF(width="1000", height="600", backgroundColor="#cccccc", frameRate="30")]

	public class RubiksCubeDemo extends BasicView {

		private var rubiksCube : RubiksCube;
		
		[Embed(source="../assets/front.jpg")]
		private var FrontAsset : Class;
		
		[Embed(source="../assets/back.jpg")]
		private var BackAsset : Class;
		
		[Embed(source="../assets/left.jpg")]
		private var LeftAsset : Class;
		
		[Embed(source="../assets/right.jpg")]
		private var RightAsset : Class;
		
		[Embed(source="../assets/top.jpg")]
		private var TopAsset : Class;
		
		[Embed(source="../assets/bottom.jpg")]
		private var BottomAsset : Class;
		
		[Embed(source="../assets/kvc.png")]
		private var PicAsset : Class;
		
		protected var light : LightObject3D;
		
		protected var fxCube : Cube;
		
		private var isDown : Boolean = false;
		
		private var _x : Number;
		private var _y : Number;
		
		private var _vx : Number = 0;
		private var _vy : Number = 0;

		public function RubiksCubeDemo() {
			init();
		}
		
		protected function init() : void {
			camera.z = -1500;
			camera.focus = 200;
			camera.zoom = 2;
			
			light = new LightObject3D();
			light.x = 2000;
			light.y = 3000;
			light.z = -2000;
			
			var frontMat : BitmapMaterial = new BitmapMaterial((new FrontAsset() as Bitmap).bitmapData);
			var backtMat : BitmapMaterial = new BitmapMaterial((new BackAsset() as Bitmap).bitmapData);
			var leftMat : BitmapMaterial = new BitmapMaterial((new LeftAsset() as Bitmap).bitmapData);
			var rightMat : BitmapMaterial = new BitmapMaterial((new RightAsset() as Bitmap).bitmapData);
			var topMat : BitmapMaterial = new BitmapMaterial((new TopAsset() as Bitmap).bitmapData);
			var bottomMat : BitmapMaterial = new BitmapMaterial((new BottomAsset() as Bitmap).bitmapData);
			
			rubiksCube = new RubiksCube(RubiksCube.createMaterialListArray(frontMat, backtMat, leftMat, rightMat, topMat, bottomMat));
					
			fxCube = new Cube(new MaterialsList({all : new PhongMaterial(light, 0xffffff, 0, 10)}), 742, 742, 742, 2, 2, 2);
			fxCube.useOwnContainer = true;
			fxCube.blendMode = BlendMode.ADD;

			rubiksCube.addChild(fxCube);
			
			scene.addChild(rubiksCube);
			
			rubiksCube.addEventListener(RubiksCube.SINGLE_ROTATE_START, rotateStartHanlder);
			rubiksCube.addEventListener(RubiksCube.SINGLE_ROTATE_FINISHED, rotateFinishedHandler);
			
			startRendering();
			
//			addChild(new StatsView(renderer));
			
			var info : TextField = new TextField();
			var tf : TextFormat = new TextFormat("Arial", 12);
			info.defaultTextFormat = tf;
			info.autoSize = TextFieldAutoSize.LEFT;
			info.selectable = false;
			info.text = "Key : (Hold Ctrl + Alt/Option + Key to reverse rotation)\nl : Left\nr : Right\nu : Up\nd : Down\nf : Front\nb : Back\n\n1 : Combo rotate 1\n2 : Combo rotate 2\nm : Change material on left face";
			addChild(info);

			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			
			stage.quality = StageQuality.LOW;
		}

		override protected function onRenderTick(evt : Event = null) : void {
			if(!isDown) {
				if(_vx != 0 || _vy != 0) {
					_vx *= .9;
					_vy *= .9;
					if(Math.abs(_vx) < .5) {
						_vx = 0;
					}
					if(Math.abs(_vy) < .5) {
						_vy = 0;
					}
					rubiksCube.rotationX -= _vy;
					rubiksCube.rotationY -= _vx;
				}
			}
			
			super.onRenderTick();
		}

		private function rotateStartHanlder(event : Event) : void {
			fxCube.visible = false;
		}

		private function rotateFinishedHandler(event : Event) : void {
			fxCube.visible = true;
			fxCube.alpha = 0;
			TweenLite.to(fxCube, 1, {alpha:1});
		}

		private function keyUpHandler(evt : KeyboardEvent) : void {
			var command : String = String.fromCharCode(evt.charCode);
			switch(command) {
				//default command
				case "l":
				case "r":
				case "u":
				case "d":
				case "f":
				case "b":
					if(evt.ctrlKey && evt.altKey) {
						// reverse
						rubiksCube.singleRotate(command + "'");
					} else {
						rubiksCube.singleRotate(command);
					}
					break;
				
				//combo command
				case "1":
					rubiksCube.comboRotate("l-u-b'-d-r'", 2);
					break;
				case "2":
					rubiksCube.comboRotate("r-d'-b-u'-l'", 2);
					break;
					
				//replace material
				case "m":
					rubiksCube.replaceMaterial("back", (new PicAsset() as Bitmap).bitmapData);
					break;
			}
		}

		private function downHandler(event : MouseEvent) : void {
			_x = mouseX;
			_y = mouseY;
			isDown = true;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
		}
		
		private function upHandler(event : MouseEvent) : void {
			isDown = false;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
		}
		
		private function moveHandler(event : MouseEvent) : void {
			_vx = (mouseX - _x) * .4;
			_vy = (mouseY - _y) * .4;
			_x = mouseX;
			_y = mouseY;
			
			rubiksCube.rotationX -= _vy;
			rubiksCube.rotationY -= _vx;
		}
	}
}
