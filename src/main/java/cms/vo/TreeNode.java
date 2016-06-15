package cms.vo;

import java.io.Serializable;
import java.util.*;

public class TreeNode implements Serializable {
    private static final Long serialVersionUID = 1L;
    private Integer id;
    // 父级id
    private Integer pid;
    // 名称
    private String name;
    // 链接
    private String url;
    // 图标
    private String icon;
    // 排序
    private int order;
    // 深度
    private int deep = -1;
    // 数量
    private int sum = 0;
    // 是否打开
    private boolean open = false;
    // 有子节点吗
    private boolean hasChild = false;
    // 子节点集合
    private List<TreeNode> items;

    public TreeNode() {
    }

    public TreeNode(Integer id, Integer pid, String name, String url, String icon) {
        this.id = id;
        this.pid = pid;
        this.name = name;
        this.url = url;
        this.icon = icon;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public int getDeep() {
        return deep;
    }

    public void setDeep(int deep) {
        this.deep = deep;
    }

    public int getSum() {
        return sum;
    }

    public void setSum(int sum) {
        this.sum = sum;
    }

    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }

    public boolean isHasChild() {
        return hasChild;
    }

    public void setHasChild(boolean hasChild) {
        this.hasChild = hasChild;
    }

    public List<TreeNode> getItems() {
        return items;
    }

    public void setItems(List<TreeNode> items) {
        this.items = items;
    }

    public void addChild(TreeNode node) {
        if (items == null) {
            items = new LinkedList<TreeNode>();
        }
        items.add(node);
    }
}
