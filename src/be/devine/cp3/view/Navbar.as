package be.devine.cp3.view {

import be.devine.cp3.VO.SlideVO;
import be.devine.cp3.factory.GradientFactory;
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.SlideMiniature;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Navbar extends Sprite {

    // Properties
    private var appmodel:AppModel;
    private var bg:Sprite;
    private var miniature:SlideMiniature;
    private var slidesCon:Sprite;
    private var mk:Sprite

    var spacing:uint;

    var colors:Array;
    var alphas:Array;
    var ratios:Array;


    // Constructor
    public function Navbar() {

        this.appmodel = AppModel.getInstance();
        layout();
    }

    private function layout():void {

        slidesCon = new Sprite();
        alphas = [1, 1];
        ratios = [0, 255];

        colors = [0xc9c4b0, 0xd3ceba];
        bg = GradientFactory.createReflect('vertical', 984, 100, colors, alphas, ratios, this);
        bg.x = 20;

        colors = [0x9d9887, 0xb1ac99];
        var btnLeft:Sprite = GradientFactory.createReflect('vertical', 20, 100, colors, alphas, ratios, this);

        var btnRight:Sprite = GradientFactory.createReflect('vertical', 20, 100, [ 0x9d9887, 0xb1ac99 ], alphas, ratios, this);
        btnRight.x = 1004;
        btnLeft.buttonMode = btnRight.buttonMode = true;

        btnLeft.addEventListener(MouseEvent.CLICK, goToPreviousSlide);
        btnRight.addEventListener(MouseEvent.CLICK, goToNextSlide);

        var xPos:uint = 0;
        spacing = 10;

        for each(var slidevo:SlideVO in appmodel.slides){
            miniature = new SlideMiniature(slidevo, appmodel.settings);
            miniature.x = xPos;
            miniature.y = 0;
            miniature.addEventListener(MouseEvent.CLICK, setSlide);
            miniature.buttonMode = true;
            miniature.mouseChildren = true;
            slidesCon.addChild(miniature);


            xPos += miniature.width + spacing;
        }


        slidesCon.x = bg.x + 10;
        slidesCon.y = bg.y + 10;
        addChild(slidesCon);

        mk = new Sprite();
        mk.graphics.beginFill(0xffffff);
        mk.graphics.drawRect(bg.x, bg.y, bg.width, bg.height);
        mk.graphics.endFill();
        addChild(mk);
        slidesCon.mask = mk;

        appmodel.addEventListener(AppModel.NAVBAR_PREVIOUS_SLIDE, goToPreviousSlide);
        appmodel.addEventListener(AppModel.NAVBAR_NEXT_SLIDE, goToNextSlide);
    }

    private function setSlide(e:MouseEvent):void {

        var clickedSlideVO:SlideMiniature = e.currentTarget as SlideMiniature;
        appmodel.currentSlide = clickedSlideVO.slidevo.slideNumber -1;
    }

    private function goToPreviousSlide(e:Event):void {

        if( slidesCon.x < bg.x + 10)
            slidesCon.x += 10 + miniature.width;
    }

    private function goToNextSlide(e:Event):void {

        if( slidesCon.x > -((slidesCon.width - bg.width) - miniature.width) )
            slidesCon.x -= 10 + miniature.width;
    }
}
}
