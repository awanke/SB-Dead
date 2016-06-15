package cms.web.admin;

import cms.po.Article;
import cms.service.ArticleService;
import cms.service.StaticService;
import cms.web.admin.base.BaseController;
import cms.web.shiro.ShiroUser;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.NumberFormat;

@Controller
@RequestMapping(value = "/admin/static")
public class StaticController extends BaseController {
    private static Logger log = Logger.getLogger(StaticController.class);
    @Autowired
    private ArticleService articleService;
    @Autowired
    private StaticService staticService;

    /**
     * 一键静态化所有页面
     */
    @ResponseBody
    @RequiresPermissions("system:staticAll")
    @RequestMapping(value = "staticAll")
    public String staticAll(HttpServletRequest request, HttpSession session) {
        return staticService.staticAll(request, session);
    }

    /**
     * 静态化单个页面
     */
    @ResponseBody
    @RequiresPermissions("system:staticOne")
    @RequestMapping(value = "staticOne")
    public String staticOne(@RequestParam String articleid, HttpServletRequest request) {
        if (StringUtils.isEmpty(articleid)) {
            return "文章id不能为空";
        }

        // 获取文章对象
        Article article = articleService.getById(Integer.parseInt(articleid));
        if (article == null) {
            return "没有此文章!";
        }

        //处理权限
        Subject subject = SecurityUtils.getSubject();
        String name = ((ShiroUser) subject.getPrincipal()).getName();
        if (!StringUtils.equals(name, article.getWriter()) && !subject.hasRole("admin")) {
            return "只能静态化自己的文章!";
        }

        return staticService.staticOne(article, request);
    }

    /**
     * 显示前台进度条
     */
    @ResponseBody
    @RequestMapping(value = "showProgress")
    public String showProgress(HttpSession session) {
        int current = (Integer) (session.getAttribute("current") == null ? 0 : session.getAttribute("current"));
        Object totalObj = session.getAttribute("total") == null ? 100 : session.getAttribute("total");
        int total = Integer.parseInt(totalObj.toString());

        // 创建一个数值格式化对象
        NumberFormat numberFormat = NumberFormat.getInstance();
        // 设置精确到小数点后2位
        numberFormat.setMaximumFractionDigits(2);
        String result = numberFormat.format((float) current / (float) total * 100);

        log.info("current和total的百分比为:" + result + "%");
        return result;
    }
}
