package be.devine.cp3.factory.vo {
import be.devine.cp3.VO.SlideVO;

public class SlideVOFactory {


    public static function createSlideVOFromXML(slide:XML):SlideVO {

        //TODO vragen ofdat het nog meer moet opgeslitst worden

        var slidevo:SlideVO = new SlideVO();
        slidevo.slideType = slide.@type;
        slidevo.slideNumber = slide.@page;
        slidevo.transition = slide.@transition;

        if(slidevo.slideType == "image" || slidevo.slideType == "image+list"    ){
            slidevo.img_path = slide.img.img_path;
            slidevo.img_scale = Number(slide.img.scale);
            slidevo.img_xpos = uint(slide.img.@xpos);
            slidevo.img_ypos = uint(slide.img.@ypos);
        }

        if(slidevo.slideType != "image"){
            slidevo.title = slide.title;
        }

        if(slidevo.slideType == "title+list" || slidevo.slideType == "image+list" ){
            for each(var li:XML in slide.list.text){
                slidevo.list.push(li.text().toString());
            }
        }

        return slidevo;
    }
}
}
