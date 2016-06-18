package cms.service;

import cms.po.Article;
import cms.myenum.ArticleEnum;
import cms.mapper.ArticleMapper;
import cms.solr.SolrUtil;
import cms.vo.Page;
import cms.web.shiro.ShiroUser;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class ArticleService {
    @Autowired
    private ArticleMapper articleMapper;
    @Autowired
    private StaticService staticService;

    public void insert(Article article) {
        articleMapper.insert(article);
    }

    public void deleteByIds(String ids) {
        for (String id : ids.split(",")) {
            Article article = articleMapper.getById(Integer.parseInt(id));

            // 检查
            check(article.getWriter());

            articleMapper.deleteById(Integer.parseInt(id));

            SolrUtil.buildIndex(SolrUtil.ENTITY_ARTICLE, true);
        }
    }

    public void update(Article article) {
        // 检查
        check(article.getWriter());

        articleMapper.update(article);
        if (article.getStatus() == ArticleEnum.ARTICLE_STATUS_PUBLISHED) {
        }

        SolrUtil.buildIndex(SolrUtil.ENTITY_ARTICLE, true);
    }

    /**
     * 用于校验当前用户是否有权修改或删除文章
     */
    private void check(String writer) {
        Subject subject = SecurityUtils.getSubject();
        String name = ((ShiroUser) subject.getPrincipal()).getName();

        // 作者本人可修改、管理员可修改、发布者可修改
        if (!StringUtils.equals(name, writer) && !subject.hasRole("admin") && !subject.isPermitted("aticle:publish")) {
            throw new org.apache.shiro.authz.UnauthorizedException();
        }
    }

    public void publishByIds(String ids, HttpServletRequest request) {
        for (String id : ids.split(",")) {
            Article article = articleMapper.getById(Integer.parseInt(id));
            // 已发布过的文章无需再发布
            if (article.getStatus() == ArticleEnum.ARTICLE_STATUS_PUBLISHED) {
                continue;
            }

            article.setStatus(ArticleEnum.ARTICLE_STATUS_PUBLISHED);
            article.setPublishDate(new Date());
            articleMapper.update(article);

            // staticService.staticOne(article, request);
        }
        SolrUtil.buildIndex(SolrUtil.ENTITY_ARTICLE, true);
    }

    public void preview(String id, HttpServletRequest request) {
        Article article = articleMapper.getById(Integer.parseInt(id));
        // staticService.staticOne(article, request);
    }

    public void updatePageView(int id, int num) {
        HashMap<String, Integer> params = new HashMap<String, Integer>();
        params.put("id", id);
        params.put("pageView", num);
        articleMapper.updatePageView(params);
    }

    public Article getById(int id) {
        return articleMapper.getById(id);
    }

    public Article getPre(int catalogId, Date createDate) {
        HashMap<String, Object> params = new HashMap<String, Object>();
        params.put("catalogId", catalogId);
        params.put("createDate", createDate);
        return articleMapper.getPre(params);
    }

    public Article getNext(int catalogId, Date createDate) {
        HashMap<String, Object> params = new HashMap<String, Object>();
        params.put("catalogId", catalogId);
        params.put("createDate", createDate);
        return articleMapper.getNext(params);
    }

    public Page getByPage(Page page) {
        List<Object> articles = articleMapper.getByPage(page);
        Long count = articleMapper.getCountByPage(page);
        page.setDatas(articles);
        page.setCount(count);
        return page;
    }

    public Article getByName(String name) {
        return articleMapper.getByName(name);
    }

    public List<Article> getAll() {
        return articleMapper.getAll();
    }

    public List<Article> getByCatalogId(int catalogId) {
        return articleMapper.getByCatalogId(catalogId);
    }

    public List<Map<String, Object>> getStatByMonth() {
        return articleMapper.getStatByMonth();
    }

//    public List<Map<String, Object>> getAllByMonth(Map<String, Object> params) {
//        return articleMapper.getAllByMonth(params);
//    }
}
