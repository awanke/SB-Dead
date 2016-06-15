package cms.web.front;

import cms.solr.SolrUtil;
import cms.web.admin.base.BaseController;
import org.apache.commons.lang3.StringUtils;
import org.apache.solr.client.solrj.util.ClientUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/")
public class SolrControl extends BaseController {

    @ResponseBody
    @RequestMapping(value = "/suggest")
    public List<String> getSuggestions(@RequestParam(value = "term", defaultValue = StringUtils.EMPTY) String term, Model model) {
        String escapedKw = ClientUtils.escapeQueryChars(term);
        return SolrUtil.getSuggestions(escapedKw);
    }
}
