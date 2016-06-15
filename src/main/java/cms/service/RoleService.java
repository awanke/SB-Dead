package cms.service;

import cms.mapper.RoleMapper;
import cms.mapper.RolePermissionMapper;
import cms.mapper.UserRoleMapper;
import cms.po.Role;
import cms.vo.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RoleService {
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private RolePermissionMapper rolePermissionMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;

    public void insert(Role role) {
        roleMapper.insert(role);
    }

    public void deleteById(int id) {
        roleMapper.deleteById(id);
    }

    public void deleteByIds(String ids) {
        for (String id : ids.split(",")) {
            roleMapper.deleteById(Integer.parseInt(id));
            rolePermissionMapper.deleteByRoleId(Integer.parseInt(id));
            userRoleMapper.deleteByRoleId(Integer.parseInt(id));
        }
    }

    public void update(Role role) {
        roleMapper.update(role);
    }

    public Role getById(int id) {
        return roleMapper.getById(id);
    }

    public List<Role> getAll() {
        return roleMapper.getAll();
    }

    public List<Role> getByUserId(int userId) {
        return roleMapper.getByUserId(userId);
    }

    public Page getByPage(Page page) {
        List<Object> plans = roleMapper.getByPage(page);
        Long count = roleMapper.getCountByPage(page);
        page.setDatas(plans);
        page.setCount(count);
        return page;
    }
}
