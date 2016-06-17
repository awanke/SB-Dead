package cms.service;

import cms.myenum.ArticleEnum;
import cms.po.Article;
import cms.solr.SolrUtil;
import cms.utils.ConfigUtil;
import cms.utils.FreeMarkerUtil;
import cms.utils.RegexUtil;
import cms.utils.TreeUtil;
import cms.vo.Page;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class StaticService {
    private static Logger log = Logger.getLogger(StaticService.class);
    @Autowired
    private ArticleService articleService;
    @Autowired
    private CatalogService catalogService;

    public String staticAll(HttpServletRequest request, HttpSession session) {
        Map<String, Object> conditions = new HashMap<String, Object>();
        conditions.put("cStatus", ArticleEnum.ARTICLE_STATUS_PUBLISHED);
        conditions.put("kw", StringUtils.EMPTY);
        conditions.put("catalog", "-1");
        conditions.put("writer", StringUtils.EMPTY);
        conditions.put("orderByTime", true);

        Page p = new Page();
        p.setConditions(conditions);
        p.setCurrent(1);
        SolrUtil.getByPage(p);

        // 文章总篇数
        long total = p.getCount();
        // 每次生成多少静态化页面
        int size = Integer.parseInt(ConfigUtil.getValue("static.page.size"));
        // 一共多少页
        int pages = (int) total / size + 1;
        int current = 0;
        try {
            session.setAttribute("total", total);
            for (int i = 1; i <= pages; i++) {
                Page page = new Page();
                page.setConditions(conditions);
                page.setCurrent(i);
                page.setSize(size);
                SolrUtil.getByPage(page);

                List<Object> articles = page.getDatas();
                for (int k = 0; k < articles.size(); k++) {
                    Article articleF = (Article) articles.get(k);
                    // 获取文章对象
                    Article article = articleService.getById(articleF.getId());
                    this.static4Common(article, request);
                    // 更新session里的值
                    current++;
                    session.setAttribute("current", current);
                }
            }
            session.removeAttribute("current");
            session.removeAttribute("total");
        } catch (Exception e) {
            e.printStackTrace();
            log.error("静态化失败!", e);
            return "静态化失败!";
        }

        String apacheHtdocsDir = ConfigUtil.getValue("apache.htdocs.dir");
        try {
            FileUtils.deleteDirectory(new File(apacheHtdocsDir + "/article"));
        } catch (Exception e) {
            log.error("删除article的文章目录失败!", e);
            return "删除article的文章目录失败!";
        }

        try {
            new File(apacheHtdocsDir + "/articleTemp").renameTo(new File(apacheHtdocsDir + "/article"));
        } catch (Exception e) {
            log.error("文件夹更名失败!", e);
            return "文件夹更名失败!";
        }
        return "静态化成功!";
    }

    /**
     * 静态化页面
     */
    private String static4Common(Article article, HttpServletRequest request) {
        // 处理内容中图片的相对路径
        article.setContent(article.getContent().replaceAll("<img src=\"(.*?)\"", "<img src=\"" + ConfigUtil.getValue("website.url") + "$1\""));

        // 获取相关文章
        List<Article> relativeArticles = SolrUtil.getRelated(article.getId(), 6);
        // 弥补solr获取相关新闻时,直接返回5个以上时出现的bug
        if (relativeArticles.isEmpty()) {
            SolrUtil.getRelated(article.getId(), 1);
            relativeArticles = SolrUtil.getRelated(article.getId(), 6);
        }

        // 获取上一篇文章
        Article preArticle = articleService.getPre(article.getCatalogId(), article.getCreateDate());

        // 获取下一篇文章
        Article nextArticle = articleService.getNext(article.getCatalogId(), article.getCreateDate());


        Map<String, Object> params = new HashMap<String, Object>();

        if (article.getKeywords() != null) {
            params.put("keywords", article.getKeywords());
            params.put("description", article.getDescription());
        } else {
            params.put("keywords", "IT世界");
            params.put("description", "IT世界");
        }

        params.put("article", article);
        params.put("relativeArticles", relativeArticles);
        params.put("preArticle", preArticle);
        params.put("nextArticle", nextArticle);
        params.put("monthStat", articleService.getStatByMonth());
        params.put("catalogList", TreeUtil.baseTreeNode(TreeUtil.catalog2TreeNode(catalogService.getAll())));

        //{ctx=/dead, baseURL=http://localhost:8080}
        String requestURL = request.getRequestURL().toString();
        params.put("baseURL", "http://" + RegexUtil.getRegexGroup("//(.*?)/", requestURL, 1));
        params.put("ctx", request.getContextPath());

        String apacheHtdocsDir = request.getServletContext().getRealPath("/");
        String templatePath = request.getServletContext().getRealPath("/") + "WEB-INF/view/template";

        String targetPath = apacheHtdocsDir + "/articleTemp" + "/" + article.getId() + ".html";
        FreeMarkerUtil.create(templatePath, "article.html", targetPath, params);

        // 带有name值的文章需要连带生成
        if (StringUtils.isNotBlank(article.getName())) {
            FreeMarkerUtil.create(templatePath, "article.html", apacheHtdocsDir + "/" + article.getName() + ".html", params);
        }
        return targetPath;
    }

    public String staticOne(Article article, HttpServletRequest request) {
        String targetPath = this.static4Common(article, request);
        String apacheHtdocsDir = ConfigUtil.getValue("apache.htdocs.dir");

        try {
            FileUtils.copyFileToDirectory(new File(targetPath), new File(apacheHtdocsDir + "/article"));
        } catch (Exception e) {
            log.error("拷贝页面失败!", e);
            return "拷贝页面失败!";
        }

        try {
            FileUtils.deleteDirectory(new File(apacheHtdocsDir + "/articleTemp"));
        } catch (Exception e) {
            log.error("删除articleTemp的文章目录失败!", e);
            return "删除articleTemp的文章目录失败!";
        }

        return "静态化成功!";
    }
}
