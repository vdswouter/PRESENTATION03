package be.devine.cp3.view.components {
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.VO.SlideVO;
import be.devine.cp3.factory.view.TextfieldFactory;
import be.devine.cp3.model.AppModel;

import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
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
    private var listCon:Sprite;
    private var listItem:TextField;
    private var fotoLoader:Loader;
    private var foto:Image;
    private var stageWidth:uint;
    private var stageHeight:uint;

    // Constructor
    public function Slide(binnenKomendeSlideVO:SlideVO = null, resize:Boolean = true) {

        appmodel = AppModel.getInstance();
        if(binnenKomendeSlideVO != null){
            slidevo = binnenKomendeSlideVO;
        }else{
            slidevo = appmodel.slides[appmodel.currentSlide];
        }
        settings = appmodel.settingsvo;

        stageWidth = appmodel.windowWidth;
        stageHeight = appmodel.windowHeight;

        titleConfig = {};
        titleConfig.width = stageWidth * .8;
        titleConfig.color = settings.titleColor;
        titleConfig.fontName = settings.titleFont;
        titleConfig.fontSize = settings.titleFontSize;

        listConfig = {};
        listConfig.color = settings.listColor;
        listConfig.fontName = settings.listFont;
        listConfig.fontSize = settings.listFontSize;
        listConfig.height = settings.listFontSize + 10;
        listConfig.bullet = settings.bullet;

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
        if(resize){
            appmodel.addEventListener(AppModel.RESIZED, OnResize);
        }
    }

    private function OnResize(e:starling.events.Event):void {

        switch (slidevo.slideType) {
            case 'title':
                title.x = appmodel.windowWidth /2 - title.width /2;
                title.y = appmodel.windowHeight /2 - title.height /2;
                break;
            case 'title+list':
                title.x = appmodel.windowWidth /2 - title.width /2;
                title.y = 40;

                listCon.x = title.x;
                listCon.y = stageHeight /2 - listCon.height /2;
                if(listCon.y <= title.y + title.height){
                    listCon.y = title.y + title.height + 30;
                }
                break;
            case 'image':
                var scaleImageX:Number;
                var scaleImageY:Number;
                var scaleGetalX:Number;
                var scaleGetalY:Number;

                scaleGetalY =  (appmodel.windowHeight * .8) / foto.height;
                scaleImageY = foto.scaleY * scaleGetalY;
                scaleGetalX = (appmodel.windowWidth * .8) / foto.width ;
                scaleImageX = foto.scaleX * scaleGetalX;

                if(scaleImageX < scaleImageY){
                    foto.scaleX = foto.scaleY = scaleImageX;
                }else{
                    foto.scaleX = foto.scaleY = scaleImageY;
                }
//                if(appmodel.windowWidth > appmodel.windowHeight){
//                    trace('[] if');
//                    scaleGetal =  (appmodel.windowHeight * .8) / foto.height;
//                    scaleImage = foto.scaleX * scaleGetal;
//                }else{
//                    trace('[] else');
//                    scaleGetal = (appmodel.windowWidth * .8) / foto.width ;
//                    scaleImage = foto.scaleX * scaleGetal;
//                }
//                if(scaleImage <= 0){
//                    scaleImage = 0.00001;
//                }
                    if(scaleImageX < scaleImageY){
                        foto.scaleX = foto.scaleY = scaleImageX;
                    }else{
                        foto.scaleX = foto.scaleY = scaleImageY;
                    }


//                if(foto.width < foto.height){
//                    scaleImage = (stageWidth / 3.4) / foto.width;
//                }else{
//                    scale = (stageHeight / 3.4) / foto.height;
//                }
//
//                if(scale > 1) scale = 1;
//                foto.scaleX = foto.scaleY = scale;


                trace('[SLIDE] SCALE:', scaleImageX + "parent: "+this.parent);
                foto.x = (appmodel.windowWidth - foto.width) /2;
                foto.y = (appmodel.windowHeight - foto.height) /2;
                break;
            case 'image+list':
                title.x = appmodel.windowWidth /2 - title.width /2;
                title.y = 40;
                listCon.x = appmodel.windowWidth /2;
                listCon.y = appmodel.windowHeight /2 - listCon.height /2;
                if(listCon.y <= title.y + title.height +30){
                    listCon.y = title.y + title.height + 30;
                }
                var scaleX:Number;
                var scaleY:Number;
                var scaleGX:Number;
                var scaleGY:Number;

                scaleGY =  (appmodel.windowHeight * .4) / foto.height;
                scaleY = foto.scaleY * scaleGY;
                scaleGX = (appmodel.windowWidth * .4) / foto.width ;
                scaleX = foto.scaleX * scaleGX;

                if(scaleX < scaleY){
                    foto.scaleX = foto.scaleY = scaleX;
                }else{
                    foto.scaleX = foto.scaleY = scaleY;
                }
                foto.x = appmodel.windowWidth /2 - foto.width - 100;
                foto.y = appmodel.windowHeight /2 - foto.height /2;
                if(foto.y <= title.y + title.height + 50){
                    foto.y = title.y + title.height + 50;
                }
                break;
        }
    }

    public function createTitle():void {

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
        title.x = stageWidth / 2 - title.width / 2;
        title.y = 40;
        addChild(title);

        var yPos:uint = 0;
        listCon = new Sprite();
        listConfig.width = title.width;
        listConfig.hAlign = HAlign.LEFT;
        listConfig.vAlign = VAlign.CENTER;

        for each(var list:String in slidevo.list) {
            listConfig.text = list;
            listItem = TextfieldFactory.createTextField(listConfig);
            listItem.y = yPos;
            yPos += listItem.height + 10;
            listCon.addChild(listItem);
        }

        listCon.x = title.x;
        listCon.y = stageHeight / 2 - listCon.height / 2;
        if (listCon.y <= title.y + title.height) {
            listCon.y = title.y + title.height + 30;
        }
        addChild(listCon);
    }

    private function createImage():void {

        fotoLoader = new Loader();
        fotoLoader.load(new URLRequest(slidevo.img_path));
        fotoLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, SingleFotoLoaded);
    }

    private function SingleFotoLoaded(event:flash.events.Event):void {

        var fotoBitmapData:BitmapData = new BitmapData(fotoLoader.width, fotoLoader.height);
        fotoBitmapData.draw(fotoLoader);
        var fotoTexture:Texture = Texture.fromBitmapData(fotoBitmapData);

        foto = new Image(fotoTexture);
        var scaleImageX:Number;
        var scaleImageY:Number;
        var scaleGetalX:Number;
        var scaleGetalY:Number;

        scaleGetalY =  (appmodel.windowHeight * .8) / foto.height;
        scaleImageY = foto.scaleY * scaleGetalY;
        scaleGetalX = (appmodel.windowWidth * .8) / foto.width ;
        scaleImageX = foto.scaleX * scaleGetalX;

        if(scaleImageX < scaleImageY){
            foto.scaleX = foto.scaleY = scaleImageX;
        }else{
            foto.scaleX = foto.scaleY = scaleImageY;
        }
        foto.x = (stageWidth - foto.width) /2;
        foto.y = (stageHeight - foto.height) /2;
        addChild(foto);
    }

    private function createImageList():void {

        fotoLoader = new Loader();
        fotoLoader.load(new URLRequest(slidevo.img_path));
        fotoLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, ListFotoLoaded);

        titleConfig.text = slidevo.title;
        titleConfig.height = 140;
        titleConfig.hAlign = HAlign.CENTER;
        titleConfig.vAlign = VAlign.TOP;
        title = TextfieldFactory.createTextField(titleConfig);
        title.x = stageWidth /2 - title.width /2;
        title.y = 40;
        addChild(title);

        var yPos:uint = 0;
        listCon = new Sprite();

        listConfig.width = 400;
        listConfig.hAlign = HAlign.LEFT;
        listConfig.vAlign = VAlign.CENTER;

        for each( var list:String in slidevo.list){
            listConfig.text = list;
            listItem = TextfieldFactory.createTextField(listConfig);
            listItem.y = yPos;
            yPos += listItem.height + 10;
            listCon.addChild(listItem);
        }

        listCon.x = stageWidth /2;
        listCon.y = stageHeight /2 - listCon.height /2;
        if(listCon.y <= title.y + title.height){
            listCon.y = title.y + title.height + 30;
        }
        addChild(listCon);
    }

    private function ListFotoLoaded(event:flash.events.Event):void {

        var fotoBitmapData:BitmapData = new BitmapData(fotoLoader.width, fotoLoader.height);
        fotoBitmapData.draw(fotoLoader);
        var fotoTexture:Texture = Texture.fromBitmapData(fotoBitmapData);

        foto = new Image(fotoTexture);
        var scaleX:Number;
        var scaleY:Number;
        var scaleGX:Number;
        var scaleGY:Number;

        scaleGY =  (appmodel.windowHeight * .4) / foto.height;
        scaleY = foto.scaleY * scaleGY;
        scaleGX = (appmodel.windowWidth * .4) / foto.width ;
        scaleX = foto.scaleX * scaleGX;

        if(scaleX < scaleY){
            foto.scaleX = foto.scaleY = scaleX;
        }else{
            foto.scaleX = foto.scaleY = scaleY;
        }

        foto.x = stageWidth /2 - foto.width - 100;
        foto.y = stageHeight /2 - foto.height /2;
        if(foto.y <= title.y + title.height + 50){
            foto.y = title.y + title.height + 50;
        }
        addChild(foto);
    }
}
}
