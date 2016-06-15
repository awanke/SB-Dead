package cms.service;

import cms.mapper.CatalogMapper;
import cms.po.Catalog;
import cms.vo.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class CatalogService {
    @Autowired
    private CatalogMapper catalogMapper;

    public void insert(Catalog catalog) {
        catalogMapper.insert(catalog);
    }

    public void update(Catalog catalog) {
        catalogMapper.update(catalog);
    }

    public Catalog getById(int id) {
        return catalogMapper.getById(id);
    }

    public List<Catalog> getAll() {
        return catalogMapper.getAll();
    }

    public Map<String, Catalog> getAll2() {
        List<Catalog> catalogList = catalogMapper.getAll();
        Map<String, Catalog> catalogMap = new HashMap<String, Catalog>();
        for (Catalog catalog : catalogList) {
            catalogMap.put(String.valueOf(catalog.getId()), catalog);
        }
        return catalogMap;
    }

    public Page getByPage(Page page) {
        List<Object> plans = catalogMapper.getByPage(page);
        Long count = catalogMapper.getCountByPage(page);
        page.setDatas(plans);
        page.setCount(count);
        return page;
    }

    public List<Catalog> getAllByTree(Map<String, Object> params) {
        return catalogMapper.getAllByTree(params);
    }
}
