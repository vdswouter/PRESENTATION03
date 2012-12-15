package be.devine.cp3.view.components {
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.factory.view.TextfieldFactory;
import be.devine.cp3.model.AppModel;

import flash.display.StageDisplayState;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class SlideBackground extends Sprite{

    /**** VARIABELEN ****/

    private var settingsvo:SettingsVO;
    private var appmodel:AppModel;
    private var infotext:TextField;
    private var background:Quad;


    /**** CONSTRUCTOR ****/
    public function SlideBackground(resize:Boolean = true) {
        
        appmodel = AppModel.getInstance();
        settingsvo = appmodel.settingsvo;

        generateBackground();
        generateInfo();

        if(resize){
            appmodel.addEventListener(AppModel.RESIZED, resizeHandler);
        }

    }

    private function generateInfo():void {

        var infoTxtConfig:Object = {};
        infoTxtConfig.text = settingsvo.userName +"  -  "+settingsvo.createdDate;
        infoTxtConfig.width = appmodel.windowWidth - 10;
        infoTxtConfig.height = settingsvo.infoFontSize *2;
        infoTxtConfig.fontSize = settingsvo.infoFontSize;
        infoTxtConfig.fontname = settingsvo.infoFont;
        infoTxtConfig.color = settingsvo.infoColor;
        infoTxtConfig.hAlign = HAlign.RIGHT;
        infoTxtConfig.vAlign = VAlign.BOTTOM;
        infotext = TextfieldFactory.createTextField(infoTxtConfig);

        addChild(infotext);
        infotext.x = 0;
        infotext.y = appmodel.windowHeight - (infotext.height + infotext.textBounds.height + 10);
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
        setChildIndex(background, 0);
        background.x = background.y = 0;
    }

    private function resizeHandler(event:Event):void {

        if( background != null ) removeChild(background);
        generateBackground();

        infotext.x = appmodel.windowWidth - infotext.width - 10;
        if( appmodel.fullscreen )
            infotext.y = appmodel.windowHeight - infotext.height - 10;
        else
            infotext.y = appmodel.windowHeight - (infotext.height + infotext.textBounds.height + 10);
    }
}
}
