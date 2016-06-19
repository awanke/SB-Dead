package cms.solr;

import cms.config.GlobalConfig;
import cms.myenum.ArticleEnum;
import cms.po.Article;
import cms.vo.Page;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.request.FieldAnalysisRequest;
import org.apache.solr.client.solrj.response.AnalysisResponseBase.AnalysisPhase;
import org.apache.solr.client.solrj.response.AnalysisResponseBase.TokenInfo;
import org.apache.solr.client.solrj.response.FacetField.Count;
import org.apache.solr.client.solrj.response.FieldAnalysisResponse;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.client.solrj.response.SpellCheckResponse;
import org.apache.solr.client.solrj.response.SpellCheckResponse.Suggestion;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.apache.solr.common.util.NamedList;

import java.util.*;

public class SolrUtil {
    private static Logger log = Logger.getLogger(SolrUtil.class);
    public static String ENTITY_ARTICLE = "article";
    public static String ENTITY_SEARCHLOG = "searchlog";
    private static HttpSolrServer solrServer4Article;
    private static HttpSolrServer solrServer4SearchLog;

    static {
        solrServer4Article = new HttpSolrServer(GlobalConfig.solrUrlArticle);
        solrServer4Article.setConnectionTimeout(10000);

        solrServer4SearchLog = new HttpSolrServer(GlobalConfig.solrUrlSearchlog);
        solrServer4SearchLog.setConnectionTimeout(10000);
    }

