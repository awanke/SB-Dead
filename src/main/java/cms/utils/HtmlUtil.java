package cms.utils;

import org.apache.commons.lang3.StringUtils;

public class HtmlUtil {

    /**
     * 去除指定文本中所有html标签
     */
    public static String removeAllHtmlTags(String html) {
        if (StringUtils.isNotBlank(html)) {
            return html.replaceAll("<[^<>]+?>", StringUtils.EMPTY);
        }
        return StringUtils.EMPTY;
    }
}
