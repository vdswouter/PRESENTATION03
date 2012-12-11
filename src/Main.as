package {

import be.devine.cp3.Application;
import be.devine.cp3.model.AppModel;

import flash.display.MovieClip;
import flash.display.Screen;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;

import starling.core.Starling;
import starling.events.Event;

public class Main extends MovieClip {

    private var starling:Starling;
    private var appmodel:AppModel;

    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        appmodel = AppModel.getInstance();

        stage.nativeWindow.visible = true;
        stage.nativeWindow.width = 1024;
        stage.nativeWindow.height = 768;
        stage.nativeWindow.x = (Screen.mainScreen.bounds.width - 1024) /2;
        stage.nativeWindow.y = (Screen.mainScreen.bounds.height - 768) /2;
        stage.nativeWindow.title = 'Presentation Engine';
        stage.frameRate = 60;


        starling = new Starling(Application,stage);
        starling.start();

        stage.addEventListener(flash.events.Event.RESIZE, resizeHandler );
        appmodel.addEventListener(AppModel.FULLSCREEN, onFullscreen)

    }


    private function resizeHandler(event:flash.events.Event):void {
        appmodel.windowWidth = stage.nativeWindow.width;
        appmodel.windowHeight = stage.nativeWindow.height;
    }

    private function onFullscreen(event:starling.events.Event):void {
        if(appmodel.fullscreen){
            stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        }else{
            stage.displayState = StageDisplayState.NORMAL;
        }
    }
}
}
