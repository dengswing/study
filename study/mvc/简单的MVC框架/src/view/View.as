package view{
   
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
   
    import model.ModelLocator;
    import control.Controller;
   
    public class View extends Sprite{
       
        private var _model:ModelLocator;
        private var _controller:Controller;
        private var time_txt:TextField;
   
        public function View(model:ModelLocator,controller:Controller):void{
            _model = model;
            _controller = controller;
            time_txt = new TextField();
            addChild(time_txt);
            _model.addEventListener("changeHour",changeTimeHandler);
            _model.addEventListener("changeMinutes",changeTimeHandler);
            _model.addEventListener("changeSecond",changeTimeHandler);
           
            _controller.startTime();
        }
       
        private function changeTimeHandler(event:Event):void{
            time_txt.text = _model.hour+" : "+_model.minutes+" : "+_model.second;
        }
   
    }
}	