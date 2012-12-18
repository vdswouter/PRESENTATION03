package be.devine.cp3.view {

import be.devine.cp3.VO.SlideVO;
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.SlideBackground;
import be.devine.cp3.view.components.SlideMiniature;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.extensions.pixelmask.PixelMaskDisplayObject;
import starling.textures.Texture;

public class Navbar extends Sprite {

    // Properties
    [Embed(source="/assets/UI_IMG/navbar_btnLeft.png")]
    private var BTNLEFT:Class;

    [Embed(source="/assets/UI_IMG/navbar_btnRight.png")]
    private var BTNRIGHT:Class;

    private var appmodel:AppModel;
    private var miniature:SlideMiniature;

    private var bg:Quad;
    private var slidesCon:Sprite;
    private var slidesConTween:Tween;
    private var colors:Array = [0xc9c4b0, 0xd3ceba];

    private var btnRight:Button;
    private var btnLeft:Button;

    private var maxClicks:uint;
    private var _currentPos:uint = 0;


    // Constructor
    public function Navbar() {

        this.appmodel = AppModel.getInstance();
        appmodel.addEventListener(AppModel.RESIZED, onResized);
        layout();
    }

    private function layout():void {

        slidesCon = new Sprite();

        bg = new Quad(appmodel.windowWidth - 40, 100);
        bg.setVertexColor(0, colors[0]);
        bg.setVertexColor(1, colors[0]);
        bg.setVertexColor(2, colors[1]);
        bg.setVertexColor(3, colors[1]);
        bg.x = 20;
        addChild(bg);

        var btnLeftTexture:Texture = Texture.fromBitmap(new BTNLEFT);
        btnLeft = new Button(btnLeftTexture);
        addChild(btnLeft);

        var btnRightTexture:Texture = Texture.fromBitmap(new BTNRIGHT);
        btnRight = new Button(btnRightTexture);
        btnRight.x = Starling.current.stage.stageWidth - btnRight.width;
        addChild(btnRight);

        btnLeft.addEventListener(Event.TRIGGERED, goToPreviousSlide);
        btnRight.addEventListener(Event.TRIGGERED, goToNextSlide);

        var xPos:uint = 0;
        var spacing:uint = 10;

        for each(var slidevo:SlideVO in appmodel.slides) {

            miniature = new SlideMiniature(slidevo);

            miniature.x = xPos;
            miniature.y = 0;
            miniature.addEventListener(SlideMiniature.CLICKED, setClickedSlide);
            slidesCon.addChild(miniature);
            xPos += miniature.width + spacing;
        }

        slidesCon.x = bg.x + 10;
        slidesCon.y = bg.y + 10;
        addChild(slidesCon);
        setChildIndex(slidesCon,1);

        maxClicks = (slidesCon.width - bg.width) / miniature.width;

        appmodel.addEventListener(AppModel.NAVBAR_PREVIOUS_SLIDE, goToPreviousSlide);
        appmodel.addEventListener(AppModel.NAVBAR_NEXT_SLIDE, goToNextSlide);
        appmodel.addEventListener(AppModel.CURRENT_SLIDE_CHANGED, currentSlideChanged);
    }

    private function currentSlideChanged(e:Event):void {

        if(appmodel.currentSlide+1 == appmodel.slides.length){
            currentPos = maxClicks;
        }
        else if(appmodel.currentSlide+1 == 1){
            currentPos = 0;
        }
        else if(appmodel.currentSlide+1 > 9){
            goToNextSlide();
        } else {
            goToPreviousSlide();
        }
    }

    private function setClickedSlide(e:Event):void {

        var clickedSlideVO:SlideMiniature = e.currentTarget as SlideMiniature;
        appmodel.currentSlide = clickedSlideVO.slidevo.slideNumber -1;
    }

    private function goToPreviousSlide(e:Event = null):void {

        if(_currentPos > 0) currentPos--;
    }

    private function goToNextSlide(e:Event = null):void {

        if(_currentPos < maxClicks) currentPos ++;
    }

    private function onResized(e:Event):void {

        removeChild(bg);
        bg = new Quad(appmodel.windowWidth-40, 100);
        bg.setVertexColor(0, colors[0]);
        bg.setVertexColor(1, colors[0]);
        bg.setVertexColor(2, colors[1]);
        bg.setVertexColor(3, colors[1]);
        bg.x = 20;
        addChild(bg);
        setChildIndex(bg, 0);

        btnRight.x = appmodel.windowWidth - btnRight.width;

        var checkifBelowZero:Number = slidesCon.width - bg.width;

        if(checkifBelowZero < 0)
            maxClicks = 0;
        else
            maxClicks = (slidesCon.width - bg.width) / miniature.width;
    }

    public function get currentPos():uint {
        return _currentPos;
    }

    public function set currentPos(value:uint):void {

        if(_currentPos != value){
            _currentPos = value;

            slidesConTween = new Tween(slidesCon, 0.5, Transitions.EASE_OUT);
            slidesConTween.animate('x', (-_currentPos*(miniature.width+10))+30);
            Starling.juggler.add(slidesConTween);
        }

    }
}
}
