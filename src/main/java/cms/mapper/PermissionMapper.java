package cms.mapper;

import java.util.List;

import cms.po.Permission;
import cms.mapper.base.BasicMapper;

public interface PermissionMapper extends BasicMapper<Permission> {

    public List<Permission> getByUserId(int userId);
}
