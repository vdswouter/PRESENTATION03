package be.devine.cp3.factory.vo {
import be.devine.cp3.VO.SettingsVO;

public class SettingsVOFactory {

    public static function createSettingsFromXML(loadedXML:XML):SettingsVO {

        var settingsvo:SettingsVO = new SettingsVO();

        settingsvo.backgroundType = String(loadedXML.project.theme.background.@style);
        settingsvo.backgroundColor1 = uint("0x"+loadedXML.project.theme.background.color[0].text());
        if(settingsvo.backgroundType != "solid"){
            settingsvo.backgroundColor2 = uint("0x"+loadedXML.project.theme.background.color[1].text());
            settingsvo.gradientDirection = String(loadedXML.project.theme.background.@direction);
        }
        settingsvo.userName = loadedXML.project.user.name;
        settingsvo.createdDate = loadedXML.project.user.created;
        settingsvo.titleColor = uint("0x"+loadedXML.project.title.color);
        settingsvo.titleFont = loadedXML.project.title.font;
        settingsvo.titleFontSize = uint(loadedXML.project.title.size);
        settingsvo.listColor = uint("0x"+loadedXML.project.list.color);
        settingsvo.listFont = loadedXML.project.list.font;
        settingsvo.listFontSize = uint(loadedXML.project.list.size);
        settingsvo.bullet = String(loadedXML.project.list.bullet);
        settingsvo.activeSlideBGColor = uint('0x'+loadedXML.project.slide.active_color);

        return settingsvo;
    }
}
}
