package control{
   
    import flash.utils.Timer;
    import flash.events.TimerEvent;
   
    import model.ModelLocator;
   
    public class Controller{
       
        private var _model:ModelLocator;
        private var _timer:Timer;
       
        public function Controller(model:ModelLocator):void{
            _model = model;
        }
       
        public function startTime():void {			
            _timer = new Timer(1000,0);
            _timer.addEventListener(TimerEvent.TIMER,timerHandler);
            _timer.start();
        }
       
        private function timerHandler(event:TimerEvent):void{
            var nowDate:Date = new Date();
            _model.hour = nowDate.getHours() > 9?String(nowDate.getHours()):"0" + nowDate.getHours();			
            _model.minutes = nowDate.getMinutes() > 9?String(nowDate.getMinutes()):"0" + nowDate.getMinutes();			
            _model.second = nowDate.getSeconds() > 9?String(nowDate.getSeconds()):"0" + nowDate.getSeconds();			
        }
       
    }
}