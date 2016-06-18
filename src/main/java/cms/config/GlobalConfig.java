package cms.config;

import cms.utils.ConfigUtil;

public class GlobalConfig {
    public static String websiteUr = ConfigUtil.getValue("website.url");

    public static String solrUrlArticle = ConfigUtil.getValue("solr.url.article");

    public static String solrUrlSearchlog = ConfigUtil.getValue("solr.url.searchlog");

    public static String staticPageSize = ConfigUtil.getValue("static.page.size");

    public static boolean isHex = ConfigUtil.getBooleanValue("password.is.stored.hex");

    public static String path = ServletContextHolder.getRealPath();
}
