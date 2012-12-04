package be.devine.cp3.view.components {
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.VO.SlideVO;
import be.devine.cp3.factory.TextfieldFactory;

import com.greensock.TweenLite;

import starling.core.Starling;


import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

public class SlideMiniature extends Sprite{

    /**** VARIABELEN ****/

    public static const CLICKED:String = "Miniature Clicked";

    public var slidevo:SlideVO;

    private var settings:SettingsVO;
    public var index:TextField;

    private var background:SlideBackground;
    private var slide:Slide;

    /**** CONSTRUCTOR ****/
    public function SlideMiniature(slidevo:SlideVO, settings:SettingsVO) {
        this.slidevo = slidevo;
        this.settings = settings;

        background = new SlideBackground(settings);
        addChild(background);

        slide = new Slide(slidevo, settings);
        addChild(slide);

        index = TextfieldFactory.create(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, String(slidevo.slideNumber), false, 0xcccccc, "liberator", 1000);
        index.alpha = 0;
        addChild(index);

        this.addEventListener(TouchEvent.TOUCH, onTouch);

        this.scaleX = this.scaleY = (98/Starling.current.stage.stageWidth);
    }

    private function onTouch(te:TouchEvent):void
    {
        if (te.getTouch(this, TouchPhase.HOVER))
        {
            TweenLite.to(index, 0.5,{alpha:1});
        }
        else
        {
            TweenLite.to(index, 0.5,{alpha:0});
        }
        if (te.getTouch(this, TouchPhase.ENDED))
        {
            this.dispatchEvent(new Event(CLICKED));
        }

    }

//    private function mouseOverHandler(event:MouseEvent):void {
//        this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
//        this.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
//
//        TweenLite.to(index, 0.5,{alpha:1});
//
//    }
//
//    private function mouseOutHandler(event:MouseEvent):void {
//        this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
//        this.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
//        TweenLite.to(index, 0.5,{alpha:0});
//
//    }

    /**** METHODS ****/
}
}
