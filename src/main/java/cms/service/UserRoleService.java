package cms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cms.po.UserRole;
import cms.mapper.UserRoleMapper;

@Component
public class UserRoleService {
    @Autowired
    private UserRoleMapper userRoleMapper;

    public void insert(UserRole userRole) {
        userRoleMapper.insert(userRole);
    }

    public void deleteByUserId(int userId) {
        userRoleMapper.deleteByUserId(userId);
    }

    public List<UserRole> getByUserId(int userId) {
        return userRoleMapper.getByUserId(userId);
    }
}
