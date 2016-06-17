package cms.service;

import cms.mapper.PlanMapper;
import cms.po.Plan;
import cms.vo.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class PlanService {
    @Autowired
    private PlanMapper planMapper;

    public void insert(Plan plan) {
        planMapper.insert(plan);
    }

    public void deleteByIds(String ids) {
        for (String id : ids.split(",")) {
            planMapper.deleteById(Integer.parseInt(id));
        }
    }

    public void update(Plan plan) {
        planMapper.update(plan);
    }

    public Plan getById(int id) {
        return planMapper.getById(id);
    }

    public List<Plan> getAll() {
        return planMapper.getAll();
    }

    public Page getByPage(Page page) {
        List<Object> plans = planMapper.getByPage(page);
        Long count = planMapper.getCountByPage(page);
        page.setDatas(plans);
        page.setCount(count);
        return page;
    }
}
