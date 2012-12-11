package be.devine.cp3 {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.Navbar;
import be.devine.cp3.view.SlideLoader;

import flash.ui.Keyboard;

import starling.animation.Transitions;

import starling.animation.Tween;

import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.KeyboardEvent;

public class Application extends Sprite{

    /**** VARIABELEN ****/
    private var appmodel:AppModel;
    private var navbar:Navbar;

    private var isNavbar:Boolean = false;

    /**** CONSTRUCTOR ****/
    public function Application() {

        appmodel = AppModel.getInstance();

        appmodel.load("/assets/xml/template.xml");
        appmodel.addEventListener(AppModel.XML_LOADED, onXMLIsLoaded);

        // TODO resize handler + fullscreen modus

        // DONE
        // Textfieldfactory's geupdate naar leesbaardere versie
    }

    private function onXMLIsLoaded(e:Event):void {

        var slideLoader:SlideLoader = new SlideLoader();
        addChild(slideLoader);

        navbar = new Navbar();
        navbar.y = Starling.current.stage.stageHeight;
        addChild(navbar);

        appmodel.currentSlide = 0;

        Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN,  navBarOptions);
    }

    private function navBarOptions(e:KeyboardEvent):void {

        var navbarTween:Tween = new Tween(navbar, 0.8, Transitions.EASE_OUT);

        switch(e.keyCode){
            case Keyboard.SPACE:
                    if(isNavbar)
                        navbarTween.animate('y', Starling.current.stage.stageHeight);
                    else
                        navbarTween.animate('y', Starling.current.stage.stageHeight - navbar.height);

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
        }
    }
}
}