package be.devine.cp3.view.components {
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.VO.SlideVO;
import be.devine.cp3.factory.view.TextfieldFactory;
import be.devine.cp3.model.AppModel;

import starling.animation.Transitions;

import starling.animation.Tween;

import starling.core.Starling;
import starling.display.Quad;


import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

public class SlideMiniature extends Sprite{

    /**** VARIABELEN ****/

    public static const CLICKED:String = "Miniature Clicked";

    private var appmodel:AppModel;
    private var settings:SettingsVO;
    public var slidevo:SlideVO;

    public var index:TextField;
    private var bgActive:Quad;


    /**** CONSTRUCTOR ****/
    public function SlideMiniature(slidevo:SlideVO) {

        appmodel = AppModel.getInstance();
        this.slidevo = slidevo;
        settings = appmodel.settingsvo;

        bgActive = new Quad(Starling.current.stage.stageWidth + 20, Starling.current.stage.stageHeight + 20, appmodel.settingsvo.activeSlideBGColor);
        bgActive.x = -10;
        bgActive.y = -10;
        bgActive.alpha = 0;
        addChild(bgActive);

        var background:SlideBackground= new SlideBackground();
        addChild(background);

        var slide:Slide = new Slide();
        addChild(slide);

        index = TextfieldFactory.create(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, String(slidevo.slideNumber), false, 0xcccccc, "liberator", 1000);
        index.alpha = 0;
        addChild(index);

        this.scaleX = this.scaleY = (98 / Starling.current.stage.stageWidth);

        this.addEventListener(TouchEvent.TOUCH, onTouch);
        appmodel.addEventListener(AppModel.CURRENT_SLIDE_CHANGED, currentSlideChanged);
    }

    private function currentSlideChanged(e:Event):void {

        if( this.slidevo.slideNumber == appmodel.currentSlide + 1 )
            bgActive.alpha = 1;
        else
            bgActive.alpha = 0;
    }

    private function onTouch(te:TouchEvent):void
    {
        var slideNrTween:Tween = new Tween(index, 1, Transitions.EASE_OUT);

        if (te.getTouch(this, TouchPhase.HOVER)){
            slideNrTween.fadeTo(1);
        } else {
            slideNrTween.fadeTo(0);
        }
        if (te.getTouch(this, TouchPhase.ENDED)){
            dispatchEvent(new Event(CLICKED));
        }

        Starling.juggler.add(slideNrTween);
    }
}
}
