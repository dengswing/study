package Classes{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.TextField;
	/*
	 * 五子棋初级教程
	 * 
	 * @author	Dingo
	 * @version	1.0
	 * @date	070829
	 */	
	
	public class GobangDoc extends MovieClip {
		//棋盘格宽度
		private const gridsize:Number = 20;
		//棋盘格数
		private const gridnum:Number = 15;
		//没有棋子为0,黑子为1，白子为2
		private const NOTHING:uint = 0;
		private const BLACK:uint = 1;
		private const WHITE:uint = 2;
		//现在轮到哪一方出子
		private var crtSide:uint = WHITE;
		//玩家的棋子
		private var mySide:uint = WHITE;
		//对手的棋子
		private var otherSide:uint;
		//是否可以进行游戏
		private var canPlay:Boolean = false;
		//记录盘面状态的数组
		private var aGridState:Array = [];
		//记录盘面上的棋子的数组
		private var aChessmen:Array = [];
		//棋子的几种状态
		public const STWO:int = 2;//眠二
		public const FTWO:int = 4;//假活二
		public const STHREE:int = 5;//眠三
		public const TWO:int = 8;//活二
		public const SFOUR:int = 12;//冲四
		public const FTHREE:int = 15;//假活三
		public const THREE:int = 40;//活三
		public const FOUR:int = 90;//活四
		public const FIVE:int = 200;//五连
		//玩家的棋形表
		private var aPlayer:Array = [];
		//对手的棋形表
		private var aOpponent:Array = [];
		//八个方向，从左上角开始顺时针
		private var dir:Array = [[-1,-1],[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0]];
		private var uBackgammon:Backgammon;
		
		public function GobangDoc()
		{
			uBackgammon = new Backgammon();
			addChild(uBackgammon);
			
			uBackgammon.mcGameState.visible = false;
			otherSide = WHITE + BLACK - mySide;
			//初始化盘面数组
			for (var i:uint=0; i<gridnum; i++) {
				aGridState[i] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			}
			uBackgammon.mcChessboard.addEventListener(MouseEvent.MOUSE_DOWN,AddMyChessman); //棋盘
			uBackgammon.btnStart.addEventListener(MouseEvent.CLICK, btnStart_Handler);　　//开始游戏
			uBackgammon.btnReplay.addEventListener(MouseEvent.CLICK, btnReplay_Handler);　//重新游戏
			uBackgammon.mcSelectChessman.addEventListener(MouseEvent.MOUSE_DOWN, selectChessman);　//选择黑白
		}
		
		
		//初始化棋盘
		private function init():void
		{
			uBackgammon.btnStart.visible = false;
			for (var i:int = 0; i < aChessmen.length; i++)
			{
				uBackgammon.mcChessboard.removeChild(aChessmen[i]);				
			}
			for (var j:uint=0; j<gridnum; j++) {
				aGridState[j] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			}
			aChessmen = [];
			canPlay = true;
		}
		//玩家添加棋子
		public function AddMyChessman(e:MouseEvent):void {
			//不能添加棋子的状态（棋局未开始、对方走、棋子没有落在棋盘里）
			if(!canPlay || crtSide != mySide || e.target.name != "mcChessboard") 
				return;
			if (mySide == crtSide) {
				//计算鼠标落在哪一格
				var crtx:uint = Math.floor(e.localX/gridsize);
				var crty:uint = Math.floor(e.localY/gridsize);
				//如果这一格已经有棋子就返回
				if (aGridState[crty][crtx])
					return;					
				//创建棋子
				var chessman:Chessman;
				if (mySide == BLACK) {
					chessman = new BlackChessman();
				} else {
					chessman = new WhiteChessman();
				}
				chessman.bPlayer = true;
				aGridState[crty][crtx] = mySide;
				chessman.x = (crtx + .5) * gridsize;
				chessman.y = (crty + .5) * gridsize;
				aChessmen.push(chessman);
				uBackgammon.mcChessboard.addChild(chessman);
				checkWinner(crtx,crty,crtSide);						
				//对方走
				crtSide = WHITE + BLACK - mySide;
				//计算机走
				var opos:Array = CalculateState(crtSide);
				var cx:int = opos[0];
				var cy:int = opos[1];
				AddChessman(cx,cy);					
				checkWinner(cx,cy,crtSide);
				crtSide = mySide;
			}
		}
		
		//计算机添加棋子
		public function AddChessman(toX:int,toY:int):void {
			if(!canPlay)
				return;
			var autox:int = toX;
			var autoy:int = toY;
			var chessman:Chessman;
			if (mySide == BLACK) {
				chessman = new WhiteChessman();
			} else {
				chessman = new BlackChessman();
			}
			chessman.x = (autox + .5)*gridsize;
			chessman.y = (autoy + .5)*gridsize;
			aGridState[autoy][autox] = (BLACK + WHITE) - mySide;
			aChessmen.push(chessman);
			uBackgammon.mcChessboard.addChild(chessman);
		}
		//评估棋盘上每一格的分值，返回得分最高的棋格坐标
		public function CalculateState(side:uint):Array{
			var i:int,j:int,k:int;
			var otherside:int = WHITE + BLACK - side;	
			//填充玩家的棋形表和对手的棋形表
			for(i = 0;i<gridnum;i++){
				for(j = 0;j<gridnum;j++){
					if(aGridState[i][j] != NOTHING){
						aOpponent[i * gridnum + j] = {val:-1,x:j,y:i};
						aPlayer[i * gridnum + j] = {val:-1,x:j,y:i};
					}
					else{
						var v1 = getScore(aGridState,j,i,side);
						aOpponent[i * gridnum + j] = {val:v1,x:j,y:i};
						var v2 = getScore(aGridState,j,i,otherside);
						aPlayer[i * gridnum + j] = {val:v2,x:j,y:i};
					}					
				}
			}
			//取得分值最大的棋格
			var maxO:Object = sortArray(aOpponent);
			var maxP:Object = sortArray(aPlayer);
			var apos:Array = [0,0];
			if(maxO.val < maxP.val)
				apos = [maxP.x,maxP.y];
			else
				apos = [maxO.x,maxO.y];
			return apos
		}
		//检查赢家
		private function checkWinner(xp:int,yp:int,side:int){
			var str:String = (side * 11111).toString();
			var winner:int = 0;	
			var str1:String = getXLine(aGridState,xp,yp,side).join("");
			var str2:String = getYLine(aGridState,xp,yp,side).join("");
			var str3:String = getXYLine(aGridState,xp,yp,side).join("");
			var str4:String = getYXLine(aGridState,xp,yp,side).join("");
			if(str1.indexOf(str)>-1 || str2.indexOf(str)>-1 || str3.indexOf(str)>-1 || str4.indexOf(str)>-1)
				winner = side;					
				
			if (winner)
			{
				doWin(winner);
			}			
		}		
		//取胜后触发的事件
		private function doWin(side:int):void{
			//现实游戏结果说明
			uBackgammon.mcGameState.visible = true;
			//关闭棋局
			canPlay = false;
			//期盼设为半透明
			uBackgammon.mcChessboard.alpha = .5;
			//根据玩家输赢展示不同的游戏结果
			if(side == mySide){
				uBackgammon.mcGameState.gotoAndStop("win");
			}
			else{
				uBackgammon.mcGameState.gotoAndStop("lose");
			}
		}
		//为数组排序的方法
		private function sortArray(arr):Object{
			var arrLen:int = arr.length;
			var ar:Array = [];
			for(var j=0;j<arrLen;j++){
				ar[j] = arr[j];
			}
			//以数字方式对"val"字段进行排序
			ar.sortOn("val",Array.NUMERIC );			
			return ar[ar.length-1];
		}
		//取得指定棋格的分数
		private function getScore(arr:Array,xp:int,yp:int,side:int):int{
			var s0:int = AnalysisLine(getXLine(arr,xp,yp,side),side);
			var s1:int = AnalysisLine(getYLine(arr,xp,yp,side),side);
			var s2:int = AnalysisLine(getXYLine(arr,xp,yp,side),side);																   
			var s3:int = AnalysisLine(getYXLine(arr,xp,yp,side),side);			
			return (s0 + s1 + s2 + s3);
		}
		
		// -- 取得游戏中的一方在指定位置左右两边5格以内的状态
		private function getXLine(aposition:Array,xp:int,yp:int,side:int):Array{
			var arr:Array = [];
			var xs:int,ys:int,xe:int,ye:int;
			//起始位置
			xs = xp - 5>0 ? xp - 5:0;
			//结束位置
			xe = xp + 5>= gridnum?gridnum:xp + 5;
			for(var i:int=xs;i<=xe;i++){
				if(i == xp)
					arr.push(side);
				else{
					arr.push(aGridState[yp][i])
				}				
			}			
			return arr;		
		}
		// | 取得游戏中的一方在指定位置上下两边5格以内的状态
		private function getYLine(aposition:Array,xp:int,yp:int,side:int):Array{
			var arr:Array = [];
			var xs:int,ys:int,xe:int,ye:int;
			//起始位置						
			ys = yp - 5>0 ? yp - 5:0;
			//结束位置
			ye = yp + 5>= gridnum?gridnum:yp + 5;
			for(var i:int=ys;i<ye;i++){
				if(i == yp)
					arr.push(side);
				else{
					arr.push(aposition[i][xp])
				}
			}			
			return arr;
		}
		// \ 取得游戏中的一方在指定位置左上右下两边5格以内的状态
		private function getXYLine(aposition:Array,xp:int,yp:int,side:int):Array{
			var arr:Array = [];
			var xs:int,ys:int,xe:int,ye:int;
			//起始位置
			xs = yp > xp ? 0 : xp - yp;
			ys = xp > yp ? 0 : yp - xp;
			//结束位置
			xe = gridnum - ys;
			ye = gridnum - xs;
			var pos:int;
			for (var i:int = 0; i < (xe-xs < ye-ys?xe-xs:ye-ys); i++)
			{				
					if(ys + i == yp && xs + i == xp){
						arr.push(side);
						pos = i;
					}
					else{
						arr.push(aposition[ys + i][ xs + i]);
					}					
			}
			arr = arr.slice(pos-4>0?pos-4:0,pos+5>arr.length?arr.length:pos+5);
			return arr;
		}
		// / 取得游戏中的一方在指定位置左下右上两边5格以内的状态
		private function getYXLine(aposition:Array,xp:int,yp:int,side:int):Array{
			var arr:Array = [];
			var xs:int,ys:int,xe:int,ye:int;
			var num:int = gridnum;
			var half:int = Math.ceil(gridnum/2);
			//起始位置
			xs = xp + yp < num?0:(xp + yp - num + 1);
			ys = xs;
			//结束位置
			xe = xp + yp >= num?num-1:(xp + yp);
			ye = xe;
			var pos:int;
			for(var i:int=0;i<(xp + yp>=num?2*num-xp-yp-1:xp+yp+1);i++){				
					if(ye - i == yp && xs + i == xp){
						arr.push(side);
						pos = i;
					}
					else
						arr.push(aposition[ye - i][ xs + i]);				
			}
			arr = arr.slice(pos-4>0?pos-4:0,pos+5>arr.length?arr.length:pos+5);
			return arr;
		}
		//评估游戏中的一方在指定位置落子后某一方向可能取得的分值
		private function AnalysisLine(aline:Array,side:int):int{
			var otherside:int =  WHITE + BLACK - side;
			//以下注释中 * 为本方棋子，o 为对方棋子，_ 为空格
			// *****
			var five:String = (side * 11111).toString();
			// _****
			var four:String = "0" + (side * 1111).toString() + "0";
			// _***_
			var three:String = "0" + (side * 111).toString() + "0";
			// _**_
			var two:String = "0" + (side * 11).toString() + "0";
			// _*_*_
			var jtwo:String = "0" + (side * 101).toString() + "0";
			// ****_
			var lfour:String = otherside.toString() + (side * 1111).toString() + "0";
			// _****
			var rfour:String = "0" + (side * 1111).toString() + otherside.toString();
			// *_***
			var l_four:String = (side * 10111).toString();
			// ***_*
			var r_four:String = (side * 11101).toString();
			// o***_
			var lthree:String = otherside.toString() + (side * 111).toString() + "0";
			// _***o
			var rthree:String = "0" + (side * 111).toString() + otherside.toString();
			// o**_
			var ltwo:String = otherside.toString() + (side * 11).toString() + "0";
			// _**o
			var rtwo:String = "0" + (side * 11).toString() + otherside.toString();
			// ***_o
			var rfthree:String = (side * 111).toString() + "0" + otherside.toString();
			// o_***
			var lfthree:String = otherside.toString() + "0" + (side * 111).toString();
			
			var str:String = aline.join("");
			var res:int;
			if(str.indexOf(five)>=0){
				res = FIVE;
				if(side == otherSide)
					res *=2;
			}
			else if(str.indexOf(four)>=0)
				res = FOUR;
			else if(str.indexOf(three)>=0)
				res = side!=mySide?THREE+4:THREE;
			else if(str.indexOf(two)>=0 || str.indexOf(jtwo)>=0 )
				res = TWO;
			else if(str.indexOf(lfour)>=0 || str.indexOf(rfour)>=0 || str.indexOf(l_four)>=0 || str.indexOf(r_four)>=0)
				res = SFOUR;
			else if(str.indexOf(lthree)>=0 || str.indexOf(rthree)>=0)
				res = STHREE;
			else if(str.indexOf(ltwo)>=0 || str.indexOf(rtwo)>=0)
				res = STWO;
			else if(str.indexOf(lfthree)>=0 || str.indexOf(rfthree)>=0)
				res = FTHREE;
			else 
				res = 0;
				
			return res;
		}		
		//开始游戏按钮触发的方法
		private function btnStart_Handler(e:MouseEvent):void{
			canPlay = true;
			if(mySide == WHITE){
				AddChessman(Math.floor(gridnum/2),Math.floor(gridnum/2));
			}
			uBackgammon.btnStart.visible = false;
		}
		//重玩一遍按钮触发的方法
		private function btnReplay_Handler(e:MouseEvent):void{
			uBackgammon.mcGameState.visible = false;
			uBackgammon.mcChessboard.alpha = 1;
			init();			
			if(mySide == WHITE){
				AddChessman(Math.floor(gridnum/2),Math.floor(gridnum/2));
			}
		}
		//选择棋子按钮触发的方法
		private function selectChessman(e:MouseEvent):void{
			if(canPlay){
				uBackgammon.mcSelectChessman.buttonMode = false;
				return;
			}else{
				uBackgammon.mcSelectChessman.buttonMode = true;
				mySide = otherSide;
				otherSide = WHITE + BLACK - mySide;
				if(mySide == WHITE){
					uBackgammon.mcSelectChessman.gotoAndStop("white");
				}else{
					uBackgammon.mcSelectChessman.gotoAndStop("black");
				}
				crtSide = mySide;
			}
		}
		
	}
}