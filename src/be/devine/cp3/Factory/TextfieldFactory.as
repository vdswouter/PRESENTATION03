package be.devine.cp3.Factory
{
import flash.display.DisplayObjectContainer;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class TextfieldFactory
	{
		public static function create(format:TextFormat,
									  parent:DisplayObjectContainer = null,
									  x:Number = 0, y:Number = 0,
									  text:String = ""):TextField
		{
			var textField:TextField = new TextField();
			textField.defaultTextFormat = format;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.multiline = false;
			textField.selectable = false;
			//textField.embedFonts = true;
			textField.text = text;
			textField.x = x;
			textField.y = y;
			if(parent != null)
				parent.addChild(textField);

			return textField;
		}
	}
}