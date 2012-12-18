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
    private var _scaleImgX:Number;
    private var _scaleImgY:Number;


    // Constructor
    public function Slide(binnenKomendeSlideVO:SlideVO = null, resizeAble:Boolean = true) {

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
                trace("[SLIDE] Er is geen juist slidetype meegegeven");
                break;
        }

        if(resizeAble){
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

                listCon.x = (appmodel.windowWidth - appmodel.windowWidth *.8) /2;
                listCon.y = appmodel.windowHeight /2 - listCon.height /2;
                if(listCon.y <= title.y + title.height + 20){
                    listCon.y = title.y + title.height + 20;
                }
            break;

            case 'image':
                scaleImgX = foto.scaleX * ((appmodel.windowWidth * .8) / foto.width);
                scaleImgY = foto.scaleY * ((appmodel.windowHeight * .8) / foto.height);

                if(scaleImgX < scaleImgY){
                    foto.scaleX = foto.scaleY = scaleImgX;
                }else{
                    foto.scaleX = foto.scaleY = scaleImgY;
                }

                foto.x = (appmodel.windowWidth - foto.width) /2;
                foto.y = (appmodel.windowHeight - foto.height) /2;
            break;

            case 'image+list':
                title.x = appmodel.windowWidth /2 - title.width /2;
                title.y = 40;
                listCon.x = appmodel.windowWidth /2;
                listCon.y = appmodel.windowHeight /2 - listCon.height /2;
                if(listCon.y <= title.y + title.height + 20){
                    listCon.y = title.y + title.height + 20;
                }

                scaleImgX = foto.scaleX * ((appmodel.windowWidth * .4) / foto.width);
                scaleImgY = foto.scaleY * ((appmodel.windowHeight * .5) / foto.height);

                if(scaleImgX < scaleImgY){
                    foto.scaleX = foto.scaleY = scaleImgX;
                }else{
                    foto.scaleX = foto.scaleY = scaleImgY;
                }

                foto.x = appmodel.windowWidth /4 - foto.width /2;
                foto.y = appmodel.windowHeight / 2 - foto.height /2;
                if(foto.y <= title.y + title.height + 20){
                    foto.y = title.y + title.height + 20;
                }
            break;
        }
    }

    public function removeResize():void {
        appmodel.removeEventListener(AppModel.RESIZED, OnResize);
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
        listCon.y = appmodel.windowHeight /2 - listCon.height /2;
        if (listCon.y <= title.y + title.height + 20) {
            listCon.y = title.y + title.height + 20;
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

        scaleImgY = foto.scaleY * ((appmodel.windowHeight * .8) / foto.height);
        scaleImgX = foto.scaleX * ((appmodel.windowWidth * .8) / foto.width);

        if(scaleImgX < scaleImgY){
            foto.scaleX = foto.scaleY = scaleImgX;
        }else{
            foto.scaleX = foto.scaleY = scaleImgY;
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

        listConfig.width = stageWidth/2 - 100;
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
        listCon.y = appmodel.windowHeight /2 - listCon.height /2;
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

        scaleImgX = foto.scaleX * ((appmodel.windowWidth * .4) / foto.width);
        scaleImgY = foto.scaleY * ((appmodel.windowHeight * .5) / foto.height);

        if(scaleImgX < scaleImgY){
            foto.scaleX = foto.scaleY = scaleImgX;
        }else{
            foto.scaleX = foto.scaleY = scaleImgY;
        }

        foto.x = stageWidth /4 - foto.width/2;
        foto.y = appmodel.windowHeight /2 - foto.height /2;

        if(foto.y <= title.y + title.height + 20){
            foto.y =  title.y + title.height + 20;
        }
        addChild(foto);
    }

    public function get scaleImgX():Number {
        return _scaleImgX;
    }

    public function set scaleImgX(value:Number):void {

        if(_scaleImgX != value){
            _scaleImgX = value;
            if(_scaleImgX > 1) _scaleImgX = 1;
        }
    }

    public function get scaleImgY():Number {
        return _scaleImgY;
    }

    public function set scaleImgY(value:Number):void {

        if(_scaleImgY != value){
            _scaleImgY = value;
            if(_scaleImgY > 1) _scaleImgY = 1;
        }
    }
}
}
