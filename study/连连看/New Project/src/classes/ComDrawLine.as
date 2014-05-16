package classes
{
	import flash.display.*;
	import flash.utils.*;
	import util.*;

	public class ComDrawLine extends MovieClip 
	{
		private var _arrBlock	:Array;
		private var _linePoint	:Array;
		private var _lineArr	:Array;
		
		public function ComDrawLine(arrBlock:Array,linePoint:Array,lineArr:Array):void
		{
			_arrBlock 	= arrBlock;
			_linePoint 	= linePoint;		
			_lineArr	= lineArr;
		}
		
		
		/**
		 * 添加line
		 * @param        x1,x2
		 * @param        y1,y2
		 *
		 */
		 private function addShapeLine(x1:int,y1:int,x2:int,y2:int):void
		 {
			 var shapes:Shape = new Shape();
			 shapes.graphics.lineStyle(3,0xFF0000,1);
			 shapes.graphics.moveTo(x1,y1);
			 shapes.graphics.lineTo(x2,y2);
			 _lineArr.push(shapes);
			 this.parent.addChild(shapes); 
		 }
		 
		/**
		 * 连接点的线画出
		 * @param        x1,x2
		 * @param        y1,y2
		 * @return
		 **/
		public function drawLine(x1:int,y1:int,x2:int,y2:int):void
		{
			trace('draw:',x1,y1,x2,y2,'linepoint',_linePoint.length);
			if(_linePoint.length==2)
			{
				if((_linePoint[0].x1==x1&&_linePoint[0].y1==y1)||(_linePoint[1].x2==x1&&_linePoint[1].y2==y1)) 	
				{
					//trace('o0');
					_linePoint[0].x2--;
					_linePoint[1].y1 = _linePoint[0].y1;
				}
				else if((_linePoint[0].x2==x1&&_linePoint[0].y2==y1) ||(_linePoint[1].x1==x1&&_linePoint[1].y1==y1)) 
				{
					//trace('o1');
					if(_linePoint[0].y1>_linePoint[1].y2)
					{
						_linePoint[1].y2++;
					}
					else
					{
						_linePoint[1].y2--;
					}
					_linePoint[0].x1 = _linePoint[1].x2;
					
				}
			}
			else if(_linePoint.length==3)
			{
				if(_linePoint[0].y1 ==_linePoint[0].y2)
				{
					_linePoint[0].x1 =  _linePoint[1].x1;
					_linePoint[0].x2 =  _linePoint[2].x1;
				}
				else
				{
					_linePoint[0].y1 =  _linePoint[0].y1+1;
					_linePoint[0].y2 =  _linePoint[0].y2-1;
				}
			 }
			 
			 
			 for(var s:int = 0;s<_linePoint.length;s++)
			 {
				trace(_linePoint[s].x1,_linePoint[s].y1,_linePoint[s].x2,_linePoint[s].y2);
				addShapeLine(_arrBlock[_linePoint[s].x1*llkDoc.mapLength+_linePoint[s].y1].x,
							 _arrBlock[_linePoint[s].x1*llkDoc.mapLength+_linePoint[s].y1].y,
							 _arrBlock[_linePoint[s].x2*llkDoc.mapLength+_linePoint[s].y2].x,
							 _arrBlock[_linePoint[s].x2*llkDoc.mapLength+_linePoint[s].y2].y);
			  }
		}
		
		
	}
}