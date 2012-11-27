package be.devine.cp3.model {
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.VO.SlideVO;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class AppModel extends EventDispatcher {

    /**** VARIABELEN ****/
    public static const NAVBAR_PREVIOUS_SLIDE:String = 'navBarPreviousSlide';
    public static const NAVBAR_NEXT_SLIDE:String = 'navBarNextSlide';
    public static const CURRENT_SLIDE_CHANGED:String = 'currentSlideChanged';
    public static const XML_LOADED:String = 'xmlIsIngeladen';

    public static var instance:AppModel;

    public var slides:Vector.<SlideVO> = new Vector.<SlideVO>();
    public var settings:SettingsVO;

    private var _currentSlide:int = 1;


    /**** CONSTRUCTOR ****/
    public function AppModel(e:Enforcer) {
        if(e == null){
            throw new Error("appModel is a singleton");
        }
    }

    /**** METHODS ****/
    public static function getInstance():AppModel{
        if(instance == null){
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    public function load(UrlToXML:String):void{
        var xmlLoader:URLLoader = new URLLoader();
        xmlLoader.addEventListener( Event.COMPLETE, ParseXML );
        xmlLoader.load( new URLRequest(UrlToXML) );
    }

    private function ParseXML( e:Event ):void {

        var loadedXML:XML = new XML( e.currentTarget.data);

        settings = new SettingsVO();

        settings.backgroundType = loadedXML.project.theme.background.@style;
        settings.backgroundColor1 = uint("0x"+loadedXML.project.theme.background.color[0].text());
        if(settings.backgroundType == "solid"){
            settings.backgroundColor2 = settings.backgroundColor1;
        }else{
            settings.backgroundColor2 = uint("0x"+loadedXML.project.theme.background.color[1].text());
            settings.gradientType = loadedXML.project.theme.background.@type
        }
        settings.userName = loadedXML.project.user.name;
        settings.createdDate = loadedXML.project.user.created;
        settings.titleColor = uint("0x"+loadedXML.project.title.color);
        settings.titleFont = loadedXML.project.title.font;
        settings.titleFontSize = uint(loadedXML.project.title.size);
        settings.listColor = uint("0x"+loadedXML.project.list.color);
        settings.listFont = loadedXML.project.list.font;
        settings.listFontSize = uint(loadedXML.project.list.size);

        var slidevo:SlideVO;
        for each(var node:XML in loadedXML.slides.slide){
            slidevo = new SlideVO();
            slidevo.slideType = node.@type;
            slidevo.slideNumber = node.@page;
            if(slidevo.slideType == "image" || slidevo.slideType == "image+list" ){
                slidevo.img_path = node.img.img_path;
                slidevo.img_scale = Number(node.img.scale);
                slidevo.img_xpos = uint(node.img.@xpos);
                slidevo.img_ypos = uint(node.img.@ypos);
            }
            if(slidevo.slideType != "image"){
                slidevo.Title = node.title;
            }
            if(slidevo.slideType == "title+list" || slidevo.slideType == "image+list" ){
                for each(var li:XML in node.list.text){
                    slidevo.list.push(li.text().toString());
                }
            }
            slides.push(slidevo);

        }
        dispatchEvent(new Event(AppModel.XML_LOADED));
    }




    public function navBarPreviousSlide():void {

        dispatchEvent( new Event(NAVBAR_PREVIOUS_SLIDE) )
    }

    public function navBarNextSlide():void {

        dispatchEvent( new Event(NAVBAR_NEXT_SLIDE) )
    }

    public function get currentSlide():int {
        return _currentSlide;
    }

    public function set currentSlide(value:int):void {
        if( _currentSlide != value ){

            _currentSlide = value;
            dispatchEvent( new Event(CURRENT_SLIDE_CHANGED) );
            trace('[Appmodel] currentSlide changed');
        }
    }
}
}
internal class Enforcer{}

