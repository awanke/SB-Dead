package cms.service;

import cms.solr.SolrUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cms.po.SearchLog;
import cms.mapper.SearchLogMapper;

@Component
public class SearchLogService {
    @Autowired
    private SearchLogMapper searchLogMapper;

    public void insertOrUpdate(SearchLog searchLog) {
        searchLogMapper.insertOrUpdate(searchLog);

        SolrUtil.buildIndex(SolrUtil.ENTITY_SEARCHLOG, false);
    }
}
