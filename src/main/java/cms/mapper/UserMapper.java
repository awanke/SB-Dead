package cms.mapper;

import java.util.Map;

import cms.po.User;
import cms.mapper.base.BasicMapper;

public interface UserMapper extends BasicMapper<User> {

    public User getByUserName(String username);

    /**
     * 更新文章浏览量
     *
     * @param #{ key:uid }    第三方平台的user id
     * @param #{ key:source } 用户来源
     */
    public User getByUidAndSource(Map<String, Object> params);
}
