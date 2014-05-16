package
{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.Matrix;
    import flash.geom.Transform;
    
    public class Matrix_invert extends Sprite
    {
        public function Matrix_invert()
        {
            var rect0:Shape = createRectangle(20, 80, 0xFF0000);   
            var rect1:Shape = createRectangle(20, 80, 0x000000);   
            var rect2:Shape = createRectangle(20, 80, 0x0000FF);
            var rect3:Shape = createRectangle(20, 80, 0x000000);
            
            var trans0:Transform = new Transform(rect0);
            var trans1:Transform = new Transform(rect1);
            var trans2:Transform = new Transform(rect2);
            var trans3:Transform = new Transform(rect3);
             
            var doubleScaleMatrix:Matrix = new Matrix(2, 0, 0, 2, 0, 0);
            trans0.matrix = doubleScaleMatrix;
            trace(doubleScaleMatrix.toString());  // (a=2, b=0, c=0, d=2, tx=0, ty=0)
             
            var noScaleMatrix:Matrix = new Matrix(1, 0, 0, 1, 0, 0);
            trans1.matrix = noScaleMatrix;
            rect1.x = 50;
            trace(noScaleMatrix.toString());  // (a=1, b=0, c=0, d=1, tx=0, ty=0)
             
            var halfScaleMatrix:Matrix = doubleScaleMatrix.clone();
            halfScaleMatrix.invert();
            trans2.matrix = halfScaleMatrix;
            rect2.x = 100;
            trace(halfScaleMatrix.toString());  // (a=0.5, b=0, c=0, d=0.5, tx=0, ty=0)
             
            var originalAndInverseMatrix:Matrix = doubleScaleMatrix.clone();
            originalAndInverseMatrix.concat(halfScaleMatrix);
            trans3.matrix = originalAndInverseMatrix;
            rect3.x = 150;
            trace(originalAndInverseMatrix.toString());  // (a=1, b=0, c=0, d=1, tx=0, ty=0)            
        }
        
        public function createRectangle(w:Number, h:Number, color:Number):Shape 
        {
            var rect:Shape = new Shape();
            rect.graphics.beginFill(color);
            rect.graphics.drawRect(0, 0, w, h);
            addChild(rect);
            return rect;
        }
    }
}