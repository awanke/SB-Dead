package cms.web.front;

import cms.config.GlobalConfig;
import cms.myenum.CatalogEnum;
import cms.po.SearchLog;
import cms.service.ArticleService;
import cms.service.CatalogService;
import cms.service.SearchLogService;
import cms.solr.SolrUtil;
import cms.utils.TreeUtil;
import cms.vo.Page;
import cms.web.admin.base.BaseController;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.solr.client.solrj.util.ClientUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/")
public class IndexControl extends BaseController {
    private static Logger log = Logger.getLogger(IndexControl.class);
    @Autowired
    private ArticleService articleService;
    @Autowired
    private CatalogService catalogService;
    @Autowired
    private SearchLogService searchLogService;

    /**
     * 网站首页,首页栏目,栏目文章列表页,搜索页公用
     *
     * @param kw      搜索词
     * @param catalog 搜索栏目
     * @param current 当前页
     */
    @RequestMapping(value = StringUtils.EMPTY)
    public String page(
            @RequestParam(value = "kw", defaultValue = StringUtils.EMPTY) String kw,
            @RequestParam(value = "catalog", defaultValue = "-1") int catalog,
            @RequestParam(value = "writer", defaultValue = StringUtils.EMPTY) String writer,
            @RequestParam(value = "page", defaultValue = "1") int current,
            Model model) {

        // 记录搜索词
        if (StringUtils.isNotBlank(kw)) {
            SearchLog searchLog = new SearchLog();
            searchLog.setKeywords(kw);
            // 首次插入会使用此值
            searchLog.setTimes(1);
            searchLogService.insertOrUpdate(searchLog);
        }

        // 搜索词需要转义掉solr具有特殊意义的字符,如:"等,以免搜不到需要的结果
        String escapedKw = ClientUtils.escapeQueryChars(kw);

        Map<String, Object> conditions = new HashMap<String, Object>();
        conditions.put("kw", escapedKw);
        conditions.put("catalog", catalog);
        conditions.put("writer", writer);
        // 如果是搜索,结果不再按时间排序,按相关度
        if (StringUtils.isNotBlank(kw)) {
            conditions.put("orderByTime", false);
        } else {
            conditions.put("orderByTime", true);
        }

        Page page = new Page();
        page.setConditions(conditions);
        page.setCurrent(current);
        SolrUtil.getByPage(page);

        // 回显前防XSS攻击
        page.getConditions().put("kw", StringEscapeUtils.escapeHtml3(kw));

        model.addAttribute("page", page);
        model.addAttribute("catalogs", catalogService.getAll2());
        model.addAttribute("monthStat", articleService.getStatByMonth());
        model.addAttribute("catalogList", TreeUtil.baseTreeNode(TreeUtil.catalog2TreeNode(catalogService.getAll())));
        model.addAttribute("CATALOG_TUTORIAL", CatalogEnum.CATALOG_TUTORIAL);
        model.addAttribute("APACHE_HTDOCS_URL", GlobalConfig.websiteUr);

        return "home";
    }
}
