package  
{ 
      import Box2D.Collision.Shapes.*; 
       import Box2D.Collision.*; 
       import Box2D.Common.*; 
       import Box2D.Common.Math.*; 
       import Box2D.Dynamics.*; 
        
       import flash.display.Sprite; 
       import flash.display.StageScaleMode; 
       import flash.display.StageAlign; 
       import flash.events.Event; 
       import flash.events.MouseEvent; 
       /** 
       * ... 
       * @author ywxgood 
       * Blog:http://space.flash8.net/space/?628770 
       */ 
       [SWF(backgroundColor="0x333333",width="550",height="400",frameRate="30")] 
       public class ClickBox2DNew extends Sprite 
       { 
              private var world:b2World; 
              private var physScale:Number = 30.0; 
              private var m_timeStep:Number = 1.0 / 30.0; 
              private var m_iteration:int = 10; 
               
              private var body:b2Body; 
              private var bodyDef:b2BodyDef; 
              private var boxShape:b2PolygonDef; 
              private var circleShape:b2CircleDef; 
               
              public function ClickBox2DNew() 
              { 
                     stage.align = StageAlign.TOP_LEFT; 
                     stage.scaleMode = StageScaleMode.NO_SCALE; 
                     init(); 
              } 
               
              private function init():void 
              { 
                     addEventListener(Event.ENTER_FRAME, onFrame); 
                     addEventListener(MouseEvent.MOUSE_DOWN, onDown); 
                      
                     var worldAABB:b2AABB = new b2AABB(); 
                     worldAABB.lowerBound.Set( -100.0, -100.0); 
                     worldAABB.upperBound.Set(100.0, 100.0); 
                     var gravity:b2Vec2 = new b2Vec2(0.0, 10.0); 
                     var doSleep:Boolean = true; 
                     world = new b2World(worldAABB, gravity, doSleep); 
                      
                     //创建地面 
                     createBox(550 / 2, 390,0, 275, 10, true); 
                     //左右挡板 
                     createBox(0,400/2,0,10,200,true); 
                     createBox(550, 400 / 2,0, 10, 200, true); 
                     //障碍物 
                     createBox(Math.random() * 250 + 100, Math.random() * 150 + 100, Math.random()*360,Math.random() * 50, Math.random() * 50, true); 
                     createBox(Math.random() * 250 + 100, Math.random() * 150 + 100, Math.random()*360,Math.random() * 50, Math.random() * 50, true); 

              } 
               
              private function onFrame(e:Event):void 
              { 
                     world.Step(m_timeStep, m_iteration); 
                     for (var b:b2Body = world.m_bodyList; b;b=b.m_next ) 
                     { 
                            if (b.m_userData is Sprite) 
                            { 
                                   b.m_userData.x = b.GetPosition().x * physScale; 
                                   b.m_userData.y = b.GetPosition().y * physScale; 
                                   b.m_userData.rotation = b.GetAngle() * 180 / Math.PI; 
                            } 
                     } 
              } 
               
              private function onDown(e:MouseEvent):void 
              { 
                      
                     var tempNum:Number = Math.random(); 
                     var halfWidth:Number = 10 + Math.random() * 50; 
                     var halfHeight:Number = 10 + Math.random() * 50; 
                     var xPos:Number = 100+Math.random() * (stage.stageWidth-100); 
                     var yPos:Number = 0; 
                     var radius:Number = 10 + Math.random() * 30; 
                     var angle:Number = Math.random() * 360; 
                     if (tempNum>.5) 
                     { 
                            createBox(xPos,yPos,angle,halfWidth,halfHeight,false); 
                     } 
                     else 
                     { 
                            createCircle(xPos,yPos,radius); 
                     } 
              } 
               
              private function createCircle(xPos:Number,yPos:Number,radius:Number):void 
              { 
                     circleShape = new b2CircleDef(); 
                     circleShape.density = 7; 
                     circleShape.friction = 0.3; 
                     circleShape.restitution = 0.4; 
                     circleShape.radius = radius / physScale; 
                     bodyDef = new b2BodyDef(); 
                     bodyDef.userData = new Ball(radius, 0xffffff * Math.random()); 
                     //bodyDef.userData.width = radius * 2; 
                     //bodyDef.userData.height = radius * 2; 
                     bodyDef.position.Set(xPos / physScale, yPos / physScale); 
                     body = world.CreateBody(bodyDef); 
                     body.CreateShape(circleShape); 
                     body.SetMassFromShapes(); 
                     addChild(bodyDef.userData); 
              } 
               
              private function createBox(xPos:Number,yPos:Number,angle:Number,halfWidth:Number,halfHeight:Number,isStatic:Boolean):void 
              { 
                     boxShape = new b2PolygonDef(); 
                     if (isStatic) 
                     { 
                            boxShape.density = 0.0; //静止,固定
                     } 
                     else 
                     { 
                            boxShape.density = 2.0; //可活动
                     } 
                      
                     boxShape.friction = 0.3; 
                     boxShape.restitution = 0.4; 
                     boxShape.SetAsBox(halfWidth / physScale, halfHeight / physScale); 
                     bodyDef = new b2BodyDef(); 
                     bodyDef.angle = angle; 
                     bodyDef.userData = new Box(halfWidth * 2, halfHeight * 2, 0xffffff * Math.random()); 
                     bodyDef.position.Set(xPos / physScale, yPos/physScale); 
                     body = world.CreateBody(bodyDef); 
                     body.CreateShape(boxShape); 
                     body.SetMassFromShapes(); 
                     addChild(bodyDef.userData); 
              } 
       } 
        
}
