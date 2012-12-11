package be.devine.cp3.view.components {
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.factory.view.TextfieldFactory;
import be.devine.cp3.model.AppModel;

import flash.events.Event;
import flash.geom.Rectangle;

import flashx.textLayout.formats.BackgroundColor;

import starling.core.Starling;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;

public class SlideBackground extends Sprite{

    /**** VARIABELEN ****/

    private var settingsvo:SettingsVO;
    private var appmodel:AppModel;
    private var infotext:TextField;
    private var background:Quad;


    /**** CONSTRUCTOR ****/
    public function SlideBackground(Resize:Boolean = true) {

        appmodel = AppModel.getInstance();
        settingsvo = appmodel.settingsvo;


        generateBackground();
        generateInfo();

        if(Resize){
            appmodel.addEventListener(AppModel.RESIZED, ResizeHandler)
        }

    }

    private function generateInfo():void {

        infotext = TextfieldFactory.create(250, 50, settingsvo.userName +"  -  "+settingsvo.createdDate, true, settingsvo.listColor, settingsvo.listFont, 20);
        addChild(infotext);
        infotext.x = (appmodel.windowWidth - 250);
        infotext.y = (appmodel.windowHeight - 60);
    }

    private function generateBackground():void {

        background = new Quad(appmodel.windowWidth, appmodel.windowHeight);
        if( settingsvo.backgroundType == 'solid' ){
            background.setVertexColor(0,settingsvo.backgroundColor1);
            background.setVertexColor(1,settingsvo.backgroundColor1);
            background.setVertexColor(2,settingsvo.backgroundColor1);
            background.setVertexColor(3,settingsvo.backgroundColor1);
        } else {
            if( settingsvo.gradientDirection == 'horizontal'){
                background.setVertexColor(0,settingsvo.backgroundColor1);
                background.setVertexColor(1,settingsvo.backgroundColor2);
                background.setVertexColor(2,settingsvo.backgroundColor1);
                background.setVertexColor(3,settingsvo.backgroundColor2);
            }
            else if( settingsvo.gradientDirection == 'vertical'){
                background.setVertexColor(0,settingsvo.backgroundColor1);
                background.setVertexColor(1,settingsvo.backgroundColor1);
                background.setVertexColor(2,settingsvo.backgroundColor2);
                background.setVertexColor(3,settingsvo.backgroundColor2);
            }
        }

        addChild(background);
        background.x = background.y = 0;
    }

    private function ResizeHandler(event:starling.events.Event):void {
        infotext.x = (appmodel.windowWidth - 250);
        infotext.y = (appmodel.windowHeight - 50);

        background = new Quad(appmodel.windowWidth, appmodel.windowHeight);
        if( settingsvo.backgroundType == 'solid' ){
            background.setVertexColor(0,settingsvo.backgroundColor1);
            background.setVertexColor(1,settingsvo.backgroundColor1);
            background.setVertexColor(2,settingsvo.backgroundColor1);
            background.setVertexColor(3,settingsvo.backgroundColor1);
        } else {
            if( settingsvo.gradientDirection == 'horizontal'){
                background.setVertexColor(0,settingsvo.backgroundColor1);
                background.setVertexColor(1,settingsvo.backgroundColor2);
                background.setVertexColor(2,settingsvo.backgroundColor1);
                background.setVertexColor(3,settingsvo.backgroundColor2);
            }
            else if( settingsvo.gradientDirection == 'vertical'){
                background.setVertexColor(0,settingsvo.backgroundColor1);
                background.setVertexColor(1,settingsvo.backgroundColor1);
                background.setVertexColor(2,settingsvo.backgroundColor2);
                background.setVertexColor(3,settingsvo.backgroundColor2);
            }
        }

        addChild(background);
        setChildIndex(background, 1);
        background.x = background.y = 0;
    }
}
}
