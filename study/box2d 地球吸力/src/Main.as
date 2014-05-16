package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Joints.*;
	
	public class Main extends Sprite 
	{
		private var world:b2World = new b2World(new b2Vec2(0, 0), true);
		private var worldScale:Number = 30;
		private var planetVector:Vector.<b2Body> = new Vector.<b2Body>();
		private var debrisVector:Vector.<b2Body> = new Vector.<b2Body>();
		private var orbitCanvas:Sprite = new Sprite();
		
		public function Main() 
		{
			addChild(orbitCanvas); //容器
			orbitCanvas.graphics.lineStyle(1,0xff0000); 
			debugDraw();
			addPlanet(180,240,90);
			addPlanet(480,120,45);
			addEventListener(Event.ENTER_FRAME,update);
			stage.addEventListener(MouseEvent.CLICK,createDebris);
		}
		
		private function createDebris(e:MouseEvent):void 
		{
			addBox(mouseX,mouseY,20,20);
		}
		
		private function addPlanet(pX:Number, pY:Number, r:Number):void 
		{
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.restitution = 0;
			fixtureDef.density = 1;
			var circleShape:b2CircleShape = new b2CircleShape(r / worldScale);
			fixtureDef.shape = circleShape;
			
			var bodyDef:b2BodyDef=new b2BodyDef();
			bodyDef.userData=new Sprite();
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
			var thePlanet:b2Body = world.CreateBody(bodyDef);			
			planetVector.push(thePlanet);
			thePlanet.CreateFixture(fixtureDef);
			orbitCanvas.graphics.drawCircle(pX, pY, r * 3);
		}
		
		private function addBox(pX:Number, pY:Number, w:Number, h:Number):void
		{
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(w / worldScale / 2, h / worldScale / 2);
			
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.density = 1;
			fixtureDef.friction = 1;
			fixtureDef.restitution = 0;
			fixtureDef.shape = polygonShape;
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
			
			var box:b2Body = world.CreateBody(bodyDef);
			debrisVector.push(box);
			box.CreateFixture(fixtureDef);
		}
		
		
		private function debugDraw():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(worldScale);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
			debugDraw.SetFillAlpha(0.5);
			world.SetDebugDraw(debugDraw);
		}
		
		private function update(e:Event):void
		{
			world.Step(1 / 30, 10, 10);
			world.ClearForces();
			
			for (var i:int = 0; i < debrisVector.length; i++)
			{
				var debrisPosition:b2Vec2 = debrisVector[i].GetWorldCenter();
				for (var j:int = 0; j < planetVector.length; j++) 
				{
					var planetShape:b2CircleShape = planetVector[j].GetFixtureList().GetShape() as b2CircleShape;
					var planetRadius:Number = planetShape.GetRadius();
					var planetPosition:b2Vec2 = planetVector[j].GetWorldCenter();
					var planetDistance:b2Vec2 = new b2Vec2(0, 0);
					planetDistance.Add(debrisPosition);
					planetDistance.Subtract(planetPosition);
					var finalDistance:Number=planetDistance.Length();
					if (finalDistance<=planetRadius*3) {
						planetDistance.NegativeSelf();
						var vecSum:Number=Math.abs(planetDistance.x)+Math.abs(planetDistance.y);
						planetDistance.Multiply((1/vecSum)*planetRadius/finalDistance);
						debrisVector[i].ApplyForce(planetDistance,debrisVector[i].GetWorldCenter());
					}
				}
			}
			world.DrawDebugData();
		}
	}
}