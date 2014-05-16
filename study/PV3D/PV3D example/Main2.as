package {
    import flash.display.Sprite;
    import flash.events.Event;
 
    import org.papervision3d.cameras.Camera3D;
   // import org.papervision3d.scenes.MovieScene3D;
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
 
    //[SWF(width='200',height='200',backgroundColor='0xFFFFFF',frameRate='30')]
    public class Main2 extends Sprite
    {
        private var _container :Sprite;
        private var _scene:InteractiveScene3D; // :MovieScene3D;
        private var _camera :Camera3D;
 
        private var _displayObj:DisplayObject3D;
 
        private var _material1:InteractiveWireframeMaterial;
        private var _material2:InteractiveColorMaterial;
 
        private var _interactiveSceneManager:InteractiveSceneManager;
 
        public function Main2()
        {
            Init3D();
        }
 
        private function Init3D():void {            
            // 创建3D舞台的容器
            _container = new InteractiveSprite();  //new Sprite;
            _container.x = 100;
            _container.y = 100;
            addChild( _container );
 
            // 创建3D舞台
            _scene = new InteractiveScene3D(_container); // new MovieScene3D( _container );
 
            //--New--
            _interactiveSceneManager = _scene.interactiveSceneManager;
            _interactiveSceneManager.faceLevelMode = true;
 
            _interactiveSceneManager.addEventListener(InteractiveScene3DEvent.OBJECT_OVER, OnObj3DMouseOver);
            _interactiveSceneManager.addEventListener(InteractiveScene3DEvent.OBJECT_OUT, OnObj3DMouseOut);
 
            // 创建摄像头
            _camera = new Camera3D();
            _camera.z = -500;
            _camera.zoom = 5;
 
            var materialList:MaterialsList = new MaterialsList();
 
            _material1 = new InteractiveWireframeMaterial(0x000000);
            _material2 = new InteractiveColorMaterial(0xFF0000);
 
            materialList.addMaterial(_material1, "top");
            materialList.addMaterial(_material1, "bottom");
            materialList.addMaterial(_material1, "front");
            materialList.addMaterial(_material1, "back");
            materialList.addMaterial(_material1, "left");
            materialList.addMaterial(_material1, "right");
 
            _displayObj = new Cube(materialList, 128, 128, 128, 2, 2, 2);
 
            _scene.addChild(_displayObj);
 
            this.addEventListener(Event.ENTER_FRAME, OnEnterFrame);
        }
 
        private function OnEnterFrame(event:Event):void {    
            _displayObj.rotationX += 5;
            _displayObj.rotationY += 5;    
 
            _scene.renderCamera(_camera);
        }
 
        private function OnObj3DMouseOver(event:InteractiveScene3DEvent):void{
            event.face3d.material = this._material2;
        }
 
        private function OnObj3DMouseOut(event:InteractiveScene3DEvent):void{
            event.face3d.material = this._material1;
        }
    }
}