package cms.mapper;

import java.util.List;
import java.util.Map;

import cms.po.Article;
import cms.mapper.base.BasicMapper;

public interface ArticleMapper extends BasicMapper<Article> {

    /**
     * 更新文章浏览量
     *
     * @param #{ key:id }        文章ID
     * @param #{ key:pageView } 文章浏览量
     */
    public void updatePageView(Map<String, Integer> params);

    public List<Article> getByCatalogId(int catalogId);

    public Article getByName(String name);

    public Article getPre(Map<String, Object> params);

    public Article getNext(Map<String, Object> params);

    public List<Map<String, Object>> getStatByMonth();

//    public List<Map<String, Object>> getAllByMonth(Map<String, Object> params);
}
