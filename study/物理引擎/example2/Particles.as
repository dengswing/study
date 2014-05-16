package
{   
	import flash.display.Sprite;  
	import flash.events.Event; 
	
    public class Particles extends Sprite {  
        public var stageWidth : int = stage.stageWidth - 8; 
		public var stageHeight : int = stage.stageHeight - 8; 
		
		//我们虚拟的世界中所有物理对象的列表 
		private var particles : Array = new Array; 
		
		//粒子个数
        private var particles_count : int = 100;    
		
		public function Particles() {  
			addEventListener( Event.ADDED_TO_STAGE, init );  
		}     
		
		/**
		 * @explain 初始化100个物理对象，每个对象在场景中有一个随机的位置和速度
		 * @param	e
		 */
		private function init( e : Event ) : void  {       
			removeEventListener( Event.ADDED_TO_STAGE, init ); 			
			
            for (var i : int = 0; i < particles_count; i++) {    
				particles[i] = new Particle();        
			      
				particles[i].x = Math.random() * stageWidth; 
				particles[i].y = Math.random() * stageHeight;  
				
				//速度是一个向量，所以vx,vy分别保存这个对象在x、y轴上的速度。   
				particles[i].vx = Math.random() * 20 - 10;  
				particles[i].vy = Math.random() * 20 - 10; 
		    
				addChild( particles[i] );   
			}
			
			addEventListener(Event.ENTER_FRAME, loop);   
			
		} 
		
		/**
		 * @explain 这个物理模拟程序中的核心算法 
		 * @param	e
		 */
		private function loop( e : Event ) : void  {      
			var distance : Object = { x:0, y:0 };   
			var impact : Object = { x:0, y:0 };      
			var impulse : Object = { x:0, y:0 };  
			var impulseHalf : Object = { x:0, y:0 };   
			
			//重力向量 
			//var gravity : Object = {x: (mouseX - (stageWidth >> 1)) / stageWidth, y: (mouseY - (stageHeight >> 1)) / stageHeight };      
			var gravity: Object = { x:0, y:1 };    
			
			
			//这个循环的意思很简单，检测每个对象和其它对象是否碰撞，如果没有产生碰撞则跳过，如果产生碰撞则进行处理    
			for ( var i : int = 0; i < particles_count; i++)
			{    
				var particle : Particle = particles[i]; 
				
				for ( var j : int = 0; j < particles_count; j++)     
				{                     
					var particle2 : Particle = particles[j];    
					
					//当检测到自己时跳过这个循环
					if (particle2 == particle)  continue;    					   
					
					distance.x = particle.x - particle2.x;         
					distance.y = particle.y - particle2.y;     
					
					var length : Number = Math.sqrt(distance.x * distance.x + distance.y * distance.y);     
					//因为这个模拟中所有对象都是圆形，所以检测两个圆形是否相撞就是看两个圆形的圆心的距离是否大于直径      
					//当然这里非常简单，像box2d这样检测随机物体碰撞将会比较复杂              
                    //length则是通过笛卡尔坐标系求两点之间距离的公式算出两个对象的圆心距离         
					if (length < 16) //小于16，物体相撞，则处理        
					{  
						impact.x = particle2.vx - particle.vx; //) * particle.restitution;         
						impact.y = particle2.vy - particle.vy; //) * particle.restitution;  
						
						impulse.x = particle2.x - particle.x;           
						impulse.y = particle2.y - particle.y;         
						//笛卡尔坐标系求两点之间距离公式，求出两点之间的距离   
						var mag : Number = Math.sqrt(impulse.x * impulse.x + impulse.y * impulse.y);   
						
						if (mag > 0) {             
							mag = 1 / mag;  //初中几何知识       
							//这个时候impulse.x就是sin(x),impulse.y就是cos(x)         
							impulse.x *= mag;                   
							impulse.y *= mag;              
						}    
						
						impulseHalf.x = impulse.x * .5;     
						impulseHalf.y = impulse.y * .5;      
						//碰撞物体坐标加上一些微量偏移       
						particle.x -= impulseHalf.x;        
						particle.y -= impulseHalf.y;   
						particle2.x += impulseHalf.x;        
						particle2.y += impulseHalf.y;         
						var dot : Number = impact.x * impulse.x + impact.y * impulse.y;    
						//这里需要回忆一下初中物理里的力的合成与分解。 
						//即任何方向的力都可以分解为x,y方向两个力的合力。    
						//dot为总体加速度，impulse.x,impulse.y分别为x,y两个方向的加速度     
						impulse.x *= dot;
						impulse.y *= dot;
						//两个碰撞体的速度分别加上新的加速度。
						particle.vx += impulse.x * .9; // * particle.restitution;
						particle.vy += impulse.y * .9; // * particle.restitution;
						particle2.vx -= impulse.x * .9; //particle.restitution;
						particle2.vy -= impulse.y * .9; //particle.restitution;
						}
				}
				
				//速度中加上重力，同时更新球体的x,y坐标
				particle.x += particle.vx += gravity.x;
				particle.y += particle.vy += gravity.y;
				//y轴边界检测
				if (particle.y < 8 || particle.y > stageHeight) {   
					particle.vy *= -.8;         
					particle.vx *= .98;    
				}
				particle.y = (particle.y < 8) ? 8 : (particle.y > stageHeight) ? stageHeight : particle.y;
				//x轴边界检测。
				if (particle.x < 8 || particle.x > stageWidth)
					particle.vx *= -.8;
					particle.x = (particle.x < 8) ? 8 : (particle.x > stageWidth) ? stageWidth : particle.x;
			}
		}
		
		
	}
} 

import flash.display.Sprite;  

class Particle extends Sprite  {  
    public var vx : Number = 0; 
    public var vy : Number = 0;  
	public function Particle() {    
		graphics.beginFill(0x000000);   
		graphics.drawCircle(0, 0, 8);   
		graphics.endFill();
	}
}  	