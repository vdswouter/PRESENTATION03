package be.devine.cp3.utils {
import flash.text.Font;

public class OverloopFonts {

    /**** VARIABELEN ****/


    /**** CONSTRUCTOR ****/
    public function OverloopFonts() {
    }

    /**** METHODS ****/

    public static function overloopGeembeddeFontsInSWF():void {
        trace("--- Ik start met overlopen van alle fonts");
        for each( var f:Font in Font.enumerateFonts() ){
            trace("Font = " + f.fontName);
        }
        trace("--- Einde overlopen fonts");
    }

}
}
