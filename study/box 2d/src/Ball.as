package   
{  
    import flash.display.*;  
  
    public class Ball extends Sprite  
    {  
        public var vx:Number = 0;  
        private var color:uint;  
        public var radius:Number;  
        public var vy:Number = 0;  
        public var mass:Number = 1;  
  
        public function Ball(param1:Number = 40, param2:uint = 16711680)  
        {  
            this.radius = param1;  
            this.color = param2;  
            init();  
            return;  
        }// end function  
  
        public function init() : void  
        {  
            graphics.beginFill(color);  
            graphics.drawCircle(0, 0, radius);  
            graphics.endFill();  
            return;  
        }// end function  
  
    }  
} 