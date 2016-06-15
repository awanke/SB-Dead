package cms.web.admin;

import cms.po.Catalog;
import cms.service.CatalogService;
import cms.utils.TreeUtil;
import cms.vo.Page;
import cms.web.admin.base.BaseController;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/catalog")
public class CatalogController extends BaseController {
    @Autowired
    private CatalogService catalogService;

    @RequestMapping(value = StringUtils.EMPTY)
    public String page(@RequestParam(value = "page", defaultValue = "1") int current, Model model) {
        Page page = new Page();
        page.setConditions(null);
        page.setCurrent(current);
        catalogService.getByPage(page);

        model.addAttribute("page", page);
        return "admin/catalog_list";
    }

    @RequiresPermissions("catalog:save")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@ModelAttribute Catalog catalog) {
        if (catalog.getPid() == 0) {
            catalog.setDeep(1);
        } else {
            Catalog c = catalogService.getById(catalog.getPid());
            catalog.setDeep(c.getDeep() + 1);
        }

        // 新增
        if (catalog.getId() == 0) {
            catalogService.insert(catalog);
        } else {// 修改
            catalogService.update(catalog);
        }
        return "redirect:/admin/catalog";
    }

    @RequestMapping(value = "edit")
    public String edit(@RequestParam(value = "id", required = false) Integer id, Model model) {
        Catalog catalog = null;
        if (id != null && id != 0) {
            catalog = catalogService.getById(id);
        } else {
            catalog = new Catalog();
        }
        model.addAttribute("catalog", catalog);
        model.addAttribute("catalogList", TreeUtil.baseTreeNode(TreeUtil.catalog2TreeNode(catalogService.getAll())));
        return "admin/catalog_edit";
    }
}
