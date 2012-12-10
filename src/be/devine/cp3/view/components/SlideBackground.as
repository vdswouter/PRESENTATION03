package be.devine.cp3.view.components {
import be.devine.cp3.VO.SettingsVO;
import be.devine.cp3.factory.view.TextfieldFactory;
import be.devine.cp3.model.AppModel;

import starling.core.Starling;
import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;

public class SlideBackground extends Sprite{

    /**** VARIABELEN ****/

    private var settingsvo:SettingsVO;
    private var appmodel:AppModel;


    /**** CONSTRUCTOR ****/
    public function SlideBackground() {

        appmodel = AppModel.getInstance();
        settingsvo = appmodel.settingsvo;

        generateInfo();
        generateBackground();
    }

    private function generateInfo():void {

        var infotext:TextField;
        infotext = TextfieldFactory.create(250, 50, settingsvo.userName +"  -  "+settingsvo.createdDate, true, settingsvo.listColor, settingsvo.listFont, 20);
        addChild(infotext);
        infotext.x = (Starling.current.stage.stageWidth - 250);
        infotext.y = (Starling.current.stage.stageHeight - 50);
    }

    private function generateBackground():void {

        var background:Quad;
        background = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight);

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
}
}
