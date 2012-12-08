package {

import be.devine.cp3.Application;
import be.devine.cp3.utils.OverloopFonts;

import flash.display.DisplayObject;

import flash.display.MovieClip;
import flash.display.Screen;
import flash.display.Sprite;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.ProgressEvent;

import flash.utils.getDefinitionByName;

import starling.core.Starling;

public class Main extends MovieClip {



    public function Main() {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        stage.nativeWindow.visible = true;
        stage.nativeWindow.width = 1024;
        stage.nativeWindow.height = 768;
        stage.nativeWindow.x = (Screen.mainScreen.bounds.width - 1024) /2;
        stage.nativeWindow.y = (Screen.mainScreen.bounds.height - 768) /2;
        stage.nativeWindow.title = 'Presentation Engine';
        stage.frameRate = 60;

        var starling:Starling = new Starling(Application,stage);
        starling.start();

    }


    }



}
