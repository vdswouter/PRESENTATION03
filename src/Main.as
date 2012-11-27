package {

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

public class Main extends MovieClip {


    private var app:DisplayObject;
    private var preloader:Sprite = new Sprite();


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


        new FontContainer();
        OverloopFonts.overloopGeembeddeFontsInSWF();

        addChild(preloader);
        preloader.x = stage.stageWidth/2;
        preloader.y = stage.stageHeight/2;

        if (loaderInfo.bytesLoaded >= loaderInfo.bytesTotal) {
            startApplication();
        } else {
            loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            loaderInfo.addEventListener(Event.COMPLETE, completeHandler);
        }
    }

    private function progressHandler(event:ProgressEvent):void {
        trace(event.bytesLoaded, event.bytesTotal);
        preloader.graphics.clear();
        preloader.graphics.beginFill(0xAAAAAA);
        preloader.graphics.drawRect(0,0,(event.bytesLoaded/event.bytesTotal)*100,10);
        preloader.graphics.endFill();
        preloader.rotation = (event.bytesLoaded/event.bytesTotal)*360;
    }

    private function completeHandler(event:Event):void {

        startApplication();
    }

    private function startApplication() {
        trace("start de app");
        gotoAndStop("start");
        var appClass:Class = getDefinitionByName("be.devine.cp3.Application") as Class;
        app = new appClass();
        addChild(app);

    }
    }



}
