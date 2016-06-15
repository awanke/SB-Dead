package cms.mapper;

import java.util.List;

import cms.po.RolePermission;
import cms.mapper.base.BasicMapper;

public interface RolePermissionMapper extends BasicMapper<RolePermission> {

    public void deleteByRoleId(int roleId);

    public void deleteByPermissionId(int permissionId);

    public List<RolePermission> getByRoleId(int roleId);
}
