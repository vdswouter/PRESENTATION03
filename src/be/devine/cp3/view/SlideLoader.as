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

    private var isFirstRun:Boolean= true;

    // Constructor
    public function SlideLoader() {

        appmodel = AppModel.getInstance();

        if( slideBackground == null ){
            var slideBackground:SlideBackground = new SlideBackground();
            addChild(slideBackground);
        }

        appmodel.addEventListener(AppModel.CURRENT_SLIDE_CHANGED, currentSlideChanged);
    }

    private function currentSlideChanged(e:Event):void {

        if(!isFirstRun){
            if(currentSlide) removeChild(currentSlide);
            currentSlide = slide;
        }

        slide = new Slide();
        slide.x = slide.y = 0;

        if(isFirstRun) addChild(slide);
        else tweenSlides();

        isFirstRun = false;
    }

    private function tweenSlides():void {

        var transitionCurrSlide:Tween = new Tween(currentSlide, 1, Transitions.EASE_OUT);
        var transitionSlide:Tween = new Tween(slide, 1, Transitions.EASE_OUT);

        var transitionType:String;
        if(currentSlide.slidevo.slideNumber < slide.slidevo.slideNumber && slide.slidevo.slideNumber != appmodel.slides.length)
            transitionType = currentSlide.slidevo.transition;
        else
            transitionType = 'none';

        switch( transitionType ){
            case 'alpha':
                    slide.alpha = 0;
                    addChild(slide);
                    setChildIndex(slide, 1);

                    transitionCurrSlide.fadeTo(0);
                    transitionSlide.fadeTo(1);
            break;
            case 'push left':
                    slide.x = 0 - currentSlide.width;
                    addChild(slide);

                    transitionCurrSlide.animate('x', appmodel.windowWidth);
                    transitionSlide.animate('x', 0);
            break;
            case 'push right':
                    slide.x = appmodel.windowWidth;
                    addChild(slide);

                    transitionCurrSlide.animate('x', -(currentSlide.bounds.x+currentSlide.width));
                    transitionSlide.animate('x', 0);
            break;
            case 'push up':
                    slide.y = appmodel.windowHeight + slide.height;
                    addChild(slide);

                    transitionCurrSlide.animate('y', -(currentSlide.height+currentSlide.bounds.y));
                    transitionSlide.animate('y', 0);
            break;
            case 'push down':
                    slide.y = -slide.height;
                    addChild(slide);

                    transitionCurrSlide.animate('y', appmodel.windowHeight + currentSlide.height);
                    transitionSlide.animate('y', 0);
            break;
            case 'push top left':
                    slide.x = -slide.width;
                    slide.y = -slide.height;
                    addChild(slide);

                    transitionCurrSlide.moveTo(appmodel.windowWidth, appmodel.windowHeight);
                    transitionSlide.moveTo(0, 0);
            break;
            case 'push top right':
                    slide.x = appmodel.windowWidth + slide.width;
                    slide.y = appmodel.windowHeight + slide.height;
                    addChild(slide);

                    transitionCurrSlide.moveTo(-currentSlide.width, -currentSlide.height);
                    transitionSlide.moveTo(0, 0);
            break;
            case 'push bottom left':
                    slide.x = -slide.width;
                    slide.y = appmodel.windowHeight + slide.height;
                    addChild(slide);

                    transitionCurrSlide.moveTo(appmodel.windowWidth, -appmodel.windowHeight);
                    transitionSlide.moveTo(0, 0);
            break;
            case 'push bottom right':
                    slide.x = appmodel.windowWidth;
                    slide.y = appmodel.windowHeight;
                    addChild(slide);

                    transitionCurrSlide.moveTo(-currentSlide.width, -currentSlide.height);
                    transitionSlide.moveTo(0, 0);
            break;
            case 'zoom':
                    slide.alpha = 0;
                    slide.scaleX = slide.scaleY = -2;
                    addChild(slide);

                    transitionCurrSlide.scaleTo(2);
                    transitionCurrSlide.fadeTo(0);
                    transitionSlide.scaleTo(1);
                    transitionSlide.fadeTo(1);
            break;
            case 'none':
                addChild(slide);
                removeCurrentSlide();
            break;
        }

        if(transitionType != 'none') transitionCurrSlide.onComplete = removeCurrentSlide;
        Starling.juggler.add(transitionCurrSlide);
        Starling.juggler.add(transitionSlide);
    }

    private function removeCurrentSlide():void {

        if(currentSlide.parent && currentSlide != null){
            currentSlide.removeResize();
            removeChild(currentSlide);
        }

    }
}
}