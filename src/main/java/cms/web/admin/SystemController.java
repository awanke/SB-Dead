package cms.web.admin;

import cms.web.admin.base.BaseController;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cms.solr.SolrUtil;

@Controller
@RequestMapping("/admin/system")
public class SystemController extends BaseController {

    @RequestMapping(value = StringUtils.EMPTY)
    public String index(Model model) {
        return "admin/system";
    }

    /**
     * 重建索引
     */
    @ResponseBody
    @RequiresPermissions("system:rebuild")
    @RequestMapping(value = "rebuildIndex")
    public String rebuildIndex(@RequestParam(value = "entity", defaultValue = StringUtils.EMPTY) String entity, Model model) {
        if (entity.equals("ENTITY_ARTICLE")) {
            SolrUtil.buildIndex(SolrUtil.ENTITY_ARTICLE, false);
        }
        if (entity.equals("ENTITY_SEARCHLOG")) {
            SolrUtil.buildIndex(SolrUtil.ENTITY_SEARCHLOG, false);
        }
        return StringUtils.EMPTY;
    }

    /**
     * 配合方法rebuildIndex使用,定时访问此方法以在页面显示进度状态
     */
    @ResponseBody
    @RequiresPermissions("system:rebuild")
    @RequestMapping(value = "checkBuildStatus")
    public String checkBuildStatus(@RequestParam(value = "entity", defaultValue = StringUtils.EMPTY) String entity, Model model) {
        if (entity.equals("ENTITY_ARTICLE")) {
            return SolrUtil.checkBuildStatus(SolrUtil.ENTITY_ARTICLE);
        }

        if (entity.equals("ENTITY_SEARCHLOG")) {
            return SolrUtil.checkBuildStatus(SolrUtil.ENTITY_SEARCHLOG);
        }
        return StringUtils.EMPTY;
    }
}
