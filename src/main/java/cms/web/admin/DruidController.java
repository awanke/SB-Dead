package cms.web.admin;

import cms.web.admin.base.BaseController;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/druid")
public class DruidController extends BaseController {

    @RequestMapping(value = StringUtils.EMPTY)
    public String index() {
        return "admin/druid";
    }
}
