package classes
{
	import flash.display.*;
	import flash.utils.*;
	import util.*;

	public class ComCheckBarrier extends MovieClip 
	{
		private var _arrBlock	:Array;
		private var _linePoint	:Array;
		
		public function ComCheckBarrier(arrBlock:Array,linePoint:Array):void
		{
			_arrBlock 	= arrBlock;
			_linePoint 	= linePoint;
		}
		/**
		 * 横向检查
		 * @param        x1,x2
		 * @param        y1,y2
		 * @return		 temp
		*/		 
		 private  function checkX(x1:int,y1:int,x2:int,y2:int):Boolean
		 {
			 var temp:Boolean = true; 
			 var i	 :int;
			 //trace('i',x1,y1,x2 ,y2);
			 for(i = Math.min(y1,y2)+1;i<Math.max(y1,y2);i++)
			 {
				 //trace('ii', x1, i, y1, y2);
				 if(_arrBlock[x1*llkDoc.mapLength+i]._blank==0)
				 {
					temp = true;
				 }
				 else
				 {
					temp 	   = false;
					break;
				 }
			 }
			 if(temp)
			 {
				_linePoint.push({x1:x1,y1:y1,x2:x2,y2:y2});
			 }
			 else
			 {
				_linePoint.splice(0);
			 }
			 return temp;
		 }
		 
		 /**
		 * 纵向检查
		 * @param        x1,x2
		 * @param        y1,y2
		 * @return		 temp
		 */
		 private function checkY(x1:int,y1:int,x2:int,y2:int):Boolean
		 {
			 var temp:Boolean = true; 
			 var j	: int; 
			// trace('j',x1,y1,x2,y2);
			 for(j = Math.min(x1,x2)+1;j<Math.max(x1,x2);j++)
			 {
				// trace('jj',j,y1);
				 if(_arrBlock[j*llkDoc.mapLength+y1]._blank == 0)
				 {
					 temp = true;
				 }
				 else
				 {
					 temp = false;
					 break;
				 }
			 }
			 
			 if(temp)
			 {
				_linePoint.push({x1:x1,y1:y1,x2:x2,y2:y2});
			 }
			 else
			 {	
			 	_linePoint.splice(0);
			 }
			 return temp;
		 }
		 
		 /**
		  * 二级检测 即：一个折点的折线能否把两个方块连接起来
		  * @param        x1,x2
		  * @param        y1,y2
		  * @return		  temp
		  */
		 private function checkTwoNode(x1:int,y1:int,x2:int,y2:int):Boolean
		 {
			 var temp:Boolean;
			 
			 trace('two',x1,y1,x2,y2);
			 
			 if(y1<=y2)
			 {
				 temp = (checkY(x1,y1,x2+1,y1)&&checkX(x2,y1-1,x2,y2))
				 	      ||(checkY(x1,y2,x2,y2)&&checkX(x1,y1,x1,y2+1));
			 }
			 else
			 {
				 temp = (checkY(x1-1,y2,x2,y2)&&checkX(x1,y1,x1,y2-1))
				 	      ||(checkY(x1,y1,x2+1,y1)&&checkX(x2,y1+1,x2,y2));
			 }
			 return temp;
		 }
		 
		 /**
		  * 三级检测中的横向检测 即：2个折点的横坐标相等
		  * @param        x1,x2
		  * @param        y1,y2
		  * @return		  temp
		  */
		 private function checkThreeNodeX(x1:int,y1:int,x2:int,y2:int):Boolean
		 {
			 var temp:Boolean;
			 for(var i:int = 0;i<llkDoc.mapLength;i++)
			 {
				//检查 (x1,i)-(x2,i) 之间是否连通 (x1,i) 与 (x2,i) 是分别要找的中间点 
				if(x1<=x2)
				{
					if(checkY(x1-1,i,x2+1,i))
					{
						if(checkX(x1,y1,x1,i)&&checkX(x2,y2,x2,i))
						{
							temp = true;  
							break;
						}
					}
				}
				else
				{
					if(checkY(x2-1,i,x1+1,i))
					{
						if(checkX(x1,y1,x1,i)&&checkX(x2,y2,x2,i))
						{
							temp = true;  
							break;
						}
					}
				}
			}
			return temp;
		 }
		 /**
		  * 三级检测中的纵向检测 即：2个折点的纵坐标相等
		  * @param        x1,x2
		  * @param        y1,y2
		  * @return		  temp
		  */
		 private function checkThreeNodeY(x1:int,y1:int,x2:int,y2:int):Boolean
		 { 
			 var temp:Boolean;
			 
			 for(var j:int = 0;j<llkDoc.mapLength;j++)
			 {
				 //检查 (j,y1)-(j,y2) 之间是否连通 (j,y1) 与 (j,y2) 是分别要找的中间点 
				 if(y1<=y2)
				 {
				 	if(checkX(j,y1-1,j,y2+1))
				 	{
					 	if(checkY(x1,y1,j,y1)&&checkY(x2,y2,j,y2))
					 	{
							trace('ok');
							temp = true;
							break;
					 	} 
					 }
				 }
				 else
				 {
					if(checkX(j,y2-1,j,y1+1))
				 	{
					 	if(checkY(x1,y1,j,y1)&&checkY(x2,y2,j,y2))
					 	{
							trace('ok1');
							temp = true;
							break;
					 	} 
					 } 
				 }
			 }
			 return temp;
			 
		 }
		
		 /**
		  * 三级检测 即：两个折点的折线能否把两个方块连接起来
		  * @param        x1,x2
		  * @param        y1,y2
		  * @return		  temp
		  */
		 private function checkThreeNode(x1:int,y1:int,x2:int,y2:int):Boolean
		 {
			 var temp:Boolean = false;
			 
			 trace('three',x1,y1,x2,y2);
			  
			 if(!temp)
			 {
				 temp = checkThreeNodeX(x1,y1,x2,y2);
			 }
			 if(!temp)
			 {
				 temp = checkThreeNodeY(x1,y1,x2,y2);
			 }
			 return temp;
		 }
		
		/**
		 * 检验连接是否成功
		 * @param        x1,x2
		 * @param        y1,y2
		 * @return
		 */ 
		public  function checkBarrier(x1:int,y1:int,x2:int,y2:int):Boolean
		{
			//trace(x1,y1,x2,y2);
			var temp:Boolean = false;
			
			var tempx:int;
			var tempy:int;
			
			trace('init',x1,y1,x2,y2);
			
			if (x1 >= x2 && y1 >= y2)			
			{
				tempx = x1;
				x1    = x2;
				x2	  = tempx;
				
				tempy = y1;
				y1 	  = y2;
				y2    = tempy;
				
			}
			
			// 一级检测 即：检验两方块之间能否直线连接 
			if(x1==x2)
			{
				temp = checkX(x1,y1,x2,y2);
			}
			else if(y1==y2)
			{
				temp = checkY(x1,y1,x2,y2);
			}
			
			trace("one ",temp);
			//二级检测 
			if(!temp)
			{
				temp = checkTwoNode(x1,y1,x2,y2);
			}
			
			trace("two ",temp);
			//三级检测
			if(!temp)
			{
				temp = checkThreeNode(x1,y1,x2,y2);
			}
			
			trace('last:',temp);
			return temp;
		}
		
	}
	
}