package cms.web.admin.base;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import java.text.SimpleDateFormat;
import java.util.Date;

public class BaseController {

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:MM:ss");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
}
