package be.devine.cp3.VO {

public class SettingsVO {

    /**** VARIABELEN ****/

    public var backgroundType:String;
    public var backgroundColor1:uint;
    public var backgroundColor2:uint;
    public var gradientType:String = "linear";
    public var userName:String;
    public var createdDate:String;
    public var titleFontSize:uint;
    public var titleFont:String;
    public var titleColor:uint;
    public var listFontSize:uint;
    public var listFont:String;
    public var listColor:uint;


    /**** CONSTRUCTOR ****/
    public function SettingsVO() {
    }

    /**** METHODS ****/
}
}