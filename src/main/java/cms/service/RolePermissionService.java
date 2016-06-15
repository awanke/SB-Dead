package cms.service;

import cms.po.RolePermission;
import cms.mapper.RolePermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class RolePermissionService {
    @Autowired
    private RolePermissionMapper rolePermissionMapper;

    public void insert(RolePermission rolePermission) {
        rolePermissionMapper.insert(rolePermission);
    }

    public void deleteByRoleId(int roleId) {
        rolePermissionMapper.deleteByRoleId(roleId);
    }

    public List<RolePermission> getByRoleId(int roleId) {
        return rolePermissionMapper.getByRoleId(roleId);
    }
}
