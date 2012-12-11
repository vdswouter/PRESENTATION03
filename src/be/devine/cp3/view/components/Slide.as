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

    private var titleConfig:Object;
    private var listConfig:Object;
    private var title:TextField;
    private var listItem:TextField;
    private var fotoLoader:Loader;
    private var foto:Image;
    private var stageWidth:uint;
    private var stageHeight:uint;

    // Constructor
    public function Slide() {

        appmodel = AppModel.getInstance();
        slidevo = appmodel.slides[appmodel.currentSlide];
        settings = appmodel.settingsvo;

        stageWidth = Starling.current.stage.stageWidth;
        stageHeight = Starling.current.stage.stageHeight;

        titleConfig = {};
        titleConfig.width = stageWidth * 80/100;
        titleConfig.color = settings.titleColor;
        titleConfig.fontName = settings.titleFont;
        titleConfig.fontSize = settings.titleFontSize;

        listConfig = {};
        listConfig.color = settings.listColor;
        listConfig.fontName = settings.listFont;
        listConfig.fontSize = settings.listFontSize;


//        trace("[SLIDE] slidetype: "+slidevo.slideType);
        switch (slidevo.slideType) {
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

        titleConfig.text = slidevo.title;
        titleConfig.height = stageHeight *.8;
        titleConfig.hAlign = HAlign.CENTER;
        titleConfig.vAlign = VAlign.CENTER;
        title = TextfieldFactory.createTextField(titleConfig);
        title.x = stageWidth /2 - title.width /2;
        title.y = stageHeight /2 - title.height /2;
        addChild(title);
    }

    private function createTitleList():void {

        titleConfig.text = slidevo.title;
        titleConfig.height = 140;
        titleConfig.hAlign = HAlign.CENTER;
        titleConfig.vAlign = VAlign.TOP;
        title = TextfieldFactory.createTextField(titleConfig);
        title.x = stageWidth /2 - title.width /2;
        title.y = 40;
        addChild(title);

        var yPos:uint = 0;
        var listCon:Sprite = new Sprite();
        listConfig.width = stageWidth /2;
        listConfig.height = 50;
        listConfig.hAlign = HAlign.LEFT;
        listConfig.vAlign = VAlign.CENTER;

        for each( var list:String in slidevo.list ){
            listConfig.text = list;
            listItem = TextfieldFactory.createTextField(listConfig);
            //TODO valign top klopt gelijk niet
            listItem.y = yPos;
            yPos += listItem.height + 10;
            listCon.addChild(listItem);
        }

        listCon.x = title.x;
        listCon.y = title.y + title.height + 30;
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

        titleConfig.text = slidevo.title;
        titleConfig.height = 140;
        titleConfig.hAlign = HAlign.CENTER;
        titleConfig.vAlign = VAlign.TOP;
        title = TextfieldFactory.createTextField(titleConfig);
        title.x = stageWidth /2 - title.width /2;
        title.y = 40;
        addChild(title);

        var yPos:uint = 0;
        var listCon:Sprite = new Sprite();
        listConfig.width = 400;
        listConfig.height = 50;
        listConfig.hAlign = HAlign.LEFT;
        listConfig.vAlign = VAlign.CENTER;

        for each( var list:String in slidevo.list){
            listItem = TextfieldFactory.create(400, 50, list, true, settings.listColor, settings.listFont, settings.listFontSize );
            listConfig.text = list;
            listItem = TextfieldFactory.createTextField(listConfig);
            listItem.y = yPos;
            yPos += listItem.height + 10;
            listCon.addChild(listItem);
        }

        listCon.x = stageWidth /2;
        listCon.y = title.y + title.height + 30;
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
