package cms.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

public class RegexUtil {
    /**
     * 从目标字符串中获取匹配的部分
     *
     * @param regex 正则表达式
     * @param str   目标字符串
     * @return 获取结果
     */
    public static String getRegexMatch(String regex, String str) {
        List<String> resultList = getRegexMatchList(regex, str);
        return resultList.isEmpty() ? StringUtils.EMPTY : resultList.get(0);
    }

    /**
     * 从目标字符串中获取所有匹配的部分
     *
     * @param regex 正则表达式
     * @param str   目标字符串
     * @return 获取结果
     */
    public static List<String> getRegexMatchList(String regex, String str) {
        List<String> resultList = new ArrayList<String>();
        if (StringUtils.isNotBlank(str)) {
            Pattern p = Pattern.compile(regex);
            Matcher m = p.matcher(str);
            while (m.find()) {
                resultList.add(m.group());
            }
        }
        return resultList;
    }

    /**
     * 从目标字符串中获取所有匹配的部分,返回的List中的每个字符串数组,每个位置代表一个能取到得精确位置
     *
     * @param regex 正则表达式
     * @param str   目标字符串
     * @return 获取结果
     */
    public static List<String[]> getRegexMatchListWithGroups(String regex, String str) {
        List<String[]> resultList = new ArrayList<String[]>();
        if (StringUtils.isNotBlank(str)) {
            Pattern p = Pattern.compile(regex);
            Matcher m = p.matcher(str);
            while (m.find()) {
                String[] groups = new String[m.groupCount()];
                for (int i = 0; i < m.groupCount(); i++) {
                    groups[i] = m.group(i + 1);
                }
                resultList.add(groups);
            }
        }
        return resultList;
    }

    /**
     * 从目匹配的字符串中定点取需要的部分
     *
     * @param regex 正则表达式
     * @param str   目标字符串
     * @param id    位置,从1开始
     * @return 获取结果
     */
    public static String getRegexGroup(String regex, String str, int id) {
        String resultStr = StringUtils.EMPTY;
        if (StringUtils.isNotBlank(str)) {
            Pattern p = Pattern.compile(regex);
            Matcher m = p.matcher(str);
            if (m.find()) {
                resultStr = m.group(id);
            }
        }
        return resultStr;
    }

    /**
     * 判断目标字符串是否和指定的正则表达式匹配上
     *
     * @param regex 正则表达式
     * @param str   目标字符串
     * @return 是否匹配
     */
    public static boolean isRegexMatched(String regex, String str) {
        List<String> resultList = getRegexMatchList(regex, str);
        return resultList.isEmpty() ? false : true;
    }
}
