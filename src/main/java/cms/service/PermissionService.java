package cms.service;

import cms.mapper.PermissionMapper;
import cms.mapper.RolePermissionMapper;
import cms.po.Permission;
import cms.vo.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
public class PermissionService {
    @Autowired
    private PermissionMapper permissionMapper;
    @Autowired
    private RolePermissionMapper rolePermissionMapper;

    public void insert(Permission permission) {
        permissionMapper.insert(permission);
    }

    public void deleteByIds(String ids) {
        for (String id : ids.split(",")) {
            permissionMapper.deleteById(Integer.parseInt(id));
            rolePermissionMapper.deleteByPermissionId(Integer.parseInt(id));
        }
    }

    public void update(Permission permission) {
        permissionMapper.update(permission);
    }

    public Permission getById(int id) {
        return permissionMapper.getById(id);
    }

    public List<Permission> getAll() {
        return permissionMapper.getAll();
    }

    public List<Permission> getByUserId(int userId) {
        return permissionMapper.getByUserId(userId);
    }

    public Page getByPage(Page page) {
        List<Object> plans = permissionMapper.getByPage(page);
        Long count = permissionMapper.getCountByPage(page);
        page.setDatas(plans);
        page.setCount(count);
        return page;
    }
}
