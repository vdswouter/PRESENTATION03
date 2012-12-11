package be.devine.cp3 {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.Navbar;
import be.devine.cp3.view.SlideLoader;

import flash.display.Stage;

import flash.ui.Keyboard;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Sprite;
import starling.display.Stage;
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
        appmodel.addEventListener(AppModel.XML_LOADED, onXMLIsLoaded);

        // TODO resize handler + fullscreen modus

        appmodel.addEventListener(AppModel.RESIZED, onResized)
    }

    private function onXMLIsLoaded(e:Event):void {
        trace("[Application] XML loaded");
        slideLoader = new SlideLoader();
        addChild(slideLoader);

        navbar = new Navbar();
        navbar.y = appmodel.windowHeight;
        addChild(navbar);

        appmodel.currentSlide = 0;

        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, navBarOptions);
    }

    private function navBarOptions(e:KeyboardEvent):void {

        var navbarTween:Tween = new Tween(navbar, 0.8, Transitions.EASE_OUT);

        switch(e.keyCode){
            case Keyboard.SPACE:
                    if(isNavbar)
                        navbarTween.animate('y', appmodel.windowHeight);
                    else
                        navbarTween.animate('y', appmodel.windowHeight - navbar.height-20);

                    Starling.juggler.add(navbarTween);
                    isNavbar = !isNavbar;
            break;
            case Keyboard.LEFT:
                    if(isNavbar) appmodel.navBarPreviousSlide();
                    else appmodel.gotoPreviousSlide();
            break;
            case Keyboard.RIGHT:
                    if(isNavbar) appmodel.navBarNextSlide();
                    else appmodel.gotoNextSlide();
            break;
            case Keyboard.F:
                    //GOTO FULLSCREEN
                break;
        }
    }


    private function onResized(e:Event):void {
        if(isNavbar)
            navbar.y = appmodel.windowHeight - navbar.height-20;
        else
            navbar.y = appmodel.windowHeight;
    }
}
}