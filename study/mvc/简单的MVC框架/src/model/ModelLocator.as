package model{
   
    import flash.events.EventDispatcher;
    import flash.events.Event;
   
    public class ModelLocator extends EventDispatcher{
   
        private var _hour:String;
       
        private var _minutes:String;
       
        private var _second:String;
       
        public function ModelLocator():void{
        }
       
        public function get hour():String{
            return _hour;
        }
       
        public function set hour(value:String):void{
            _hour = value;
            dispatchEvent(new Event("changeHour"));
        }
       
        public function get minutes():String{
            return _minutes;
        }
       
        public function set minutes(value:String):void{
            _minutes = value;
            dispatchEvent(new Event("changeMinutes"));
        }
       
        public function get second():String{
            return _second;
        }
       
        public function set second(value:String):void{
            _second = value;
            dispatchEvent(new Event("changeSecond"));
        }
   
    }
  }