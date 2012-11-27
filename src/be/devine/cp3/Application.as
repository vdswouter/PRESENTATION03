package be.devine.cp3 {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.Navbar;
import be.devine.cp3.view.SlideLoader;
import be.devine.cp3.view.components.Slide;

import com.greensock.TweenLite;
import com.greensock.easing.Sine;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.ui.Keyboard;

public class Application extends Sprite{

    /**** VARIABELEN ****/
    private var appmodel:AppModel;
    private var navbar:Navbar;
    private var slideLoader:SlideLoader;

    private var isNavbar:Boolean = false;

    /**** CONSTRUCTOR ****/
    public function Application() {

        appmodel = AppModel.getInstance();



        /*var slide:Slide = new Slide('title+list');
        slide.txtTitle = 'DIT IS EEN TITEL';
        slide.lists = ['dit is list 1', 'dit is list 2', 'dit is list 3', 'dit is list 4'];
        //slide.imagePath = 'assets/images/1.jpg';
        addChild(slide);*/

        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

    }

    private function addedToStageHandler(e:Event):void {
        appmodel.load("assets/xml/template.xml");
        appmodel.addEventListener(AppModel.XML_LOADED, onXmlIsIngeladen)


    }


    private function navBarOptions(e:KeyboardEvent):void {

        if (e.keyCode == Keyboard.SPACE) {
            if (isNavbar)
                TweenLite.to(navbar, 0.5, {y:stage.stageHeight, ease:Sine.easeOut});
            else
                TweenLite.to(navbar, 0.5, {y:stage.stageHeight - navbar.height, ease:Sine.easeOut});

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
        navbar.y = stage.stageHeight;
        addChild(navbar);

        appmodel.currentSlide = 0;

        stage.addEventListener(KeyboardEvent.KEY_DOWN,  navBarOptions)
    }
}
}
