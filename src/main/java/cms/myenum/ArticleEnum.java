package cms.myenum;

import java.util.LinkedHashMap;
import java.util.Map;

public class ArticleEnum {
    /**
     * 原创
     */
    public static final int ARTICLE_SOURCE_ORIGINAL = 0;
    /**
     * 转载
     */
    public static final int ARTICLE_SOURCE_REPRINT = 1;
    /**
     * 翻译
     */
    public static final int ARTICLE_SOURCE_TRANSLATION = 2;
    /**
     * 编辑中
     */
    public static final int ARTICLE_STATUS_EDIT = 0;
    /**
     * 已删除
     */
    public static final int ARTICLE_STATUS_DELETE = 1;
    /**
     * 已提交
     */
    public static final int ARTICLE_STATUS_SUBMIT = 2;
    /**
     * 已发布
     */
    public static final int ARTICLE_STATUS_PUBLISHED = 3;

    /**
     * 来源MAP
     */
    public static final Map<Integer, String> ARTICLE_SOURCE_MAP = getArticleSourceMap();

    public static Map<Integer, String> getArticleSourceMap() {
        Map<Integer, String> map = new LinkedHashMap<Integer, String>();
        map.put(ARTICLE_SOURCE_ORIGINAL, "原创");
        map.put(ARTICLE_SOURCE_REPRINT, "转载");
        map.put(ARTICLE_SOURCE_TRANSLATION, "翻译");
        return map;
    }

    /**
     * 状态MAP
     */
    public static final Map<Integer, String> ARTICLE_STATUS_MAP = getArticleStatusMap();

    public static Map<Integer, String> getArticleStatusMap() {
        Map<Integer, String> map = new LinkedHashMap<Integer, String>();
        map.put(ARTICLE_STATUS_EDIT, "编辑中");
        map.put(ARTICLE_STATUS_DELETE, "已删除");
        map.put(ARTICLE_STATUS_SUBMIT, "已提交");
        map.put(ARTICLE_STATUS_PUBLISHED, "已发布");
        return map;
    }
}
