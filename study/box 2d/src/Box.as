package   
{  
    import flash.display.*;  
  
    public class Box extends Sprite  
    {  
        public var vx:Number = 0;  
        private var color:uint;  
        private var w:Number;  
        private var h:Number;  
        public var vy:Number = 0;  
  
        public function Box(param1:Number = 50, param2:Number = 50, param3:uint = 16711680)  
        {  
            w = param1;  
            h = param2;  
            this.color = param3;  
            init();  
            return;  
        }// end function  
  
        private function init() : void  
        {  
            graphics.beginFill(color);  
            graphics.drawRect((-w) / 2, (-h) / 2, w, h);  
            graphics.endFill();  
            return;  
        }// end function  
  
    }  
} 