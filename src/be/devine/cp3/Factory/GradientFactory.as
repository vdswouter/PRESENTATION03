package be.devine.cp3.Factory {
import flash.display.DisplayObjectContainer;
import flash.display.GradientType;
import flash.display.Graphics;
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.geom.Matrix;

public class GradientFactory {


    public static function createReflect(direction:String,
                                         width:int,
                                         height:int,
                                         colors:Array,
                                         alphas:Array,
                                         ratios:Array,
                                         parent:DisplayObjectContainer = null):Sprite
    {
        var fType:String = GradientType.LINEAR;
        var sprMethod:String = SpreadMethod.REFLECT;

        var sprite:Sprite = new Sprite();
        var graphics:Graphics = sprite.graphics;

        var matr:Matrix = new Matrix();

        if( direction == 'horizontal' )
            matr.createGradientBox(width/2, height, 0, 0, 0);
        else if( direction == 'vertical' )
            matr.createGradientBox(width, height/2, 1.58, 0, 0);

        graphics.beginGradientFill(fType, colors, alphas, ratios, matr, sprMethod);
        graphics.drawRect(0, 0, width, height);

        if(parent != null)
            parent.addChild(sprite);

        return(sprite);
    }

    public static function createLinear(direction:String,
                                        width:int,
                                        height:int,
                                        colors:Array,
                                        alphas:Array,
                                        ratios:Array,
                                        parent:DisplayObjectContainer = null):Sprite
    {
        var fType:String = GradientType.LINEAR;
        var sprMethod:String = SpreadMethod.PAD;

        var sprite:Sprite = new Sprite();
        var graphics:Graphics = sprite.graphics;

        var matr:Matrix = new Matrix();

        if( direction == 'horizontal' )
            matr.createGradientBox(width, height, 0, 0, 0);
        else if( direction == 'vertical' )
            matr.createGradientBox(width, height, 1.58, 0, 0);

        graphics.beginGradientFill(fType, colors, alphas, ratios, matr, sprMethod);
        graphics.drawRect(0, 0, width, height);

        if(parent != null)
            parent.addChild(sprite);

        return(sprite);
    }

}
}
