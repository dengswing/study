package{
	
	import flash.display.Sprite;
	import flash.events.Event;
	// Classes used in this example
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	public class HelloWorld extends Sprite{
		
		public var m_world:b2World;
		public var m_iterations:int = 10;
		public var m_timeStep:Number = 1.0/30.0;
			
		public function HelloWorld(){
			
			
			
			// 为主事件增加循环事件
			addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
			
			
			
			//定义比例，Box2D中是一米为长度单位，1m=30像素 
			// Creat world AABB
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(1.0, 1.0);
			worldAABB.upperBound.Set(20.0, 20.0);  //二个点的坐标,定义世界的范围   (########黄色框的范围########)
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0, 20);
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Construct a world object
			m_world = new b2World(worldAABB, gravity, doSleep);
			
			// set debug draw
			var dbgDraw:b2DebugDraw = new b2DebugDraw();
			var dbgSprite:Sprite = new Sprite();
			addChild(dbgSprite);
			dbgDraw.m_sprite = dbgSprite;
			dbgDraw.m_drawScale = 30.0;
			dbgDraw.m_fillAlpha = 0.0;
			dbgDraw.m_lineThickness = 5.0;
			dbgDraw.m_drawFlags = 0xFFFFFFFF;
			m_world.SetDebugDraw(dbgDraw);
			
			
			// Vars used to create bodies
			var body:b2Body;
			var bodyDef:b2BodyDef;
			var boxDef:b2PolygonDef;
			var circleDef:b2CircleDef;
			
			
			
			// Add ground body(框)
			bodyDef = new b2BodyDef();
			//bodyDef.position.Set(15, 19);
			bodyDef.position.Set(10, 15);//设置刚性物体集的坐标(是以刚性物休的中心位置为(0,0)坐标).(*****确定刚性物体坐标****)
			bodyDef.angle = 0;         //旋转角度
			
			boxDef = new b2PolygonDef();
			boxDef.SetAsBox(6, 1);       //刚性物体的长度和宽度:真实像素是(值*30像素)(*****确定刚性物体长宽****)(########淡紫色区域########)
			boxDef.friction = 0;         //这用来计算两个对象之间的摩擦，你可以在0.0-1.0之间调整它们
			boxDef.restitution = 0.2;    //碰撞弹性系数
			boxDef.density = 0;          //密度,在碰撞的等式中我们使用密度*面积=质量，密度如果是0或者null,将会是一个静止的对象。
            /*
			circleDef = new b2CircleDef();
			circleDef.radius = 5;
			circleDef.restitution = 0.2
			*/
			
			// Add sprite to body userData(实体)
			bodyDef.userData = new PhysGround();                //(*****定义刚性物体:形状实例****)
			//bodyDef.userData = new PhysCircle();
			bodyDef.userData.width = 30 * 2 * 6;                //(*****确定刚性物体实例的宽****)
			bodyDef.userData.height = 30 * 2 * 0.5;             //(*****确定刚性物体实例的宽****)  (########红色方块宽和高度########)
			addChild(bodyDef.userData);                         //(*****显示刚性物体实例对象****)
			
			body = m_world.CreateBody(bodyDef);                //将环境空间添加到双链表中,并返回这个环境空间对象
			body.CreateShape(boxDef);                           //给这个环境内添加可运动的实例对象
			
			
			//body.CreateShape(circleDef);
			body.SetMassFromShapes();
			
			// Add some objects
			for (var i:int = 1; i < 10; i++){
				bodyDef = new b2BodyDef();                  //每次要定义一个新的,这样就定义的很多个对象.
				bodyDef.position.x = Math.random() * 15 + 5;
				bodyDef.position.y = Math.random() * 10;
				var rX:Number = Math.random() + 0.5;
				var rY:Number = Math.random() + 0.5;
				// Box
				if (Math.random() < 0.5){
					
					boxDef = new b2PolygonDef();
					boxDef.SetAsBox(rX, rY);
					boxDef.density = 1.0;
					boxDef.friction = 0.5;
					boxDef.restitution = 0.2;

					bodyDef.userData = new PhysBox();
					bodyDef.userData.width = rX * 2 * 30; 
					bodyDef.userData.height = rY * 2 * 30; 
					
					body = m_world.CreateBody(bodyDef);      //将b2Body对象添加到双链接,列表中,并且返回这个对象
					body.CreateShape(boxDef);              //给这个物体对象增加物理学特性(是方块,还是圆形)
				} 
				// Circle
				else {
					circleDef = new b2CircleDef();
					circleDef.radius = rX;
					circleDef.density = 1;
					circleDef.friction = 0.5;
					circleDef.restitution = 0.2
					bodyDef.userData = new PhysCircle();
					bodyDef.userData.width = rX * 2 * 30; 
					bodyDef.userData.height = rX * 2 * 30; 
					body = m_world.CreateBody(bodyDef);
					body.CreateShape(circleDef);
				}
				body.SetMassFromShapes();
				addChild(bodyDef.userData);
			}
			
		}
		
		public function Update(e:Event):void{
			
			m_world.Step(m_timeStep, m_iterations);
			
			// Go through body list and update sprite positions/rotations
			//将bb实体形状坐标位置实时跟随着外框结构
			for (var bb:b2Body = m_world.m_bodyList; bb; bb = bb.m_next){
				if (bb.m_userData is Sprite){
					bb.m_userData.x = bb.GetPosition().x * 30;
					bb.m_userData.y = bb.GetPosition().y * 30;
					bb.m_userData.rotation = bb.GetAngle() * (180/Math.PI);
				}
			}
			
		}
		
		
		
	}

}