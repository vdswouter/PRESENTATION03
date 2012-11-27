package be.devine.cp3.view {

import be.devine.cp3.Factory.GradientFactory;
import be.devine.cp3.model.AppModel;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Navbar extends Sprite {

    // Properties
    private var appmodel:AppModel;
    private var bg:Sprite;
    private var slide:Sprite;
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

        btnLeft.addEventListener(MouseEvent.CLICK, goToPreviousSlide);
        btnRight.addEventListener(MouseEvent.CLICK, goToNextSlide);

        var xPos:uint = 0;
        spacing = 10;

        for (var i:uint = 1; i <= 15; i++) {
            slide = new Sprite();
            slide.graphics.beginFill(Math.random() * 0xffffff);
            slide.graphics.drawRect(0, 0, bg.width/10, 80);
            slide.graphics.endFill();
            slide.buttonMode = true;
            appmodel.slides.push(slide);

            slide.x = xPos;
            slidesCon.addChild(slide);

            xPos += slide.width + spacing;

            slide.addEventListener(MouseEvent.CLICK, loadSlide);
        }

        appmodel.currentSlide = 0;

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

    private function loadSlide(e:MouseEvent):void {

        var clickedSlide:uint = appmodel.slides.indexOf(e.currentTarget);
        appmodel.currentSlide = clickedSlide;
        trace('clickedSlide:', clickedSlide);
    }

    private function goToPreviousSlide(e:Event):void {

        if( slidesCon.x < bg.x + 10)
            slidesCon.x += 10 + slide.width;
    }

    private function goToNextSlide(e:Event):void {

        if( slidesCon.x > -((slidesCon.width - bg.width) - slide.width) )
            slidesCon.x -= 10 + slide.width;
    }
}
}
