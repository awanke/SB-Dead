package cms.web.shiro;

import java.io.Serializable;

/**
 * 自定义Authentication对象,使得Subject除了携带用户的登录名外还可以携带更多信息.
 */
public class ShiroUser implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String username;
    private String name;
    private int source;

    public ShiroUser(int id, String username, String name, int source) {
        this.id = id;
        this.username = username;
        this.name = name;
        this.source = source;
    }

    public String getName() {
        return name;
    }

    public String getUsername() {
        return username;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSource() {
        return source;
    }

    public void setSource(int source) {
        this.source = source;
    }

    /**
     * 默认的<shiro:principal/>输出
     */
    @Override
    public String toString() {
        return name;
    }
}