package cms.web.admin;

import cms.po.Plan;
import cms.myenum.PlanEnum;
import cms.service.PlanService;
import cms.utils.FastJsonUtil;
import cms.vo.Page;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin/plan")
public class PlanController {
    @Autowired
    private PlanService planService;

    @RequestMapping(value = StringUtils.EMPTY)
    public String list(
            @RequestParam(value = "cTitle", defaultValue = StringUtils.EMPTY) String cTitle,
            @RequestParam(value = "cLevel", defaultValue = "-1") String cLevel,
            @RequestParam(value = "cStatus", defaultValue = "-1") Integer cStatus,
            @RequestParam(value = "page", defaultValue = "1") int current, Model model) {

        System.out.println("/admin/plan");
        Map<String, Object> conditions = new HashMap<String, Object>();
        conditions.put("cTitle", cTitle);
        conditions.put("cLevel", cLevel);
        conditions.put("cStatus", cStatus);

        Page page = new Page();
        page.setConditions(conditions);
        page.setCurrent(current);
        planService.getByPage(page);

        model.addAttribute("LEVEL_MAP", PlanEnum.PLAN_LEVEL_MAP);
        model.addAttribute("STATUS_MAP", PlanEnum.PLAN_STATUS_MAP);
        model.addAttribute("page", page);

        return "admin/plan_list";
    }

    @RequiresPermissions("plan:save")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@ModelAttribute Plan plan) {
        System.out.println("/admin/plan/save");
        // 新增
        if (plan.getId() == 0) {
            planService.insert(plan);
        } else { // 修改
            planService.update(plan);
        }
        return "redirect:/admin/plan";
    }

    @RequiresPermissions("plan:delete")
    @RequestMapping(value = "delete")
    public String delete(@RequestParam String ids) {
        System.out.println("/admin/plan/delete");
        planService.deleteByIds(ids);
        return "redirect:/admin/plan";
    }

    @RequestMapping(value = "edit")
    public String edit(@RequestParam(value = "id", required = false) Integer id, Model model) {
        System.out.println("/admin/plan/edit");
        Plan plan = null;
        if (id != null && id != 0) {
            plan = planService.getById(id);
        } else {
            plan = new Plan();
        }

        model.addAttribute("LEVEL_MAP", PlanEnum.PLAN_LEVEL_MAP);
        model.addAttribute("STATUS_MAP", PlanEnum.PLAN_STATUS_MAP);
        model.addAttribute("plan", plan);
        return "admin/plan_edit";
    }
}
