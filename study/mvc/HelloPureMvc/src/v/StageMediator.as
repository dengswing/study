/*
 PureMVC AS3 / Flash Demo - HelloFlash
 By Cliff Hall <clifford.hall@puremvc.org>
 Copyright(c) 2007-08, Some rights reserved.
 */
package v
{
    
    import context.ApplicationFacade;
    
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    
    import org.puremvc.as3.interfaces.*;
    import org.puremvc.as3.patterns.mediator.Mediator;

    /**
     * A Mediator for interacting with the Stage.
     */
    public class StageMediator extends Mediator implements IMediator
    {
        // Cannonical name of the Mediator
        public static const NAME:String = 'StageMediator';

        /**
         * Constructor. 
         */
        public function StageMediator( viewComponent:Object ) 
        {
            // pass the viewComponent to the superclass where 
            // it will be stored in the inherited viewComponent property
            super( NAME, viewComponent );
    
            // Listen for events from the view component 
      //      stage.addEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
       //     stage.addEventListener( MouseEvent.MOUSE_WHEEL, handleMouseWheel );
            
        }


        /**
         * List all notifications this Mediator is interested in.
         * <P>
         * Automatically called by the framework when the mediator
         * is registered with the view.</P>
         * 
         * @return Array the list of Nofitication names
         */
        override public function listNotificationInterests():Array 
        {
            return [ ApplicationFacade.STAGE_ADD_SPRITE,
					 ApplicationFacade.BALL_CLICK
                   ];
        }

        /**
         * Handle all notifications this Mediator is interested in.
         * <P>
         * Called by the framework when a notification is sent that
         * this mediator expressed an interest in when registered
         * (see <code>listNotificationInterests</code>.</P>
         * 
         * @param INotification a notification 
         */
        override public function handleNotification( note:INotification ):void 
        {
            switch ( note.getName() ) {
                
                // Create a new HelloSprite, 
				// Create and register its HelloSpriteMediator
				// and finally add the HelloSprite to the stage
                case ApplicationFacade.STAGE_ADD_SPRITE:
					var textShowSprite:TextShow = new TextShow();
					facade.registerMediator(new TextShowMediator(textShowSprite));
					stage.addChild(textShowSprite);
				
					createBall();
                    break;
				case ApplicationFacade.BALL_CLICK:
					createBall();
					break;
            }
        }
		
		private function createBall():void
		{
			var ball:Ball = new Ball();
			ball.x = Math.random() * 500;
			ball.y = Math.random() * 375;
			facade.registerMediator(new BallMediator(ball));
			stage.addChild(ball);
		}

		// The user has released the mouse over the stage
//        private function handleMouseUp(event:MouseEvent):void
//		{
//			sendNotification( ApplicationFacade.SPRITE_DROP );
//		}
//                    
//		// The user has released the mouse over the stage
//        private function handleMouseWheel(event:MouseEvent):void
//		{
//			sendNotification( ApplicationFacade.SPRITE_SCALE, event.delta );
//		}
                    
        /**
         * Cast the viewComponent to its actual type.
         * 
         * <P>
         * This is a useful idiom for mediators. The
         * PureMVC Mediator class defines a viewComponent
         * property of type Object. </P>
         * 
         * <P>
         * Here, we cast the generic viewComponent to 
         * its actual type in a protected mode. This 
         * retains encapsulation, while allowing the instance
         * (and subclassed instance) access to a 
         * strongly typed reference with a meaningful
         * name.</P>
         * 
         * @return stage the viewComponent cast to flash.display.Stage
         */
        protected function get stage():Stage{
            return viewComponent as Stage;
        }
    }
}