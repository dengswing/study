package com.ryanliu.math
{

    public class sinObject extends Object
    {
        public var _useAngle:Boolean;
        private var _angIncrement:Number;
        private var _ang:Number;
        private var _swing:Number;

        public function sinObject(param1:Number, param2:Number, param3:Number, param4:Boolean = true)
        {
            _swing = param1;
            _ang = param2;
            _angIncrement = param3;
            _useAngle = param4;
            return;
        }// end function

        public function get cosValue() : Number
        {
            if (_useAngle)
            {
                return _swing * Math.cos(_ang * Math.PI / 180);
            }
            return _swing * Math.cos(_ang);
        }// end function

        public function run() : void
        {
            _ang = _ang + _angIncrement;
            return;
        }// end function

        public function get sinValue() : Number
        {
            if (_useAngle)
            {
                return _swing * Math.sin(_ang * Math.PI / 180);
            }
            return _swing * Math.sin(_ang);
        }// end function

    }
}
