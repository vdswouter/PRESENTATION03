package be.devine.cp3.view.components {
import be.devine.cp3.Factory.GradientFactory;
import be.devine.cp3.Factory.TextfieldFactory;
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

        this.width = 1024;
        this.height = 768;

        generateBackground();
        generateInfo();
    }

    private function generateInfo():void {
        var infotext:TextField;
        var tf:TextFormat = new TextFormat('Quaver Sans',13,0x333333);
        infotext = TextfieldFactory.create(tf, null,0,0,settingsvo.createdDate+"  "+settingsvo.userName);
        addChild(infotext);
        infotext.x = this.width - infotext.width -10;
        infotext.y = this.height - infotext.height -10;
    }

    private function generateBackground():void {
        var background:Sprite;

        switch (settingsvo.backgroundType){
            case "linear":
                    background = GradientFactory.createLinear('vertical',this.width,this.height,[settingsvo.backgroundColor1,settingsvo.backgroundColor2],[1,1],[0,255],null);
                break;
            case "reflect":
                    background = GradientFactory.createReflect('vertical',this.width,this.height,[settingsvo.backgroundColor1,settingsvo.backgroundColor2],[1,1],[0,255],null);
                break;
            default:
                background = new Sprite();
                background.graphics.beginFill(settingsvo.backgroundColor1);
                background.graphics.drawRect(0,0,this.width,this.height);
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
