package cms.web.shiro;

import cms.po.Permission;
import cms.po.Role;
import cms.po.User;
import cms.service.PermissionService;
import cms.service.RoleService;
import cms.service.UserService;
import cms.utils.ConfigUtil;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.DefaultHashService;
import org.apache.shiro.crypto.hash.Hash;
import org.apache.shiro.crypto.hash.HashRequest;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class ShiroDbRealm extends AuthorizingRealm {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private PermissionService permissionService;

    /**
     * 认证回调函数,登录时调用.
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
        System.out.println("认证回调函数");
        UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
        User user = userService.getByUserName(token.getUsername());
        if (user != null) {
            return new SimpleAuthenticationInfo(new ShiroUser(user.getId(), user.getUsername(), user.getName(), user.getSource()), user.getPassword(), getName());
        } else {
            return null;
        }
    }

    /**
     * 授权查询回调函数,进行鉴权但缓存中无用户的授权信息时调用.
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        System.out.println("授权查询回调函数");
        ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();

        // 加载用户的roles
        List<Role> roles = roleService.getByUserId(shiroUser.getId());
        List<String> stringRoles = new ArrayList<String>(roles.size());
        for (Role role : roles) {
            stringRoles.add(role.getName());
        }

        // 加载用户的permissions
        List<Permission> permissions = permissionService.getByUserId(shiroUser.getId());
        Set<String> stringPermissions = new HashSet<String>(permissions.size());
        for (Permission permission : permissions) {
            stringPermissions.add(permission.getValue());
        }

        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.addRoles(stringRoles);
        info.setStringPermissions(stringPermissions);
        return info;
    }

    /**
     * 生成散列密码,采用spring/shiro.xml配置的SHA-256加密算法.
     * 目前采用SHA-256加密算法,以Base64方式存储,加密迭代次数1024;
     * SHA-256散列的Base64存储需占数据库(44位字符),而Hex存储需占数据库(64位字符);
     * 注意SHA-384,SHA-512哈希加密需占更长字节存储(打印出来可以数一下字符长度)
     */
    public String encrytPassword(String password) {
        // 获取凭证子类配置
        String hashAlgorithmName = ConfigUtil.getValue("password.hash.algorithm.name");
        int iterations = ConfigUtil.getIntValue("password.iterations");
        boolean isStoredHex = ConfigUtil.getBooleanValue("password.is.stored.hex");
        // 散列
        DefaultHashService hashService = new DefaultHashService();
        // 设置算法
        hashService.setHashAlgorithmName(hashAlgorithmName);
        // 迭代次数
        hashService.setHashIterations(iterations);
        // 获取字节
        ByteSource byteSource = ByteSource.Util.bytes(password);
        Hash hash = hashService.computeHash(new HashRequest.Builder().setSource(byteSource).build());
        // 生成Hash值
        return isStoredHex ? hash.toHex() : hash.toBase64();
    }
}
