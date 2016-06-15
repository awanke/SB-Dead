package cms.mapper;

import java.util.List;

import cms.po.UserRole;
import cms.mapper.base.BasicMapper;

public interface UserRoleMapper extends BasicMapper<UserRole> {
    public void deleteByUserId(int userId);

    public void deleteByRoleId(int userId);

    public List<UserRole> getByUserId(int userId);
}
