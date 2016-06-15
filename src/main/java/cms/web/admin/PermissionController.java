package cms.web.admin;

import cms.po.Permission;
import cms.service.PermissionService;
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
@RequestMapping("/admin/permission")
public class PermissionController extends BaseController {
    @Autowired
    private PermissionService permissionService;

    @RequestMapping(value = StringUtils.EMPTY)
    public String page(@RequestParam(value = "page", defaultValue = "1") int current, Model model) {
        Page page = new Page();
        page.setConditions(null);
        page.setCurrent(current);
        permissionService.getByPage(page);

        model.addAttribute("page", page);
        return "admin/permission_list";
    }

    @RequiresPermissions("permission:save")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@ModelAttribute Permission permission) {
        // 新增
        permission.setName(StringUtils.EMPTY);
        if (permission.getId() == 0) {
            permissionService.insert(permission);
        } else {// 修改
            permissionService.update(permission);
        }
        return "redirect:/admin/permission";
    }

    @RequiresPermissions("permission:delete")
    @RequestMapping(value = "delete")
    public String delete(@RequestParam String ids) {
        permissionService.deleteByIds(ids);
        return "redirect:/admin/permission";
    }

    @RequestMapping(value = "edit")
    public String edit(@RequestParam(value = "id", required = false) Integer id, Model model) {
        Permission permission = null;
        if (id != null && id != 0) {
            permission = permissionService.getById(id);
        } else {
            permission = new Permission();
        }

        model.addAttribute("permission", permission);
        return "admin/permission_edit";
    }
}
