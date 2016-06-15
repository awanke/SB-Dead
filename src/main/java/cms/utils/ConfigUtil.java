package cms.utils;

import java.util.ResourceBundle;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

public class ConfigUtil {
	private static Logger log = Logger.getLogger(ConfigUtil.class);
	private static ResourceBundle rb = ResourceBundle.getBundle("application");

	public static String getValue(String key) {
		if (rb.containsKey(key)) {
			return rb.getString(key);
		}
		return StringUtils.EMPTY;
	}

	public static int getIntValue(String key) {
		try {
			return Integer.parseInt(getValue(key));
		} catch (Exception e) {
			log.error("获取配置属性错误", e);
		}
		return -1;
	}

	public static boolean getBooleanValue(String key) {
		try {
			return Boolean.parseBoolean(key);
		} catch (Exception e) {
			log.error("获取配置属性错误", e);
		}
		return false;
	}
}
