package cms.myenum;

import java.util.LinkedHashMap;
import java.util.Map;

public class PlanEnum {
    /**
     * 优先级：低
     */
    public static final int PLAN_LEVEL_LOW = 0;
    /**
     * 优先级：中
     */
    public static final int PLAN_LEVEL_MIDDLE = 1;
    /**
     * 优先级：高
     */
    public static final int PLAN_LEVEL_HIGH = 2;
    /**
     * 优先级MAP
     */
    public static final Map<Integer, String> PLAN_LEVEL_MAP = getPlanevelMap();

    public static Map<Integer, String> getPlanevelMap() {
        Map<Integer, String> map = new LinkedHashMap<Integer, String>();
        map.put(PLAN_LEVEL_LOW, "低");
        map.put(PLAN_LEVEL_MIDDLE, "中");
        map.put(PLAN_LEVEL_HIGH, "高");
        return map;
    }

    /**
     * 状态：新建
     */
    public static final int PLAN_STATUS_NEW = 0;
    /**
     * 状态：删除
     */
    public static final int PLAN_STATUS_DELETE = 1;
    /**
     * 状态：打开
     */
    public static final int PLAN_STATUS_OPEN = 2;
    /**
     * 状态：完成
     */
    public static final int PLAN_STATUS_DONE = 3;
    /**
     * 状态MAP
     */
    public static final Map<Integer, String> PLAN_STATUS_MAP = getPlanStatusMap();

    public static Map<Integer, String> getPlanStatusMap() {
        Map<Integer, String> map = new LinkedHashMap<Integer, String>();
        map.put(PLAN_STATUS_NEW, "新建");
        map.put(PLAN_STATUS_DELETE, "删除");
        map.put(PLAN_STATUS_OPEN, "打开");
        map.put(PLAN_STATUS_DONE, "完成");
        return map;
    }
}
