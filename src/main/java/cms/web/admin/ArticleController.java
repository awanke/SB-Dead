package cms.web.admin;

import cms.config.GlobalConfig;
import cms.myenum.ArticleEnum;
import cms.po.Article;
import cms.service.ArticleService;
import cms.service.CatalogService;
import cms.utils.ImageUtil;
import cms.utils.TreeUtil;
import cms.utils.UploadUtil;
import cms.vo.Page;
import cms.web.admin.base.BaseController;
import cms.web.shiro.ShiroUser;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin/article")
public class ArticleController extends BaseController {
    private static Logger log = Logger.getLogger(ArticleController.class);
    @Autowired
    private ArticleService articleService;
    @Autowired
    private CatalogService catalogService;

    @RequestMapping(value = StringUtils.EMPTY)
    public String list(
            @RequestParam(value = "cTitle", defaultValue = StringUtils.EMPTY) String cTitle,
            @RequestParam(value = "cCatalog", defaultValue = "-1") String cCatalog,
            @RequestParam(value = "cSource", defaultValue = "-1") Integer cSource,
            @RequestParam(value = "cStatus", defaultValue = "-1") Integer cStatus,
            @RequestParam(value = "page", defaultValue = "1") int current,
            Model model) {

        Map<String, Object> conditions = new HashMap<String, Object>();
        conditions.put("cTitle", cTitle);
        conditions.put("cCatalog", cCatalog);
        conditions.put("cSource", cSource);
        conditions.put("cStatus", cStatus);

        Page page = new Page();
        page.setConditions(conditions);
        page.setCurrent(current);
        articleService.getByPage(page);

        model.addAttribute("SOURCE_MAP", ArticleEnum.ARTICLE_SOURCE_MAP);
        model.addAttribute("STATUS_MAP", ArticleEnum.ARTICLE_STATUS_MAP);
        model.addAttribute("page", page);
        model.addAttribute("catalogs", catalogService.getAll());

        return "admin/article_list";
    }

    @RequestMapping(value = "edit")
    public String edit(@RequestParam(value = "id", required = false) Integer id, Model model) {
        Article article = null;
        if (id != null && id != 0) {
            article = articleService.getById(id);
        } else {
            article = new Article();
        }

        // 处理内容中图片的相对路径
        if (article.getContent() != null) {
            article.setContent(article.getContent().replaceAll("<img src=\"(.*?)\"", "<img src=\"" + GlobalConfig.websiteUr + "$1\""));
        }

        model.addAttribute("article", article);
        model.addAttribute("catalogList", TreeUtil.baseTreeNode(TreeUtil.catalog2TreeNode(catalogService.getAll())));
        model.addAttribute("SOURCE_MAP", ArticleEnum.ARTICLE_SOURCE_MAP);

        return "admin/article_edit";
    }

    @RequiresPermissions("article:save")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@ModelAttribute Article article) {
        // 新增
        if (article.getId() == 0) {
            String name = ((ShiroUser) SecurityUtils.getSubject().getPrincipal()).getName();
            article.setWriter(name);
            articleService.insert(article);
        } else {// 修改
            String name = ((ShiroUser) SecurityUtils.getSubject().getPrincipal()).getName();
            article.setWriter(name);
            articleService.update(article);
        }
        return "redirect:/admin/article";
    }

    @RequiresPermissions("article:delete")
    @RequestMapping(value = "delete")
    public String delete(@RequestParam String ids) {
        articleService.deleteByIds(ids);
        return "redirect:/admin/article";
    }

    @RequiresPermissions("article:publish")
    @RequestMapping(value = "publish")
    public String publish(@RequestParam String ids, HttpServletRequest request) {
        articleService.publishByIds(ids, request);
        return "redirect:/admin/article";
    }

    @ResponseBody
    @RequestMapping(value = "preview")
    public String preview(@RequestParam String articleId, HttpServletRequest request) {
        articleService.preview(articleId, request);
        return GlobalConfig.websiteUr + "/article/" + articleId + ".html";
    }

    /**
     * 从编辑器上传图片
     *
     * @param watermark 是否加水印,默认是加水印的.
     *                  原创图片有加水印的需要,来源于其他网站的图片,不宜再加水印.
     * @param file      上传的图片
     */
    @RequiresPermissions("article:upload")
    @RequestMapping(value = "uploadImage", method = RequestMethod.POST)
    public void uploadImage(
            @RequestParam(value = "watermark", defaultValue = "false") String watermark,
            @RequestParam(value = "imageFile", required = false) MultipartFile file,
            HttpServletResponse response) {

        String url = UploadUtil.upload(file, UploadUtil.SUBDIR_IMAGE);
        if (StringUtils.isBlank(url)) return;

        // 加水印
        if ("true".equals(watermark)) {
            ImageUtil.pressText(GlobalConfig.realPath + url, "www.devnote.cn", "Times New Romas", Font.PLAIN, 16, Color.RED, 25, 10, 1.0f, 3, 70f);
        }

        // 有网友反应使用srping的@ResponseBody,并直接return 结果url的方式,在IE8下上传图片没反应
        url = GlobalConfig.websiteUr + url;
        try {
            response.getWriter().print(url);
        } catch (IOException e) {
            log.error("上传图片时遇到错误", e);
        }
    }
}
