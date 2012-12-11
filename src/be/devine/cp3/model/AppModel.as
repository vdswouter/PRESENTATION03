package be.devine.cp3.model {
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.VO.SlideVO;
import be.devine.cp3.factory.vo.SettingsVOFactory;
import be.devine.cp3.factory.vo.SlideVOFactory;

import flash.events.Event;
import flash.geom.Rectangle;
import flash.net.URLLoader;
import flash.net.URLRequest;

import starling.core.Starling;
import starling.events.Event;
import starling.events.EventDispatcher;

public class AppModel extends EventDispatcher {

    /**** VARIABELEN ****/
    public static const NAVBAR_PREVIOUS_SLIDE:String = 'navBarPreviousSlide';
    public static const NAVBAR_NEXT_SLIDE:String = 'navBarNextSlide';
    public static const CURRENT_SLIDE_CHANGED:String = 'currentSlideChanged';
    public static const XML_LOADED:String = 'xmlIsIngeladen';
    public static const RESIZED:String = 'resized';
    public static const FULLSCREEN:String = 'fullscreen';

    public static var instance:AppModel;

    public var slides:Vector.<SlideVO>;
    public var settingsvo:SettingsVO;

    private var _currentSlide:int = 1;

    private var _windowWidth:uint;
    private var _windowHeight:uint;
    private var _fullscreen:Boolean = false;



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
        xmlLoader.addEventListener( flash.events.Event.COMPLETE, ParseXML );
        xmlLoader.load( new URLRequest(UrlToXML) );
    }

    private function ParseXML(e:flash.events.Event):void {

        var loadedXML:XML = new XML( e.currentTarget.data);

        settingsvo = new SettingsVO();
        settingsvo = SettingsVOFactory.createSettingsFromXML(loadedXML);

        var slidevo:SlideVO;
        slides = new Vector.<SlideVO>();
        for each(var slide:XML in loadedXML.slides.slide){
            slidevo = new SlideVO();
            slidevo = SlideVOFactory.createSlideVOFromXML(slide);
            slides.push(slidevo);
        }

        trace("[AppModel] Parse XML Done");
        dispatchEvent(new starling.events.Event(XML_LOADED));
    }

    public function navBarPreviousSlide():void {

        dispatchEvent( new starling.events.Event(NAVBAR_PREVIOUS_SLIDE) );
    }

    public function navBarNextSlide():void {

        dispatchEvent( new starling.events.Event(NAVBAR_NEXT_SLIDE) );
    }

    public function get currentSlide():int {
        return _currentSlide;
    }

    public function set currentSlide(value:int):void {
        if( _currentSlide != value ){

            _currentSlide = value;
            dispatchEvent( new starling.events.Event(AppModel.CURRENT_SLIDE_CHANGED ) );
        }
    }

    public function gotoNextSlide():void{
        if(_currentSlide == (slides.length-1)){
            currentSlide = 0;
        }else{
            currentSlide ++;
        }
    }
    public function gotoPreviousSlide():void{
        if(_currentSlide == 0){
            currentSlide = slides.length-1;
        }else{
            currentSlide --;
        }
    }

    public function set windowWidth(value:uint):void {
        _windowWidth = value;
        Starling.current.viewPort = new Rectangle(0,0,_windowWidth,_windowHeight);
        Starling.current.stage.stageWidth = _windowWidth;
        Starling.current.stage.stageHeight = _windowHeight;
        this.dispatchEvent(new starling.events.Event(RESIZED));
    }

    public function set windowHeight(value:uint):void {
        _windowHeight = value;
        Starling.current.viewPort = new Rectangle(0,0,_windowWidth,_windowHeight);
        Starling.current.stage.stageWidth = _windowWidth;
        Starling.current.stage.stageHeight = _windowHeight;
        this.dispatchEvent(new starling.events.Event(RESIZED));
    }

    public function get windowWidth():uint {
        return _windowWidth;
    }

    public function get windowHeight():uint {
        return _windowHeight;
    }

    public function get fullscreen():Boolean {
        return _fullscreen;
    }

    public function set fullscreen(value:Boolean):void {
        _fullscreen = value;
        this.dispatchEvent(new starling.events.Event(FULLSCREEN));
    }
}
}
internal class Enforcer{}

