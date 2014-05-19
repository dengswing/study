/*
* Puzzle CLASS
* 
* @ CREATED BY: ycccc8202
* @ PURPOSE: 方便制作拼图游戏
* @ DATE:2007.6.10
* Usage example:
* var url:String = "http://pic.ent.tom.com/data2/upload/888/407/117984810018150686780.jpg";
* var puzzle:Puzzle = new Puzzle(this, url);
* 设置摆放位置
* puzzle.setPosition(30, 20);
* 设置行/列
* puzzle.setRowAndLine(30, 10);
*/
import com.ycccc.PuzzleGame.MovieClipDrag;
import mx.events.EventDispatcher;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.filters.BevelFilter;
class com.ycccc.PuzzleGame.Puzzle {
	/**
	* Private members
	*/
	//////////加载图片长宽///////////
	private var _imageW:Number;
	private var _imageH:Number;
	//////////设置最大宽高///////////
	private var _imageMaxW:Number = 800;
	private var _imageMaxH:Number = 500;
	////////////////////////////////
	private var dispatchEvent:Function;
	public var addEventListener:Function;
	public var removeEventListener:Function;
	////////////////////////////////
	private var _oldURL:String;
	private var _newURL:String;
	private var _x:Number;
	private var _y:Number;
	private var _row:Number;
	private var _line:Number;
	private var _path:MovieClip;
	private var _imageM:MovieClip;
	private var _pieceBoard:MovieClip;
	private var _imageLoader:MovieClipLoader;
	private var _imageBitmap:BitmapData;
	
