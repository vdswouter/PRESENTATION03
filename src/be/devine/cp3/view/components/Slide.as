package be.devine.cp3.view.components {
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.VO.SlideVO;
import be.devine.cp3.factory.view.TextfieldFactory;
import be.devine.cp3.model.AppModel;

import flash.display.BitmapData;

import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Slide extends Sprite {

    // Properties
    private var appmodel:AppModel;
    public var slidevo:SlideVO;
    private var settings:SettingsVO;

    private var title:TextField;

    private var fotoLoader:Loader;
    private var foto:Image;

    // Constructor
    public function Slide() {

        appmodel = AppModel.getInstance();
        slidevo = appmodel.slides[appmodel.currentSlide];
        settings = appmodel.settingsvo;

//        trace("[SLIDE] slidetype: "+slidevo.slideType);
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
//                trace("[SLIDE] Er is geen juist slidetype meegegeven");
                break;
        }
    }

    private function createTitle():void {

        title = TextfieldFactory.create(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, slidevo.title, true, settings.titleColor, settings.titleFont, settings.titleFontSize, HAlign.CENTER, VAlign.CENTER);
        addChild(title);
    }

    private function createTitleList():void {

        title = TextfieldFactory.create(Starling.current.stage.stageWidth, 60, slidevo.title, true, settings.titleColor, settings.titleFont, settings.titleFontSize, HAlign.CENTER);
        title.x = Starling.current.stage.stageWidth /2 - title.width /2;
        title.y = 80;
        addChild(title);

        var yPos:uint = 0;
        var listCon:Sprite = new Sprite();

        for each( var list:String in slidevo.list ){
            var listItem:TextField = TextfieldFactory.create(400, 50, list, true, settings.listColor, settings.listFont, settings.listFontSize );
            listItem.y = yPos;
            yPos += listItem.height + 10;
            listCon.addChild(listItem);
        }

        listCon.x = Starling.current.stage.stageWidth /2 - listCon.width /2;
        listCon.y = Starling.current.stage.stageHeight /2 - listCon.height /2;
        addChild(listCon);
    }

    private function createImage():void {

        fotoLoader = new Loader();
        fotoLoader.load(new URLRequest(slidevo.img_path));
        fotoLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, SingleFotoLoaded);
    }

    private function SingleFotoLoaded(event:Event):void {

        var fotoBitmapData:BitmapData = new BitmapData(fotoLoader.width, fotoLoader.height);
        fotoBitmapData.draw(fotoLoader);
        var fotoTexture:Texture = Texture.fromBitmapData(fotoBitmapData);

        foto = new Image(fotoTexture);
        var scale:Number;
        if(foto.width << foto.height){
            scale = (500/foto.height);
        }else{
            scale = (600/foto.width);
        }
        foto.scaleX = foto.scaleY = scale;
        foto.x = (Starling.current.stage.stageWidth - foto.width) /2;
        foto.y = (Starling.current.stage.stageHeight - foto.height) /2;
        addChild(foto);
    }

    private function createImageList():void {

        fotoLoader = new Loader();
        fotoLoader.load(new URLRequest(slidevo.img_path));
        fotoLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, ListFotoLoaded);

        title = TextfieldFactory.create(Starling.current.stage.stageWidth, 60, slidevo.title, true, settings.titleColor, settings.titleFont, settings.titleFontSize, HAlign.CENTER);
        title.x = Starling.current.stage.stageWidth /2 - title.width /2;
        title.y = 80;
        addChild(title);

        var yPos:uint = 0;
        var listCon:Sprite = new Sprite();

        for each( var list:String in slidevo.list){
            var listItem:TextField = TextfieldFactory.create(400, 50, list, true, settings.listColor, settings.listFont, settings.listFontSize );
            listItem.y = yPos;
            yPos += listItem.height + 10;
            listCon.addChild(listItem);
        }

        listCon.x = Starling.current.stage.stageWidth /2;
        listCon.y = Starling.current.stage.stageHeight /2 - listCon.height /2;
        addChild(listCon);
    }

    private function ListFotoLoaded(event:Event):void {

        var fotoBitmapData:BitmapData = new BitmapData(fotoLoader.width, fotoLoader.height);
        fotoBitmapData.draw(fotoLoader);
        var fotoTexture:Texture = Texture.fromBitmapData(fotoBitmapData);

        foto = new Image(fotoTexture);
        var scale:Number;
        if(foto.width << foto.height){
            scale = (300/foto.height);
        }else{
            scale = (300/foto.width);
        }
        foto.scaleX = foto.scaleY = scale;
        foto.x = (Starling.current.stage.stageWidth - foto.width) /8;
        foto.y = (Starling.current.stage.stageHeight - foto.height) /2;
        addChild(foto);
    }
}
}
