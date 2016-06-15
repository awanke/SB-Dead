package cms.mapper;

import cms.po.Catalog;
import cms.mapper.base.BasicMapper;

import java.util.List;
import java.util.Map;

public interface CatalogMapper extends BasicMapper<Catalog> {

    /**
     * 一级二级三级依次
     */
    public List<Catalog> getAllByTree(Map<String, Object> params);
}
