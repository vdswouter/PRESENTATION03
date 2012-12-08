package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.Slide;
import be.devine.cp3.view.components.SlideBackground;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Sprite;
import starling.events.Event;

public class SlideLoader extends Sprite {

    // Properties
    private var appmodel:AppModel;

    private var slide:Slide;
    private var currentSlide:Slide;
    private var slideBackground:SlideBackground;


    private var isFirstRun:Boolean= true;

    // Constructor
    public function SlideLoader() {

        this.appmodel = AppModel.getInstance();

        slideBackground = new SlideBackground(appmodel.settings);
        addChild(slideBackground);

        appmodel.addEventListener(AppModel.CURRENT_SLIDE_CHANGED, currentSlideChanged);
    }

    private function currentSlideChanged(e:Event):void {

//        trace('[SLIDELOADER] nieuwe slide inladen');

        if(!isFirstRun) currentSlide = slide;

        slide = new Slide(appmodel.slides[appmodel.currentSlide], appmodel.settings);
        slide.x = slide.y = 0;

        if(isFirstRun){
            currentSlide = slide;
            addChild(slide);
        } else {
            tweenSlides();
        }

        isFirstRun = false;

        trace('[] currSlide pageNumber:', currentSlide.slidevo.slideNumber);
    }

    private function tweenSlides():void {

        var transitionCurrSlide:Tween = new Tween(currentSlide, 1, Transitions.EASE_OUT);
        var transitionSlide:Tween = new Tween(slide, 1, Transitions.EASE_OUT);

        var transitionType:String;
        if(currentSlide.slidevo.slideNumber < slide.slidevo.slideNumber)
            transitionType = currentSlide.slidevo.transition;
        else
            transitionType = 'none';

        switch( transitionType ){
            case 'alpha':
                    trace('[SLIDELOADER] transition = alpha');

                    slide.alpha = 0;
                    addChild(slide);
                    setChildIndex(slide, 1);

                    transitionCurrSlide.fadeTo(0);
                    transitionSlide.fadeTo(1);
            break;
            case 'push left':
                trace('[SLIDELOADER] transition = push left');

                slide.x = 0 - currentSlide.width;
                addChild(slide);

                transitionCurrSlide.animate('x', Starling.current.stage.stageWidth);
                transitionSlide.animate('x', 0);
            break;
            case 'push right':
                    trace('[SLIDELOADER] transition = push right');

                    slide.x = Starling.current.stage.stageWidth;
                    addChild(slide);

                    transitionCurrSlide.animate('x', -currentSlide.width);
                    transitionSlide.animate('x', 0);
            break;
            case 'push up':
                    //TODO y waarde currSlide na tween is verkeerd ??? THE FOK
                    trace('[SLIDELOADER] transition = push up');

                    slide.y = Starling.current.stage.stageHeight + slide.height;
                    addChild(slide);

//                    trace('[] currentslide.y:', currentSlide.y);
//                    trace('[] currentslide.height:', currentSlide.height);
                    transitionCurrSlide.animate('y', -currentSlide.height);
                    transitionSlide.animate('y', 0);
            break;
            case 'push down':
                    trace('[SLIDELOADER] transition = push down');
                    trace('[] slide.height:', slide.height);
                    slide.y = -slide.height;
                    addChild(slide);

                    transitionCurrSlide.animate('y', Starling.current.stage.stageHeight + currentSlide.height);
                    transitionSlide.animate('y', 0);
            break;
            case 'push top left':
                    trace('[SLIDELOADER] transition = push top left');

                    slide.x = -slide.width;
                    slide.y = -slide.height;
                    addChild(slide);

                    transitionCurrSlide.moveTo(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight);
                    transitionSlide.moveTo(0, 0);
            break;
            case 'push top right':
                    trace('[SLIDELOADER] transition = push top right');

                    slide.x = Starling.current.stage.stageWidth + slide.width;
                    slide.y = Starling.current.stage.stageHeight + slide.height;
                    addChild(slide);

                    transitionCurrSlide.moveTo(-currentSlide.width, -currentSlide.height);
                    transitionSlide.moveTo(0, 0);
            break;
            case 'push bottom left':
                    trace('[SLIDELOADER] transition = push bottom left');

                    slide.x = -slide.width;
                    slide.y = Starling.current.stage.stageHeight + slide.height;
                    addChild(slide);

                    transitionCurrSlide.moveTo(Starling.current.stage.stageWidth, -Starling.current.stage.stageHeight);
                    transitionSlide.moveTo(0, 0);
            break;
            case 'push bottom right':
                    trace('[SLIDELOADER] transition = push bottom right');

                    slide.x = Starling.current.stage.stageWidth;
                    slide.y = Starling.current.stage.stageHeight;
                    addChild(slide);

                    transitionCurrSlide.moveTo(-currentSlide.width, -currentSlide.height);
                    transitionSlide.moveTo(0, 0);
            break;
            case 'zoom':
                    trace('[SLIDELOADER] transition = zoom');
                    slide.alpha = 0;
                    slide.scaleX = slide.scaleY = -2;
                    addChild(slide);

                    transitionCurrSlide.scaleTo(2);
                    transitionCurrSlide.fadeTo(0);
                    transitionSlide.scaleTo(1);
                    transitionSlide.fadeTo(1);
            break;
            case 'none':
                trace('[SLIDELOADER] transition = none');
                addChild(slide);
                removeCurrSlide();
            break;
        }

        transitionCurrSlide.onComplete = removeCurrSlide;
        Starling.juggler.add(transitionCurrSlide);
        Starling.juggler.add(transitionSlide);
    }

    private function removeCurrSlide():void {

//        trace('[] currentslide.y:', currentSlide.y);

        if(currentSlide != null){
            removeChild(currentSlide);
        }
    }
}
}
