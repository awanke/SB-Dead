package cms.service;

import java.util.HashMap;
import java.util.List;

import cms.myenum.RoleEnum;
import cms.myenum.UserEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cms.vo.Page;
import cms.po.User;
import cms.po.UserRole;
import cms.mapper.UserMapper;
import cms.mapper.UserRoleMapper;

import static org.apache.shiro.web.filter.mgt.DefaultFilter.user;

@Component
public class UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;

    public void insert(User user) {
        userMapper.insert(user);
    }

    public void insertWithDefaultRole(User user) {
        userMapper.insert(user);
        UserRole userRole = new UserRole();
        userRole.setUserId(user.getId());
        userRole.setRoleId(RoleEnum.ROLE_USER);
        userRoleMapper.insert(userRole);
    }

    public void deleteByIds(String ids) {
        for (String id : ids.split(",")) {
            userMapper.deleteById(Integer.parseInt(id));
        }
    }

    public void update(User user) {
        userMapper.update(user);
    }

    public User getById(int id) {
        return userMapper.getById(id);
    }

    public User getByUserName(String username) {
        return userMapper.getByUserName(username);
    }

    public User getByUidAndSource(String uid, int source) {
        HashMap<String, Object> params = new HashMap<String, Object>();
        params.put("uid", uid);
        params.put("source", source);
        return userMapper.getByUidAndSource(params);
    }

    public Page getByPage(Page page) {
        List<Object> users = userMapper.getByPage(page);
        Long count = userMapper.getCountByPage(page);
        page.setDatas(users);
        page.setCount(count);
        return page;
    }
}
