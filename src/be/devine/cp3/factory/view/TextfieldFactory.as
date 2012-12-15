package be.devine.cp3.factory.view
{

import starling.text.TextField;
import starling.utils.Color;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class TextfieldFactory
	{
        [Embed(source="/assets/fonts/Liberator.ttf", embedAsCFF="false", fontFamily="liberator")]
        private static const LiberatorFont:Class;
        [Embed(source="/assets/fonts/QuaverSans.otf", embedAsCFF="false", fontFamily="quaver")]
        private static const QuaverFont:Class;


//        public static function create(width:int,
//                                      height:int,
//                                      text:String,
//                                      autoscale:Boolean = false,
//                                      color:Number = 0xffffff,
//                                      fontname:String = "quaver",
//                                      fontsize:int = 12,
//                                      align:String = HAlign.LEFT,
//                                      verticalalign:String = VAlign.TOP
//                                            ):TextField{
//
//            var textfield:TextField = new TextField(width, height, text);
//            textfield.autoScale = autoscale;
//            textfield.color = color;
//            textfield.fontName = fontname;
//            textfield.fontSize = fontsize;
//            textfield.hAlign = align;
//            textfield.vAlign = verticalalign;
//            return textfield;
//        }

        public static function createTextField(config:Object):TextField {

            var t:TextField = new TextField(200, 20, 'dummy text');
            t.color = Color.BLACK;
            t.fontSize = 14;
            t.hAlign = HAlign.LEFT;
            t.vAlign = VAlign.TOP;
            t.border = false;

            if(config.text != null)
                if(config.bullet == null){
                    t.text = config.text;
                }else{
                    t.text = config.bullet + "  " + config.text;
                    t.autoScale = true;
                }
            if(config.width != null)
                t.width = config.width;
            if(config.height != null)
                t.height = config.height;
            if(config.color != null)
                t.color = config.color;
            if(config.fontName != null)
                t.fontName = config.fontName;
            if(config.fontSize != null)
                t.fontSize = config.fontSize;
            if(config.hAlign != null)
                t.hAlign = config.hAlign;
            if(config.vAlign != null)
                t.vAlign = config.vAlign;
            return t;
        }
	}
}