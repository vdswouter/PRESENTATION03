package be.devine.cp3.view.components {
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.VO.SlideVO;
import be.devine.cp3.factory.TextfieldFactory;

import com.greensock.TweenLite;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

import starling.display.Sprite;

public class SlideMiniature extends flash.display.Sprite{

    /**** VARIABELEN ****/

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

        index = TextfieldFactory.create(new TextFormat("Liberator", 1000, 0XFFFFFF),this,0,0,String(slidevo.slideNumber));
        index.alpha = 0;
        addChild(index);

        this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
        this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);

        this.scaleX = this.scaleY = (98/1024);
    }

    private function mouseOverHandler(event:MouseEvent):void {
        this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
        this.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);

        TweenLite.to(index, 0.5,{alpha:1});

    }

    private function mouseOutHandler(event:MouseEvent):void {
        this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
        this.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
        TweenLite.to(index, 0.5,{alpha:0});

    }

    /**** METHODS ****/
}
}
