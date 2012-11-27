package be.devine.cp3.view.components {
import be.devine.cp3.factory.GradientFactory;
import be.devine.cp3.factory.TextfieldFactory;
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.VO.SlideVO;

import flash.display.DisplayObject;

import flash.display.Loader;

import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class Slide extends Sprite {

    // Properties
    private var slide:Sprite;

    private var slidevo:SlideVO;
    private var settings:SettingsVO;

    private var title:TextField;

    private var foto:Loader;


    // Constructor
    public function Slide(slidevo:SlideVO, settings:SettingsVO) {

        this.slidevo = slidevo;
        this.settings = settings;



        slide = new Sprite();

        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(e:Event):void {
        trace("[slide] "+slidevo.slideType);
        switch( slidevo.slideType ){
            case 'title':
                createTitle();
                break;
            case 'title+list':
                createTitleList();
                break;
            case 'image':
                createImage();
                break;
            case 'image+list':
                createImageList();
                break;
            default:
                trace("[SLIDE] Er is geen juist slidetype meegegeven");
                break;
        }
    }

    private function createTitle():void {

        trace('[SLIDE] createTitle');

        title = TextfieldFactory.create(new TextFormat(settings.titleFont, settings.titleFontSize, settings.titleColor), this, 0, 0, slidevo.Title);
        title.x = stage.stageWidth / 2 - title.width / 2;
        title.y = stage.stageHeight / 2 - title.height / 2;
    }

    private function createTitleList():void {

        trace('[SLIDE] createTitleList');

        title = TextfieldFactory.create(new TextFormat(settings.titleFont, settings.titleFontSize, settings.titleColor), this, 0, 0, slidevo.Title);
        title.x = stage.stageWidth /2 - title.width /2;
        title.y = 80;

        var yPos:uint = 0;
        var listCon:Sprite = new Sprite();

        for each( var list:String in slidevo.list){
            var listItem:TextField = TextfieldFactory.create(new TextFormat(settings.listFont, settings.listFontSize, settings.listColor), null, 0, yPos, list);
            yPos += listItem.height + 10;
            listCon.addChild(listItem);
        }

        listCon.x = stage.stageWidth /2 - listCon.width /2;
        listCon.y = stage.stageHeight /2 - listCon.height /2;
        addChild(listCon);
    }

    private function createImage():void {
        trace('[SLIDE] createImage');

        foto = new Loader();
        foto.load(new URLRequest(slidevo.img_path));
        foto.contentLoaderInfo.addEventListener(Event.COMPLETE, SingleFotoLoaded);
    }

    private function SingleFotoLoaded(event:Event):void {

        var scale:Number;
        if(foto.width << foto.height){
            scale = (500/foto.height);
        }else{
            scale = (600/foto.width);
        }
        foto.scaleX = foto.scaleY = scale;
        foto.x = (stage.stageWidth - foto.width) /2;
        foto.y = (stage.stageHeight - foto.height) /2;
        addChild(foto);

    }



    private function createImageList() {
        trace('[SLIDE] createImageList');

        foto = new Loader();
        foto.load(new URLRequest(slidevo.img_path));
        foto.contentLoaderInfo.addEventListener(Event.COMPLETE, ListFotoLoaded);

        title = TextfieldFactory.create(new TextFormat(settings.titleFont, settings.titleFontSize, settings.titleColor), this, 0, 0, slidevo.Title);
        title.x = stage.stageWidth /2 - title.width /2;
        title.y = 80;

        var yPos:uint = 0;
        var listCon:Sprite = new Sprite();

        for each( var list:String in slidevo.list){
            var listItem:TextField = TextfieldFactory.create(new TextFormat(settings.listFont, settings.listFontSize, settings.listColor), null, 0, yPos, list);
            yPos += listItem.height + 10;
            listCon.addChild(listItem);
        }

        listCon.x = stage.stageWidth /2 - listCon.width /2;
        listCon.y = stage.stageHeight /2 - listCon.height /2;
        addChild(listCon);
    }

    private function ListFotoLoaded(event:Event):void {
        var scale:Number;
        if(foto.width << foto.height){
            scale = (300/foto.height);
        }else{
            scale = (300/foto.width);
        }
        foto.scaleX = foto.scaleY = scale;
        foto.x = (stage.stageWidth - foto.width) /8;
        foto.y = (stage.stageHeight - foto.height) /2;
        addChild(foto);
    }


}
}
