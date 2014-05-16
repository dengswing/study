//Copyright © 2008. Http://L4cd.Net All Rights Reserved.
package
{
        import flash.display.Bitmap;
        import flash.display.BitmapData;
        import flash.display.Sprite;
        import flash.events.TimerEvent;
        import flash.geom.Matrix;
        import flash.geom.Rectangle;
        import flash.utils.Timer;
        
   		[SWF(backgroundColor = "#FFFFFF")]

        public class Run extends Sprite
        {
                [Embed(source="0002.png")]
                private var Png002:Class;
                private var m:Bitmap;
                private var w:Number = 80;//单动作宽度
                private var h:Number = 91;//单动作高度
                private var c:Number = 8;//动作数
                private var bmp:Array;
                public function Run()
                {
                        m = new Png002() as Bitmap;
                        bmp = [];
                        for(var i:uint=0;i<8;i++)
                        {
                                var bit:BitmapData = new BitmapData(80,91);
                                var mx:Matrix = new Matrix();
                                mx.tx = -i*w;
                                bit.draw(m,mx,null,null,new Rectangle(0,0,w,h));
                                bmp.push(bit);
                        }
                        m.bitmapData = null
                        addChild(m)
                        var timer:Timer = new Timer(50);
                        timer.addEventListener(TimerEvent.TIMER,frame);
                        timer.start();
                }
                private function frame(e:TimerEvent):void
                {
                        bmp.push(bmp.shift());
                        m.bitmapData = bmp[0];
                }
        }
}