	private var _pieceW:Number;
	private var _pieceH:Number;
	private var _pieceMinWH:Number;
	private var _pieceD:Number;
	///////////内切矩形宽高(通过矩形画近似椭圆)///////////
	private var _pieceOW:Number;
	private var _pieceOH:Number;
	///////////////比例系数///////////////
	private var _pieceD_k:Number = 10;
	private var _pieceO_k:Number = 4;
	private var _pieceOWH_k:Number = 3/4;
	/////////////////////////////////
	/**
	* Constructor
	*/
	public function Puzzle(path:MovieClip, imageLink:String) {
		EventDispatcher.initialize(this);
		_path = path;
		_newURL = imageLink;
		_imageM = _path.createEmptyMovieClip("imageM", _path.getNextHighestDepth());
		_imageLoader = new MovieClipLoader();
		_imageLoader.addListener(this);
		loadImage(_newURL);
	}
	/**
	* Public methods
	*/
	public function set _url(url:String) {
		loadImage(url);
	}
	public function get _url():String {
		return _oldURL;
	}
	public function set row(r:Number) {
		_row = r;
	}
	public function set line(l:Number) {
		_line = l;
	}
	public function removeAllPiece() {
		for (var all in _pieceBoard) {
			_pieceBoard[all].removeMovieClip();
		}
	}
	public function bitmapCut() {
		pieceSet();
		removeAllPiece();
		for (var i:Number = 0; i<_row; i++) {
			for (var j:Number = 0; j<_line; j++) {
				var Piece = _pieceBoard.createEmptyMovieClip("Piece"+(_line*i+j), _pieceBoard.getNextHighestDepth());
				Piece.beginBitmapFill(_imageBitmap, new Matrix(1, 0, 0, 1, -j*_pieceW, -i*_pieceH), true, true);
				Piece._x = j*_pieceW;
				Piece._y = i*_pieceH;
				Piece.i = i;
				Piece.j = j;
				new MovieClipDrag(Piece);
				drawPiece(Piece, getAllDotArray(Piece));
				//画小块形状
				Piece.filters = [new BevelFilter(3, 30)];
			}
		}
	}
	public function setMaxWH(w:Number, h:Number) {
		//设置允许的最大宽高
		_imageMaxW = w;
		_imageMaxH = h;
	}
	public function setRowAndLine(row:Number, line:Number) {
		//设置切割的 行/列
		if (row<=0 || line<=0) {
			trace("行/列不能为0,按默认10*10进行切图");
			return;
		}
		if (row*line>900) {
			trace("数量太大,运算困难,按默认10*10进行切图");
			return;
		}
		_row = row;
		_line = line;
	}
	public function setPosition(x:Number, y:Number) {
		//设置
		if (x<0 || y<0) {
			trace("超出场景范围,按默认(0,0)位置进行摆放");
			return;
		}
		_x = x;
		_y = y;
		if (_pieceBoard<>undefined) {
			_pieceBoard._x = _x;
			_pieceBoard._y = _y;
		}
	}
	public function getPieceBoard():MovieClip {
		//取得碎片载体
		return _pieceBoard;
	}
	public function toString():String {
		return "Puzzle::凹凸形状的拼图切割";
	}
	/**
	* Private methods
	*/
	private function loadImage(url:String) {
		_newURL = url;
		try {
			_imageLoader.loadClip(_newURL, _imageM);
		} catch (e:Error) {
			trace(e);
		}
	}
	private function onLoadStart(target:MovieClip) {
		target._visible = false;
		dispatchEvent({type:"onStart", target:this});
	}
	private function onLoadError(target:MovieClip, errorCode:String) {
		dispatchEvent({type:"onError", target:this});
		trace("errorCode:"+errorCode);
		trace("出错，继续读取上张图片");
		_newURL = _oldURL;
		loadImage(_newURL);
	}
	private function onLoadInit(target:MovieClip) {
		dispatchEvent({type:"onInit", target:this});
		_oldURL = _newURL;
		if (target._width<10 || target._height<10) {
			throw new Error("图片太小,不适合切割!");
		}
		if (isNaN(_imageMaxW+_imageMaxH)) {
			_imageMaxW = _imageMaxH=600;
		}
		if (isNaN(_row+_line)) {
			_row = 10;
			_line = 10;
		}
		_imageW = target._width>_imageMaxW ? _imageMaxW : target._width;
		_imageH = target._height>_imageMaxH ? _imageMaxH : target._height;
		_pieceBoard.removeMovieClip();
		mcToBitmap(target);
	}
	private function mcToBitmap(mc:MovieClip) {
		_imageBitmap = new BitmapData(_imageW, _imageH, true, 0x00ffffff);
		_imageBitmap.draw(mc);
		//隐藏掉
		_pieceBoard = _path.createEmptyMovieClip("pieceBoard", _path.getNextHighestDepth());
		_pieceBoard._x = _x;
		_pieceBoard._y = _y;
		bitmapCut();
	}
	private function pieceSet() {
		_pieceW = _imageW/_line;
		_pieceH = _imageH/_row;
		_pieceMinWH = Math.min(_pieceW, _pieceH);
		_pieceD = _pieceMinWH/_pieceD_k;
		_pieceOW = _pieceMinWH/_pieceO_k;
		_pieceOH = _pieceOW/_pieceOWH_k;
	}
	private function getRndD():Number {
		//返回与边界错开的高度
		return _pieceD-Math.random()*2*_pieceD;
	}
	private function drawPiece(mc:MovieClip, dotArr:Array):Void {
		with (mc) {
			lineStyle(0);
			moveTo(0, 0);
			trace("=====>"+"-->"+dotArr.length);
			for (var k:Number = 0; k<dotArr.length; k++) {
				if (dotArr[k].x<>undefined) {
					lineTo(dotArr[k].x, dotArr[k].y);
					trace("11k"+"-->"+dotArr[k].x+"-->"+dotArr[k].y);
				} else {
					curveTo(dotArr[k][0].x, dotArr[k][0].y, dotArr[k][1].x, dotArr[k][1].y);
					trace("00k"+"-->"+dotArr[k][0].x+"-->"+ dotArr[k][0].y+"-->"+ dotArr[k][1].x+"-->"+ dotArr[k][1].y);
				}
			}
			endFill();
		}
	}
	private function getOvalDotArray(mc:MovieClip, position:String):Array {
		var rnd:Number = random(2) ? 1 : -1;
		var circleDotArr:Array = [];
		switch (position) {
		case "right" :
			var a0:Point = new Point(_pieceW+getRndD(), (_pieceH-_pieceOW)/2+_pieceOW/4-Math.random()*_pieceOW/2);
			var a1:Array = [new Point(a0.x+rnd*(_pieceOH/2), a0.y-_pieceOW/2), new Point(a0.x+rnd*_pieceOH, a0.y)];
			var a2:Array = [new Point(a0.x+rnd*(_pieceOH+_pieceOW/3), a0.y+_pieceOW/2), new Point(a0.x+rnd*_pieceOH, a0.y+_pieceOW)];
			var a3:Array = [new Point(a0.x+rnd*_pieceOH/2, a0.y+_pieceOW+_pieceOW/2), new Point(a0.x, a0.y+_pieceOW)];
			circleDotArr = [a0, a1, a2, a3];
			break;
		case "down" :
			var a0:Point = new Point(_pieceW-((_pieceW-_pieceOW)/2+_pieceOW/4-Math.random()*_pieceOW/2), _pieceH+getRndD());
			var a1:Array = [new Point(a0.x+_pieceOW/2, a0.y+rnd*(_pieceOH/2)), new Point(a0.x, a0.y+rnd*_pieceOH)];
			var a2:Array = [new Point(a0.x-_pieceOW/2, a0.y+rnd*(_pieceOH+_pieceOW/3)), new Point(a0.x-_pieceOW, a0.y+rnd*_pieceOH)];
			var a3:Array = [new Point(a0.x-_pieceOW-_pieceOW/2, a0.y+rnd*_pieceOH/2), new Point(a0.x-_pieceOW, a0.y)];
			circleDotArr = [a0, a1, a2, a3];
			break;
		}
		return circleDotArr;
	}
	private function getAllDotArray(mc:MovieClip):Array {
		var allDotArray:Array = [];
		//a,b,c,d四面
		if (mc.i == 0) { //左
			mc.a = [];
		} else {
			var tempArray:Array = mc._parent["Piece"+(Number(mc._name.substr(5))-_line)].c;
			var a:Array = new Array(4);
			a[0] = new Point(tempArray[3][1].x, tempArray[3][1].y-_pieceH);
			a[1] = [new Point(tempArray[3][0].x, tempArray[3][0].y-_pieceH), new Point(tempArray[2][1].x, tempArray[2][1].y-_pieceH)];
			a[2] = [new Point(tempArray[2][0].x, tempArray[2][0].y-_pieceH), new Point(tempArray[1][1].x, tempArray[1][1].y-_pieceH)];
			a[3] = [new Point(tempArray[1][0].x, tempArray[1][0].y-_pieceH), new Point(tempArray[0].x, tempArray[0].y-_pieceH)];
			mc.a = a;
		}
		if (mc.j == 0) { //上
			mc.d = [];
		} else {
			var tempArray:Array = mc._parent["Piece"+(Number(mc._name.substr(5))-1)].b;
			var a:Array = new Array(4);
			a[0] = new Point(tempArray[3][1].x-_pieceW, tempArray[3][1].y);
			a[1] = [new Point(tempArray[3][0].x-_pieceW, tempArray[3][0].y), new Point(tempArray[2][1].x-_pieceW, tempArray[2][1].y)];
			a[2] = [new Point(tempArray[2][0].x-_pieceW, tempArray[2][0].y), new Point(tempArray[1][1].x-_pieceW, tempArray[1][1].y)];
			a[3] = [new Point(tempArray[1][0].x-_pieceW, tempArray[1][0].y), new Point(tempArray[0].x-_pieceW, tempArray[0].y)];
			mc.d = a;
		}
		if (mc.i == _row-1) {//右
			mc.c = [];
		} else {
			mc.c = getOvalDotArray(mc, "down");
		}
		if (mc.j == _line-1) { //下
			mc.b = [];
		} else {
			mc.b = getOvalDotArray(mc, "right");
		}
		allDotArray = allDotArray.concat(mc.a); 
		allDotArray.push(new Point(_pieceW, 0));
		allDotArray = allDotArray.concat(mc.b);
		allDotArray.push(new Point(_pieceW, _pieceH));
		allDotArray = allDotArray.concat(mc.c);
		allDotArray.push(new Point(0, _pieceH));
		allDotArray = allDotArray.concat(mc.d);
		return allDotArray;
	}
}
