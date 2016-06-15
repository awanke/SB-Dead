package cms.mapper;

import java.util.List;

import cms.po.Role;
import cms.mapper.base.BasicMapper;

public interface RoleMapper extends BasicMapper<Role> {

    public List<Role> getByUserId(int userId);
}
