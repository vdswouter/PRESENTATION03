package be.devine.cp3.view.components {
import be.devine.cp3.factory.GradientFactory;
import be.devine.cp3.factory.TextfieldFactory;
import be.devine.cp3.VO.SettingsVO;

import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;

public class SlideBackground extends Sprite{

    /**** VARIABELEN ****/

    private var settingsvo:SettingsVO;


    /**** CONSTRUCTOR ****/
    public function SlideBackground(settingsvo:SettingsVO) {
        this.settingsvo = settingsvo;



        generateBackground();
        generateInfo();
    }

    private function generateInfo():void {
        var infotext:TextField;
        var tf:TextFormat = new TextFormat('Quaver Sans',15,0x333333);
        infotext = TextfieldFactory.create(tf, null,0,0,settingsvo.createdDate+"  "+settingsvo.userName);
        addChild(infotext);
        infotext.x = (1024 - 140);
        infotext.y = (768 - 50);
        trace("[infotext width] "+ infotext.width);
    }

    private function generateBackground():void {
        var background:Sprite;

        switch (settingsvo.backgroundType){
            case "linear":
                    background = GradientFactory.createLinear('vertical',1024,768,[settingsvo.backgroundColor1,settingsvo.backgroundColor2],[1,1],[0,255],null);
                break;
            case "reflect":
                    background = GradientFactory.createReflect('vertical',1024,768,[settingsvo.backgroundColor1,settingsvo.backgroundColor2],[1,1],[0,255],null);
                break;
            default:
                background = new Sprite();
                background.graphics.beginFill(settingsvo.backgroundColor1);
                background.graphics.drawRect(0,0,1024,768);
                background.graphics.endFill();
                break;
        }
        addChild(background);
        background.x = background.y = 0;
        background.width = this.width;
        background.height = this.height;
    }

    /**** METHODS ****/
}
}
