package be.devine.cp3.view {

import be.devine.cp3.VO.SlideVO;
import be.devine.cp3.factory.GradientFactory;
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.SlideMiniature;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display.Loader;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.URLRequest;

import starling.display.Button;

import starling.display.Quad;

import starling.display.Sprite;
import starling.textures.Texture;

public class Navbar extends starling.display.Sprite {

    // Properties
    [Embed(source="/assets/UI_IMG/navbar_btnLeft.png")]
    private var BTNLEFT:Class;

    [Embed(source="/assets/UI_IMG/navbar_btnRight.png")]
    private var BTNRIGHT:Class;

    private var appmodel:AppModel;
    private var bg:Quad;
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
        //bg = GradientFactory.createReflect('vertical', 984, 100, colors, alphas, ratios, this);
        bg = new Quad(984,100);
        bg.setVertexColor(0, colors[0]);
        bg.setVertexColor(1, colors[0]);
        bg.setVertexColor(2, colors[1]);
        bg.setVertexColor(3, colors[1]);
        bg.x = 20;

        colors = [0x9d9887, 0xb1ac99];
//

        var btnLeftTexture:Texture = Texture.fromBitmap(new BTNLEFT);
        var btnLeft:Button = new Button(btnLeftTexture);
        addChild(btnLeft);


        var btnLeftTexture:Texture = Texture.fromBitmap(new BTNRIGHT);
        var btnRight:Button = new Button(btnLeftTexture);
        addChild(btnRight);
        btnRight.x = 1004;


//        btnLeft.addEventListener(MouseEvent.CLICK, goToPreviousSlide);
//        btnRight.addEventListener(MouseEvent.CLICK, goToNextSlide);

        var xPos:uint = 0;
        spacing = 10;
//
//        for each(var slidevo:SlideVO in appmodel.slides){
//            miniature = new SlideMiniature(slidevo, appmodel.settings);
//            miniature.x = xPos;
//            miniature.y = 0;
//            miniature.addEventListener(MouseEvent.CLICK, setSlide);
//            //miniature.buttonMode = true;
//            miniature.mouseChildren = true;
//            slidesCon.addChild(miniature);
//
//
//            xPos += miniature.width + spacing;
//        }
//
//
//        slidesCon.x = bg.x + 10;
//        slidesCon.y = bg.y + 10;
//        addChild(slidesCon);
//
//        mk = new Sprite();
//        mk.graphics.beginFill(0xffffff);
//        mk.graphics.drawRect(bg.x, bg.y, bg.width, bg.height);
//        mk.graphics.endFill();
//        addChild(mk);
//        slidesCon.mask = mk;
//
//        appmodel.addEventListener(AppModel.NAVBAR_PREVIOUS_SLIDE, goToPreviousSlide);
//        appmodel.addEventListener(AppModel.NAVBAR_NEXT_SLIDE, goToNextSlide);
    }
//
//    private function setSlide(e:MouseEvent):void {
//
//        var clickedSlideVO:SlideMiniature = e.currentTarget as SlideMiniature;
//        appmodel.currentSlide = clickedSlideVO.slidevo.slideNumber -1;
//    }
//
//    private function goToPreviousSlide(e:Event):void {
//
//        if( slidesCon.x < bg.x + 10)
//            slidesCon.x += 10 + miniature.width;
//    }
//
//    private function goToNextSlide(e:Event):void {
//
//        if( slidesCon.x > -((slidesCon.width - bg.width) - miniature.width) )
//            slidesCon.x -= 10 + miniature.width;
//    }
}
}
