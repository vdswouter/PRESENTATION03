package be.devine.cp3.factory.view
{

import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class TextfieldFactory
	{
        [Embed(source="/assets/fonts/Liberator.ttf", embedAsCFF="false", fontFamily="liberator")]
        private static const LiberatorFont:Class;
        [Embed(source="/assets/fonts/QuaverSans.otf", embedAsCFF="false", fontFamily="quaver")]
        private static const QuaverFont:Class;


        public static function create(width:int,
                                      height:int,
                                      text:String,
                                      autoscale:Boolean = false,
                                      color:Number = 0xffffff,
                                      fontname:String = "Verdana",
                                      fontsize:int = 12,
                                      align:String = HAlign.LEFT,
                                      verticalalign:String = VAlign.TOP
                                            ):TextField{

            var textfield:TextField = new TextField(width, height, text);
            textfield.autoScale = autoscale;
            textfield.color = color;
            textfield.fontName = fontname;
            textfield.fontSize = fontsize;
            textfield.hAlign = align;
            textfield.vAlign = verticalalign;
            return textfield;
        }
	}
}