    public static void insert(Article article) {
        SolrInputDocument doc = new SolrInputDocument();
        doc.addField("id", article.getId());
        doc.addField("title", article.getTitle());
        doc.addField("description", article.getDescription());
        doc.addField("writer", article.getWriter());
        doc.addField("content", article.getContent());
        doc.addField("publishDate", article.getPublishDate());
        doc.addField("catalogId", article.getCatalogId());
        doc.addField("pageView", article.getPageView());
        doc.addField("status", article.getStatus());
        doc.addField("createDate", article.getCreateDate());
        doc.addField("updateDate", article.getUpdateDate());

        try {
            solrServer4Article.add(doc);
            solrServer4Article.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @param dataList 需要添加的数据列表,每一条数据是一个Object数组,
     *                 Object[0]为文章对象,Object[1]为文章内容对象 。
     */
    public static void insertBatch(List<Object[]> dataList) {
        Collection<SolrInputDocument> docs = new ArrayList<SolrInputDocument>();
        for (Object[] data : dataList) {
            Article article = (Article) data[0];
            SolrInputDocument doc = new SolrInputDocument();
            doc.addField("id", article.getId());
            doc.addField("title", article.getTitle());
            doc.addField("description", article.getDescription());
            doc.addField("writer", article.getWriter());
            doc.addField("content", article.getContent());
            doc.addField("publishDate", article.getPublishDate());
            doc.addField("catalogId", article.getCatalogId());
            doc.addField("pageView", article.getPageView());
            doc.addField("status", article.getStatus());
            doc.addField("createDate", article.getCreateDate());
            doc.addField("updateDate", article.getUpdateDate());
            docs.add(doc);
        }

        try {
            solrServer4Article.add(docs);
            solrServer4Article.commit();
        } catch (Exception e) {
            log.error("向solr批量添加文档时遇到错误", e);
        }
    }

    public static void deleteById(String id) {
        try {
            solrServer4Article.deleteById(id + StringUtils.EMPTY);
            solrServer4Article.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void deleteAll() {
        try {
            solrServer4Article.deleteByQuery("*:*");
            solrServer4Article.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 更新文档
     */
    public static void update(Article article) {
        insert(article);
    }

    /**
     * 根据文档id查询单个文档
     */
    public static int getById(int id) {
        SolrQuery query = new SolrQuery();
        query.setQuery("id:" + id);
        try {
            QueryResponse rsp = solrServer4Article.query(query);
            SolrDocumentList docs = rsp.getResults();
            Iterator<SolrDocument> iter = docs.iterator();
            while (iter.hasNext()) {
                SolrDocument doc = iter.next();
                return (Integer) doc.getFieldValue("id");
            }
        } catch (Exception e) {
            log.error("从solr根据id查询单个文档时遇到错误", e);
        }
        return -1;
    }

    /**
     * 分页查询,包含查询,分页,高亮及获取高亮处摘要等内容.
     */
    public static void getByPage(Page page) {
        String ckw = page.getConditions().get("kw").toString();
        String cCatalogId = page.getConditions().get("catalog").toString();
        String cWriter = page.getConditions().get("writer").toString();
        boolean orderByTime = (Boolean) page.getConditions().get("orderByTime");

        String params = StringUtils.EMPTY;

        // 搜索词
        if (StringUtils.isNotBlank(ckw)) {
            params = "(title:" + ckw + "^2 OR content:" + ckw + ")";
        }

        // 栏目id
        if (!StringUtils.equals("-1", cCatalogId)) {
            if (StringUtils.isNotBlank(params)) {
                params += " AND ";
            }
            params += "catalogId:" + cCatalogId;
        }

        // 作者
        if (StringUtils.isNotBlank(cWriter)) {
            if (StringUtils.isNotBlank(params)) {
                params += " AND ";
            }
            params += "writer:\"" + cWriter + "\"";
        }

        // 文章状态
        if (StringUtils.isNotBlank(params)) {
            params += " AND ";
        }
        params += "status:" + ArticleEnum.ARTICLE_STATUS_PUBLISHED;

        SolrQuery query = new SolrQuery();
        query.setQuery(params);

        // query.setParam("fl", "id,title,description,content,writer,catalogId,createDate,updateDate,status,score");
        // query.setParam("debugQuery", true);

        // 查询默认使用相关度排序,如果程序中指定的按时间排序,显式设置一下即可
        if (orderByTime) {
            query.addSort("publishDate", SolrQuery.ORDER.desc);
        }

        query.setStart((int) page.getStart());
        query.setRows(page.getSize());

        // 占位符配合html转义,防止jsp执行摘要中的<c:if 等标签,影响排版
        String placeholderPre = "#placeholderPre#";
        String placeholderPost = "#placeholderPost#";
        String highlightSimplePre = "<font color='red'>";
        String highlightSimplePost = "</font>";

        // 设置高亮
        // 移动客户端查询不需要高亮
        if (!page.isDisableHighlight()) {
            query.setHighlight(true);// 开启高亮组件
            query.addHighlightField("title");// 高亮字段
            query.addHighlightField("content");// 高亮字段
            query.setHighlightSimplePre(placeholderPre);//标记,高亮关键字前缀
            query.setHighlightSimplePost(placeholderPost);//后缀
            // 获取高亮分片数,一般搜索词可能分布在文章中的不同位置,其所在一定长度的语句即为一个片段,
            // 默认为1,但根据业务需要有时候需要多取出几个分片。 - 此处设置决定下文中titleList, contentList中元素的个数
            query.setHighlight(true).setHighlightSnippets(1);
            // 每个分片的最大长度,默认为100。适当设置此值,如果太小,高亮的标题可能会显不全；设置太大,摘要可能会太长。
            query.setHighlightFragsize(150);
        }

        // 开启facet查询
        query.setFacet(true)
                // 设置没有结果的栏目不显示
                .setFacetMinCount(1)
                // 设置根据栏目id进行facet查询
                .addFacetField("catalogId");

        List<Object> articles = new ArrayList<Object>();
        try {
            QueryResponse rsp = solrServer4Article.query(query);
            SolrDocumentList docs = rsp.getResults();
            page.setFacetCatalog(rsp.getFacetField("catalogId").getValues());
            page.setElapsedTime(rsp.getElapsedTime());

            // 获取所有高亮的字段
            Map<String, Map<String, List<String>>> highlightMap = rsp.getHighlighting();

            Iterator<SolrDocument> iter = docs.iterator();
            while (iter.hasNext()) {
                SolrDocument doc = iter.next();
                String idStr = doc.getFieldValue("id").toString();
                int id = Integer.parseInt(idStr);
                String title = doc.getFieldValue("title").toString();
                String description = doc.getFieldValue("description").toString();
                String writer = doc.getFieldValue("writer").toString();
                String content = doc.getFieldValue("content").toString();
                Date publishDate = (Date) doc.getFieldValue("publishDate");
                int catalogId = Integer.parseInt(doc.getFieldValue("catalogId").toString());
                int pageView = Integer.parseInt(doc.getFieldValue("pageView").toString());
                int status = Integer.parseInt(doc.getFieldValue("status").toString());
                Date createDate = (Date) doc.getFieldValue("createDate");
                Date updateDate = (Date) doc.getFieldValue("updateDate");

                Article article = new Article();
                article.setId(id);
                article.setTitle(title);
                article.setDescription(description);
                article.setWriter(writer);
                article.setContent(content);
                article.setPublishDate(publishDate);
                article.setCatalogId(catalogId);
                article.setPageView(pageView);
                article.setStatus(status);
                article.setCreateDate(createDate);
                article.setUpdateDate(updateDate);

                if (!page.isDisableHighlight()) {
                    List<String> titleList = highlightMap.get(idStr).get("title");
                    List<String> contentList = highlightMap.get(idStr).get("content");
                    //获取并设置高亮的字段title
                    if (CollectionUtils.isNotEmpty(titleList)) {
                        title = titleList.get(0);
                        title = title.replace(placeholderPre, highlightSimplePre);
                        title = title.replace(placeholderPost, highlightSimplePost);
                        article.setTitle(title);
                    }
                    //获取并设置高亮的字段content
                    if (CollectionUtils.isNotEmpty(contentList)) {
                        description = contentList.get(0);
                        description = StringEscapeUtils.escapeHtml3(description);
                        description = description.replace(placeholderPre, highlightSimplePre);
                        description = description.replace(placeholderPost, highlightSimplePost);
                        article.setDescription(description);
                    }
                }

                articles.add(article);
            }

            page.setDatas(articles);
            page.setCount(docs.getNumFound());

        } catch (Exception e) {
            log.error("从solr根据Page查询分页文档时遇到错误", e);
        }
    }

    /**
     * 获取前多少名用户发表量排行
     */
    public static List<Count> getPublishedRankings(int num) {
        SolrQuery query = new SolrQuery();
        query.setQuery(StringUtils.EMPTY);
        query.setQuery("status:" + ArticleEnum.ARTICLE_STATUS_PUBLISHED);
        // 开启facet查询
        query.setFacet(true)
                // 设置没有结果的栏目不显示
                .setFacetMinCount(1)
                // 设置根据栏目writer进行facet查询
                .addFacetField("writer")
                // 获取前num条
                .setFacetLimit(num);

        try {
            QueryResponse rsp = solrServer4Article.query(query);
            List<Count> facetWriter = rsp.getFacetField("writer").getValues();
            return facetWriter;
        } catch (Exception e) {
            log.error("从solr根据writer查询发表文章数量时遇到错误", e);
        }
        return null;
    }

    /**
     * 根据文章标题查相关文章
     *
     * @param id    指定文章（文档）id
     * @param count 返回条数
     */
    public static List<Article> getRelated(int id, int count) {
        SolrQuery query = new SolrQuery();
        // 指定RequestHandler,默认使用/select
        query.setRequestHandler("/mlt");

        List<Article> articles = new ArrayList<Article>();
        try {
            query.setQuery("id:" + id)
                    .setParam("fl", "id,title,score")
                    .setParam("mlt", "true")
                    .setParam("mlt.fl", "title")
                    .setParam("mlt.mindf", "1")
                    .setParam("mlt.mintf", "1");

            query.addFilterQuery("status:" + ArticleEnum.ARTICLE_STATUS_PUBLISHED);
            query.setRows(count);// mlt.count无效,需要此方法控制返回条数

            QueryResponse response = solrServer4Article.query(query);
            if (response == null) return articles;

            SolrDocumentList docs = response.getResults();
            Iterator<SolrDocument> iter = docs.iterator();
            while (iter.hasNext()) {
                // 相关结果中不包含自己,循环中无需排除处理
                SolrDocument doc = iter.next();
                String idStr = doc.getFieldValue("id").toString();
                Article article = new Article();
                article.setId(Integer.parseInt(idStr));
                article.setTitle(doc.getFieldValue("title").toString());
                articles.add(article);
            }
        } catch (Exception e) {
            log.error("从solr获取相关新闻时遇到错误", e);
        }
        return articles;
    }

    /**
     * 给指定的语句分词
     *
     * @param sentence 被分词的语句
     * @return 分词结果
     */
    public static List<String> getAnalysis(String sentence) {
        FieldAnalysisRequest request = new FieldAnalysisRequest(
                "/analysis/field");
        request.addFieldName("title");// 字段名,随便指定一个支持中文分词的字段
        request.setFieldValue("");// 字段值,可以为空字符串,但是需要显式指定此参数
        request.setQuery(sentence);

        FieldAnalysisResponse response = null;
        try {
            response = request.process(solrServer4Article);
        } catch (Exception e) {
            log.error("获取查询语句的分词时遇到错误", e);
        }

        List<String> results = new ArrayList<String>();
        Iterator<AnalysisPhase> it = response.getFieldNameAnalysis("title")
                .getQueryPhases().iterator();
        while (it.hasNext()) {
            AnalysisPhase pharse = (AnalysisPhase) it.next();
            List<TokenInfo> list = pharse.getTokens();
            for (TokenInfo info : list) {
                results.add(info.getText());
            }

        }
        return results;
    }

    /**
     * 智能搜索提示
     */
    public static List<String> getSuggestions(String kw) {
        SolrQuery query = new SolrQuery();
        query.setRequestHandler("/suggest");
        query.setQuery("keywords:" + kw);
        try {
            SpellCheckResponse spellCheckResponse = solrServer4SearchLog.query(query).getSpellCheckResponse();
            // solr数字拼写提示没有返回
            if (spellCheckResponse == null) {
                return null;
            }
            List<Suggestion> suggestions = spellCheckResponse.getSuggestions();
            if (suggestions.size() == 0) {
                return null;
            } else {
                Suggestion suggestion = suggestions.get(suggestions.size() - 1);
                return suggestion.getAlternatives();
            }
        } catch (SolrServerException e) {
            log.error("获取推荐词时遇到错误:", e);
            return null;
        }
    }

    /**
     * 增量/全量建立索引
     * http://localhost:8983/solr/collection1/dataimport?command=delta-import&clean=false&commit=true&entity=article&verbose=false&optimize=false
     * http://localhost:8983/solr/collection1/dataimport?command=full-import&clean=true&commit=true&optimize=true
     *
     * @param entity, 对哪个核进行操作
     * @param delta   ture,增量建立索引;false,重建所有索引
     */
    public static void buildIndex(String entity, boolean delta) {
        SolrQuery query = new SolrQuery();
        // 指定RequestHandler,默认使用/select
        query.setRequestHandler("/dataimport");

        String command = delta ? "delta-import" : "full-import";
        // 选择是否要在索引开始构建之前删除之前的索引,默认为true
        String clean = delta ? "false" : "true";
        // 是否在索引完成之后对索引进行优化,默认为true
        String optimize = delta ? "false" : "true";

        query.setParam("command", command)
                .setParam("clean", clean)
                // 选择是否在索引完成之后提交,默认为true
                .setParam("commit", "true")
                .setParam("entity", entity)
                .setParam("optimize", optimize);
        try {
            if (ENTITY_ARTICLE.equals(entity)) {
                solrServer4Article.query(query);
            }

            if (ENTITY_SEARCHLOG.equals(entity)) {
                System.out.println(query.toString());
                solrServer4SearchLog.query(query);
            }
        } catch (SolrServerException e) {
            log.error("建立索引时遇到错误,delta:" + delta, e);
        }
    }

    /**
     * http://localhost:8983/solr/collection1/dataimport?command=status&indent=true&wt=json&_=1412060716635
     * 查看索引创建状态
     */
    public static String checkBuildStatus(String entity) {
        SolrQuery query = new SolrQuery();
        // 指定RequestHandler,默认使用/select
        query.setRequestHandler("/dataimport");
        query.setParam("command", "status")
                .setParam("commit", "true");

        QueryResponse response = null;
        try {
            if (ENTITY_ARTICLE.equals(entity)) {
                response = solrServer4Article.query(query);
            }

            if (ENTITY_SEARCHLOG.equals(entity)) {
                response = solrServer4SearchLog.query(query);
            }
        } catch (SolrServerException e) {
            log.error("检查索引创建状态时遇到错误:", e);
        }

        if (response == null) {
            return StringUtils.EMPTY;
        }
        NamedList<Object> rps = response.getResponse();
        return rps.get("status") + " - " + rps.get("statusMessages").toString();
    }
}
