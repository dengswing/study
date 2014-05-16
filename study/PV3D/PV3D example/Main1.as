package {
    import flash.display.Sprite; 
	
	// Import Papervision3D
	import org.papervision3d.cameras.*;
	import org.papervision3d.scenes.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.special.*;
	import org.papervision3d.objects.primitives.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.materials.special.*;
	import org.papervision3d.materials.shaders.*;
	import org.papervision3d.materials.utils.*;
	import org.papervision3d.lights.*;
	import org.papervision3d.render.*;
	import org.papervision3d.view.*;
	import org.papervision3d.events.*;
	import org.papervision3d.core.utils.*;
	import org.papervision3d.core.utils.virtualmouse.VirtualMouse;
	
	//
    import flash.events.Event;
 
    //[SWF(width='400',height='400',backgroundColor='0xFFFFFF',frameRate='30')]
    public class Main1 extends Sprite
    {
        private var _container :Sprite;
        private var _scene :MovieScene3D;
        private var _camera :Camera3D;
		private var _displayObj:DisplayObject3D;
		
        public function Main1()
        {
            // 创建3D舞台的容器
            _container = new Sprite;
            _container.x = 200;
            _container.y = 200;
            addChild( _container );
 
            // 创建3D舞台
            _scene = new MovieScene3D( _container );
 
            // 创建摄像头
            _camera = new Camera3D();
            _camera.z = -500;
            _camera.zoom = 5;
 
			//
            // 创建一个线条材质(线条)
            //var material:WireframeMaterial = new WireframeMaterial(0x000000);	
			//var material:ColorMaterial = new ColorMaterial(0x000000);
			var material:BitmapFileMaterial = new BitmapFileMaterial("images/texture.jpg");
			//直径80, 高度和宽度的精度为15(圆)
			_displayObj = new Sphere(material,  80, 15, 15);
			
            // 创建一个 128 * 128 的平面 (平面)               
            //_displayObj = new Plane( material, 128, 128, 2, 2);	
			
			//_displayObj = new Cylinder(material, 40, 100, 10, 10, 1);//锥形体			
			//_displayObj = new Cylinder(material, 40, 100, 10, 10, 40);//圆柱体
			//
			 
			/*var materialList:MaterialsList = new MaterialsList(); 
			materialList.addMaterial(new WireframeMaterial(0xFF0000), "top");
			materialList.addMaterial(new WireframeMaterial(0xFFFF00), "bottom");
			materialList.addMaterial(new WireframeMaterial(0x0000FF), "front");
			materialList.addMaterial(new WireframeMaterial(0x00FF00), "back");
			materialList.addMaterial(new WireframeMaterial(0x000000), "left");
			materialList.addMaterial(new WireframeMaterial(0xCC00CC), "right");			 
			_displayObj = new Cube(materialList, 128, 128, 128, 2, 2, 2);
			*/
		
           
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
    }
}