package cms.web.admin;

import cms.po.Role;
import cms.po.User;
import cms.po.UserRole;
import cms.service.RoleService;
import cms.service.UserRoleService;
import cms.service.UserService;
import cms.vo.Page;
import cms.web.admin.base.BaseController;
import cms.web.shiro.ShiroDbRealm;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/user")
public class UserController extends BaseController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private UserRoleService userRoleService;
    @Autowired
    private ShiroDbRealm shiroDbRealm;

    @RequestMapping(value = StringUtils.EMPTY)
    public String list(@RequestParam(value = "cName", defaultValue = StringUtils.EMPTY) String cName,
                       @RequestParam(value = "page", defaultValue = "1") int current, Model model) {

        Page page = new Page();
        Map<String, Object> conditions = new HashMap<String, Object>();
        conditions.put("cName", cName);
        page.setConditions(conditions);
        page.setCurrent(current);
        userService.getByPage(page);
        model.addAttribute("page", page);

        return "admin/user_list";
    }

    @RequestMapping(value = "edit")
    public String edit(@RequestParam(value = "id", required = false) Integer id, Model model) {
        User user = null;
        int[] roleIds = null;
        if (id != null && id != 0) {
            user = userService.getById(id);

            // 用于给之前选中的角色设置选中状态
            List<UserRole> userRoles = userRoleService.getByUserId(user.getId());
            roleIds = new int[userRoles.size()];
            roleIds = new int[userRoles.size()];
            for (int i = 0; i < userRoles.size(); i++) {
                roleIds[i] = userRoles.get(i).getRoleId();
            }
        } else {
            user = new User();
        }

        model.addAttribute("user", user);
        List<Role> roles = roleService.getAll();
        model.addAttribute("roles", roles);
        model.addAttribute("roleIds", roleIds);
        return "admin/user_edit";
    }

    @RequiresPermissions("user:save")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@ModelAttribute User user, int[] roleIds, Model model) {
        if (StringUtils.isBlank(user.getUsername())) {
            model.addAttribute("username", "用户名不能为空！");
        }
        if (StringUtils.isBlank(user.getPassword())) {
            model.addAttribute("password", "请输入密码！");
        }
        if (!StringUtils.equals(user.getPassword(), user.getRepeatPassword())) {
            model.addAttribute("repeatPassword", "两次输入的密码不一致！");
        }
        if (StringUtils.isBlank(user.getName())) {
            model.addAttribute("name", "请输入昵称！");
        }
        // 校验是否重复

        // Hash加密存储
        String pwd = user.getPassword() != null ? user.getPassword().trim() : StringUtils.EMPTY;
        user.setPassword(shiroDbRealm.encrytPassword(pwd));
        user.setAvatar(StringUtils.EMPTY);
        user.setUid(StringUtils.EMPTY);

        // 新增
        if (user.getId() == 0) {
            userService.insert(user);
        } else {// 修改
            userService.update(user);
        }

        // 处理用户拥有的角色,先删后加
        int id = user.getId();
        userRoleService.deleteByUserId(id);
        if (ArrayUtils.isNotEmpty(roleIds)) {
            for (int roleId : roleIds) {
                UserRole userRole = new UserRole();
                userRole.setUserId(id);
                userRole.setRoleId(roleId);
                userRoleService.insert(userRole);
            }
        }

        return "redirect:/admin/user";
    }

    @RequiresPermissions("user:delete")
    @RequestMapping(value = "delete")
    public String delete(@RequestParam String ids) {
        userService.deleteByIds(ids);
        return "redirect:/admin/user";
    }
}
