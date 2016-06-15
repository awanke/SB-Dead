package cms.web.admin;

import cms.po.Permission;
import cms.po.Role;
import cms.po.RolePermission;
import cms.service.PermissionService;
import cms.service.RolePermissionService;
import cms.service.RoleService;
import cms.vo.Page;
import cms.web.admin.base.BaseController;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

import static com.sun.xml.internal.ws.api.model.wsdl.WSDLBoundOperation.ANONYMOUS.required;

@Controller
@RequestMapping("/admin/role")
public class RoleController extends BaseController {
    @Autowired
    private RoleService roleService;
    @Autowired
    private PermissionService permissionService;
    @Autowired
    private RolePermissionService rolePermissionService;

    @RequestMapping(value = StringUtils.EMPTY)
    public String page(@RequestParam(value = "page", defaultValue = "1") int current, Model model) {
        Page page = new Page();
        page.setConditions(null);
        page.setCurrent(current);
        roleService.getByPage(page);

        model.addAttribute("page", page);
        return "admin/role_list";
    }

    @RequiresPermissions("role:save")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@ModelAttribute Role role, @RequestParam(value = "permissionIds", required = false) Integer[] permissionIds) {
        // 新增
        if (role.getId() == 0) {
            roleService.insert(role);
        } else {// 修改
            roleService.update(role);
        }

        // 处理角色拥有的权限（映射表），先删后加
        int id = role.getId();
        rolePermissionService.deleteByRoleId(id);
        if (ArrayUtils.isNotEmpty(permissionIds)) {
            for (int permissionId : permissionIds) {
                RolePermission rolePermission = new RolePermission();
                rolePermission.setRoleId(id);
                rolePermission.setPermissionId(permissionId);
                rolePermissionService.insert(rolePermission);
            }
        }
        return "redirect:/admin/role";
    }

    /**
     * 添加,修改页面跳转
     */
    @RequestMapping(value = "edit")
    public String edit(@RequestParam(value = "id", required = false) Integer id, Model model) {
        Role role = null;
        int[] permissionIds = null;
        if (id != null && id != 0) {
            role = roleService.getById(id);

            // 用于给之前选中的权限设置选中状态
            List<RolePermission> rolePermissions = rolePermissionService.getByRoleId(role.getId());
            permissionIds = new int[rolePermissions.size()];
            for (int i = 0; i < rolePermissions.size(); i++) {
                permissionIds[i] = rolePermissions.get(i).getPermissionId();
            }
        } else {
            role = new Role();
        }

        model.addAttribute("role", role);
        List<Permission> permissions = permissionService.getAll();
        model.addAttribute("permissions", permissions);
        model.addAttribute("permissionIds", permissionIds);
        return "admin/role_edit";
    }

    @RequiresPermissions("role:delete")
    @RequestMapping(value = "delete")
    public String delete(@RequestParam String ids) {
        // 由于设置了外键级联删除,会同步删除映射表中的数据
        roleService.deleteByIds(ids);
        return "redirect:/admin/role";
    }
}
