package cms.web.front;

import cms.config.GlobalConfig;
import cms.po.Article;
import cms.po.Attachment;
import cms.service.ArticleService;
import cms.service.AttachmentService;
import cms.service.CatalogService;
import cms.solr.SolrUtil;
import cms.utils.MyObjectMapper;
import cms.utils.RegexUtil;
import cms.utils.TreeUtil;
import cms.web.admin.base.BaseController;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/")
public class ArticleControl extends BaseController {
    private static Logger log = Logger.getLogger(ArticleControl.class);
    @Autowired
    private ArticleService articleService;
    @Autowired
    private AttachmentService attachmentService;
    @Autowired
    private CatalogService catalogService;

    @RequestMapping("/article/{id}")
    public String article(@PathVariable("id") int id, HttpServletRequest request, HttpServletResponse response, Model model) {
        Article article = articleService.getById(id);

        // 更新文章浏览量
        article.setPageView(article.getPageView() + 1);
        articleService.updatePageView(article.getId(), article.getPageView());
        SolrUtil.update(article);

        // 处理内容中图片的相对路径
        article.setContent(article.getContent().replaceAll("<img src=\"(.*?)\"", "<img src=\"" + GlobalConfig.websiteUr + "$1\""));
        // 移动客户端文章正文中的相对站内地址需要加mobile前缀
        article.setContent(article.getContent().replaceAll("<a href=\"(/article/.*?)\"", "<a href=\"/mobile" + "$1\""));

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

        model.addAttribute("article", article);
        model.addAttribute("relativeArticles", relativeArticles);
        model.addAttribute("preArticle", preArticle);
        model.addAttribute("nextArticle", nextArticle);
        model.addAttribute("monthStat", articleService.getStatByMonth());
        model.addAttribute("catalogList", TreeUtil.baseTreeNode(TreeUtil.catalog2TreeNode(catalogService.getAll())));
        String requestURL = request.getRequestURL().toString();
        model.addAttribute("baseURL", "http://" + RegexUtil.getRegexGroup("//(.*?)/", requestURL, 1));

        if ("markdown".equals(article.getEnvironment())) {
            return "article";
        } else {
            return "article_tiny_mce";
        }
    }

    /**
     * 根据文章id获取对应的附件列表
     */
    @RequestMapping(value = "/attachments")
    public void getAttachments(@RequestParam("articleId") int articleId, @RequestParam("callback") String callback, HttpServletResponse response) {
        List<Attachment> attachments = attachmentService.getByArticleId(articleId);
        String body = StringUtils.EMPTY;
        try {
            body = new MyObjectMapper().writeValueAsString(attachments);
        } catch (Exception e) {
            log.error("显示附件列表时写json错误", e);
        }

        try {
            response.getWriter().print(callback + "(" + body + ")");
        } catch (IOException e) {
            log.error("返回附件列表时遇到错误", e);
        }
    }
}
