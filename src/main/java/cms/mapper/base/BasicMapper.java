package cms.mapper.base;

import java.io.Serializable;
import java.util.List;

import cms.vo.Page;

public interface BasicMapper<T> {

    /**
     * 插入新对象
     */
    public void insert(T o);

    /**
     * 插入或更新对象
     */
    public void insertOrUpdate(T o);

    /**
     * 删除一个或多个对象
     */
    public void delete(T o);

    /**
     * 根据对象id删除单一对象
     */
    public void deleteById(Serializable id);

    /**
     * 更新修改的对象
     */
    public void update(T o);

    /**
     * 根据对象id获取单一对象
     */
    public T getById(Serializable id);

    /**
     * 无条件获取所有对象
     */
    public List<T> getAll();

    /**
     * 根据查询对象获取多个对象
     */
    public List<Object> getByPage(Page page);

    /**
     * 根据查询对象统计结果个数
     */
    public Long getCountByPage(Page page);
}
