package be.devine.cp3.view {
import be.devine.cp3.model.AppModel;
import be.devine.cp3.view.components.Slide;
import be.devine.cp3.view.components.SlideBackground;

import starling.display.Sprite;
import starling.events.Event;

public class SlideLoader extends Sprite {

    // Properties
    private var appmodel:AppModel;

    private var slide:Slide;
    private var slideBackground:SlideBackground;

    // Constructor
    public function SlideLoader() {

        this.appmodel = AppModel.getInstance();

        slideBackground = new SlideBackground(appmodel.settings);
        addChild(slideBackground);

        appmodel.addEventListener(AppModel.CURRENT_SLIDE_CHANGED, currentSlideChanged);


    }

    private function currentSlideChanged(e:Event):void {

        trace('[SLIDELOADER] nieuwe slide inladen');

        if(slide != null && slide.stage != null){
            removeChild(slide);
        }

        slide = new Slide(appmodel.slides[appmodel.currentSlide],appmodel.settings);
        slide.x = slide.y = 0;
        addChild(slide);

    }
}
}
