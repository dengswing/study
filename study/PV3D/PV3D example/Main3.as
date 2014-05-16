package {
    import flash.display.Sprite; 
	import org.papervision3d.materials.InteractiveBitmapFileMaterial;
	
	import org.papervision3d.cameras.Camera3D;
    import org.papervision3d.scenes.MovieScene3D;
    import org.papervision3d.materials.MaterialsList;
    import org.papervision3d.materials.WireframeMaterial;
    import org.papervision3d.core.proto.MaterialObject3D;
 
    import org.papervision3d.objects.DisplayObject3D;
    import org.papervision3d.objects.Cube;
 
    //--New--
    import org.papervision3d.utils.InteractiveSprite;
    import org.papervision3d.scenes.InteractiveScene3D;
    import org.papervision3d.utils.InteractiveSceneManager;
    import org.papervision3d.events.InteractiveScene3DEvent;
    import org.papervision3d.materials.InteractiveWireframeMaterial;
    import org.papervision3d.materials.InteractiveColorMaterial;
	//import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.objects.Sphere;
	//
    import flash.events.Event;
 
    //[SWF(width='400',height='400',backgroundColor='0xFFFFFF',frameRate='30')]
    public class Main3 extends Sprite
    {
        private var _container:InteractiveSprite;
		//容器
        private var _scene:InteractiveScene3D;
        private var _camera:Camera3D;
		private var _displayObj:DisplayObject3D;
		
		private var _material1:InteractiveWireframeMaterial;
        private var _material2:InteractiveColorMaterial;
 
        private var _interactiveSceneManager:InteractiveSceneManager;
		
        public function Main3()
        {
            // 创建3D舞台的容器
            _container = new InteractiveSprite();
            _container.x = 200;
            _container.y = 200;
            addChild( _container );
 
            // 创建3D舞台
            _scene = new InteractiveScene3D(_container);
 
            // 创建摄像头
            _camera = new Camera3D();
            _camera.z = -500;
            _camera.zoom = 5;
			
			
			
            //--New--
            _interactiveSceneManager = _scene.interactiveSceneManager;
            _interactiveSceneManager.faceLevelMode = true;
 
            _interactiveSceneManager.addEventListener(InteractiveScene3DEvent.OBJECT_OVER, OnObj3DMouseOver);
            _interactiveSceneManager.addEventListener(InteractiveScene3DEvent.OBJECT_OUT, OnObj3DMouseOut);
 
			//
          /*  _material1 = new InteractiveWireframeMaterial(0x000000);
            _material2 = new InteractiveColorMaterial(0xFF0000);
			 
			var materialList:MaterialsList = new MaterialsList(); 
			
			materialList.addMaterial(_material1, "top");
			materialList.addMaterial(_material1, "bottom");
			materialList.addMaterial(_material1, "front");
			materialList.addMaterial(_material1, "back");
			materialList.addMaterial(_material1, "left");
			materialList.addMaterial(_material1, "right");		
			
			_displayObj = new Cube(materialList, 128, 128, 128, 2, 2, 2);*/
			
			var material:InteractiveBitmapFileMaterial = new  InteractiveBitmapFileMaterial("images/texture.jpg");
			//直径80, 高度和宽度的精度为15(圆)
			_displayObj = new Sphere(material,  80, 15, 15);
			//
           
			// 将对象加入到舞台  
			_scene.addChild(_displayObj);		

            // 绘制3D舞台
            _scene.renderCamera( _camera );
 
            this.addEventListener(Event.ENTER_FRAME, OnEnterFrame);
        }
 
        private function OnEnterFrame(event:Event):void{
            //_displayObj.rotationX += 5;
            _displayObj.rotationY += 5;
			//_displayObj.rotationZ += 5;
 
            _scene.renderCamera(_camera);
        }
		
		private function OnObj3DMouseOver(event:InteractiveScene3DEvent):void {
			trace("yy");
			
            event.face3d.material = this._material2;
			
        }
 
        private function OnObj3DMouseOut(event:InteractiveScene3DEvent):void {
			trace("tt");
            event.face3d.material = this._material1;
        }
    }
}