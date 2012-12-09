package be.devine.cp3.view {

import be.devine.cp3.VO.SlideVO;
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.SlideMiniature;

import starling.display.Button;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;
import starling.extensions.pixelmask.PixelMaskDisplayObject;
import starling.textures.Texture;

public class Navbar extends Sprite {

    // Properties
    [Embed(source="/assets/UI_IMG/navbar_btnLeft.png")]
    private var BTNLEFT:Class;

    [Embed(source="/assets/UI_IMG/navbar_btnRight.png")]
    private var BTNRIGHT:Class;

    private var appmodel:AppModel;
    private var bg:Quad;
    private var miniature:SlideMiniature;
    private var slidesCon:Sprite;
    private var mk:Quad;
    private var maskedSlidesCon:PixelMaskDisplayObject;


    // Constructor
    public function Navbar() {

        this.appmodel = AppModel.getInstance();
        layout();
    }

    private function layout():void {

        slidesCon = new Sprite();
        var colors:Array = [0xc9c4b0, 0xd3ceba];

        bg = new Quad(984,100);
        bg.setVertexColor(0, colors[0]);
        bg.setVertexColor(1, colors[0]);
        bg.setVertexColor(2, colors[1]);
        bg.setVertexColor(3, colors[1]);
        bg.x = 20;
        addChild(bg);

        var btnLeftTexture:Texture = Texture.fromBitmap(new BTNLEFT);
        var btnLeft:Button = new Button(btnLeftTexture);
        addChild(btnLeft);


        var btnRightTexture:Texture = Texture.fromBitmap(new BTNRIGHT);
        var btnRight:Button = new Button(btnRightTexture);
        addChild(btnRight);
        btnRight.x = 1004;


        btnLeft.addEventListener(Event.TRIGGERED, goToPreviousSlide);
        btnRight.addEventListener(Event.TRIGGERED, goToNextSlide);

        var xPos:uint = 0;
        var spacing:uint = 10;

        for each(var slidevo:SlideVO in appmodel.slides){
            //TODO: eventueel omzetten naar button Maar hoe gaan we dan de clickedslide-id opvragen????
            miniature = new SlideMiniature(slidevo, appmodel.settingsvo);

            miniature.x = xPos;
            miniature.y = 0;
            miniature.addEventListener(SlideMiniature.CLICKED, setSlide);
            slidesCon.addChild(miniature);

            xPos += miniature.width + spacing;
        }

        slidesCon.x = bg.x + 10;
        slidesCon.y = bg.y + 10;
//        addChild(slidesCon);

        mk = new Quad(bg.width - 25, bg.height, 0xffffff);
        mk.x = 25;
        drawMask();

        appmodel.addEventListener(AppModel.NAVBAR_PREVIOUS_SLIDE, goToPreviousSlide);
        appmodel.addEventListener(AppModel.NAVBAR_NEXT_SLIDE, goToNextSlide);
    }

    private function setSlide(e:Event):void {

        var clickedSlideVO:SlideMiniature = e.currentTarget as SlideMiniature;
        appmodel.currentSlide = clickedSlideVO.slidevo.slideNumber -1;
    }

    private function drawMask():void{
        if(maskedSlidesCon != null && maskedSlidesCon.parent != null){
            removeChild(maskedSlidesCon);
        }
        maskedSlidesCon = new PixelMaskDisplayObject();
        maskedSlidesCon.addChild(slidesCon);

        maskedSlidesCon.mask = mk;
        addChild(maskedSlidesCon);
    }
//
    private function goToPreviousSlide(e:Event):void {

        if( slidesCon.x < bg.x + 10){
            slidesCon.x += 10 + miniature.width;
        }
    }

    private function goToNextSlide(e:Event):void {

        if( slidesCon.x > -((slidesCon.width - bg.width) - miniature.width) ){
            slidesCon.x -= 10 + miniature.width;
        }
    }
}
}
