package be.devine.cp3 {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.Navbar;
import be.devine.cp3.view.SlideLoader;

import com.greensock.TweenLite;
import com.greensock.easing.Sine;

import flash.ui.Keyboard;

import starling.core.Starling;

import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;

public class Application extends Sprite{

    /**** VARIABELEN ****/
    private var appmodel:AppModel;
    private var navbar:Navbar;
    private var slideLoader:SlideLoader;

    private var isNavbar:Boolean = false;

    /**** CONSTRUCTOR ****/
    public function Application() {

        appmodel = AppModel.getInstance();

        appmodel.load("/assets/xml/template.xml");
        appmodel.addEventListener(AppModel.XML_LOADED, onXmlIsIngeladen)
        //onXmlIsIngeladen(null)
    }

    private function addedToStageHandler(e:Event):void {

    }

    private function navBarOptions(e:KeyboardEvent):void {

        if (e.keyCode == Keyboard.SPACE) {
            if (isNavbar)
                TweenLite.to(navbar, 0.5, {y:Starling.current.stage.stageHeight, ease:Sine.easeOut});
            else
                TweenLite.to(navbar, 0.5, {y:Starling.current.stage.stageHeight - navbar.height, ease:Sine.easeOut});

            isNavbar = !isNavbar;
        }
        else if( e.keyCode == Keyboard.LEFT && isNavbar == true ){
            appmodel.navBarPreviousSlide();
        }
        else if( e.keyCode == Keyboard.RIGHT && isNavbar == true ){
            appmodel.navBarNextSlide();
        }else if( e.keyCode == Keyboard.LEFT && isNavbar == false ){
            appmodel.gotoPreviousSlide();
        }
        else if( e.keyCode == Keyboard.RIGHT && isNavbar == false ){
            appmodel.gotoNextSlide();
        }
    }

    /**** METHODS ****/
    private function onXmlIsIngeladen(e:Event):void {
        slideLoader = new SlideLoader();
        addChild(slideLoader);

        navbar = new Navbar();
        navbar.y = Starling.current.stage.stageHeight;
        addChild(navbar);

        appmodel.currentSlide = 0;

        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN,  navBarOptions);
    }
}
}
