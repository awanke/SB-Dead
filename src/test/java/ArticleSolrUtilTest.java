import cms.po.Article;
import cms.solr.SolrUtil;
import cms.vo.Page;
import org.junit.Assert;
import org.junit.Test;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ArticleSolrUtilTest {

    @Test
    public void add() {
        Article article = new Article();
        article.setId(999999);
        article.setTitle("这是一个测试的标题1");
        article.setDescription("这里是简介2");
        article.setWriter("David3");
        article.setCatalogId(2);
        article.setCreateDate(new Date());
        article.setContent("这是文章的正文部分");
        SolrUtil.insert(article);
    }

    @Test
    public void deleteAll() {
        SolrUtil.deleteAll();
    }

    @Test
    public void dataImport() {
        SolrUtil.buildIndex(SolrUtil.ENTITY_ARTICLE, false);
    }

    @Test
    public void getByPage() {
        Map<String, Object> conditions = new HashMap<String, Object>();
        conditions.put("kw", "标题");
        conditions.put("catalog", "2");
        conditions.put("writer", "David3");

        Page page = new Page();
        page.setConditions(conditions);

        SolrUtil.getByPage(page);
        for (Object o : page.getDatas()) {
            Article a = (Article) o;
            System.out.println(a.getTitle());
        }
    }

    @Test
    public void getRelated() {
        List<Article> articles = SolrUtil.getRelated(42, 5);
        for (Article article : articles) {
            System.out.println(article.getTitle());
        }
        Assert.assertTrue("solr未解析到相似文章数据", articles.size() > 0);
    }

    @Test
    public void getAnalysis() {
        List<String> results = SolrUtil.getAnalysis("DevNote与大家分享开发实践经验");
        for (String word : results) {
            System.out.println(word);
        }
    }

    @Test
    public void getSuggestions() {
        List<String> strs = SolrUtil.getSuggestions("\"solr 系\"");
        for (int i = 0; i < strs.size(); i++) {
            System.out.println(strs.get(i));
        }
    }
}
