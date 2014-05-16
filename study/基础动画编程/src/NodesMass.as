package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF (backgroundColor = 0x666666)]
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class NodesMass extends NodeGarden
	{
		
		public function NodesMass() 
		{
			super();
		}
		
		override protected function init():void 
		{
			springAmount = .0025;
			
			particles = new Array(); 
			
			for (var i:uint = 0; i < numParticles; i++) { 
				var size:Number = Math.random() * 10 + 2;
				var particle:Ball = new Ball(size, 0xffffff); 
				particle.x = Math.random() * stage.stageWidth; 
				particle.y = Math.random() * stage.stageHeight;
				particle.vx = Math.random() * 6 - 3; 
				particle.vy = Math.random() * 6 - 3;
				particle.mass = size; 
				addChild(particle); 
				particles.push(particle);
			} 
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame); 
		}
		
		override protected function spring(partA:Ball, partB:Ball):void {
			var dx:Number = partB.x - partA.x; 
			var dy:Number = partB.y - partA.y; 
			var dist:Number = Math.sqrt(dx * dx + dy * dy); 
			
			if (dist < minDist) { 				
				graphics.lineStyle(1, 0xffffff, 1 - dist / minDist); 
				graphics.moveTo(partA.x, partA.y); 
				graphics.lineTo(partB.x, partB.y);
				
				var ax:Number = dx * springAmount; 
				var ay:Number = dy * springAmount;
				
				partA.vx += ax / partA.mass; 
				partA.vy += ay / partA.mass; 
				
				partB.vx -= ax / partB.mass;
				partB.vy -= ay / partB.mass;
			} 
		}
	}

}