package {
    import flash.display.Sprite;
 
    import org.papervision3d.cameras.Camera3D;
    import org.papervision3d.objects.Plane;
    import org.papervision3d.scenes.MovieScene3D;
    import org.papervision3d.materials.WireframeMaterial; 
	
    public class Main extends Sprite
    {
        private var _container:Sprite;
        private var _scene:MovieScene3D;
        private var _camera:Camera3D;
 
        private var _plane:Plane;
 
        public function Main()
        {
            // 创建3D舞台的容器
            _container = new Sprite();
            _container.x = 200;
            _container.y = 200;
            addChild( _container );
 
            // 创建3D舞台
            _scene = new MovieScene3D( _container );
 
            // 创建摄像头
            _camera = new Camera3D();
            _camera.z = -500;
            _camera.zoom = 5;
 
            // 创建一个线条材质
            var material:WireframeMaterial = new WireframeMaterial(0x000000);
 
            // 创建一个 128 * 128 的平面                
            _plane = new Plane( material, 128, 128, 2, 2);
 
            // 将平面对象加入到舞台
            _scene.addChild( _plane );
 
            // 绘制3D舞台
            _scene.renderCamera( _camera );
        }
    }
}