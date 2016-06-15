package cms.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;

/**
 * 静态化
 */
public class FreeMarkerUtil {
    private static Logger log = Logger.getLogger(FreeMarkerUtil.class);

    /**
     * 静态化方法,如果目标文件已存在,则会被覆盖
     *
     * @param templateDir  模板文件存放路径
     * @param templateName 模板文件名称
     * @param filename     生成的文件,包含路劲路径和名称
     */
    public static void create(String templateDir, String templateName, String targetPath, Map<?, ?> params) {
        try {
            Configuration config = new Configuration(Configuration.VERSION_2_3_0);
            // 设置要解析的模板所在的目录,并加载模板文件
            config.setDirectoryForTemplateLoading(new File(templateDir));
            // 设置包装器,并将对象包装为数据模型
            config.setObjectWrapper(new DefaultObjectWrapper(
                    Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS));

            // 如果目标文件已存在,需要覆盖掉
            File tempFile = new File(targetPath);
            if (tempFile.exists()) {
                tempFile.delete();
            }

            // 如果目录没创建,先创建目录
            File dir = new File(StringUtils.substringBeforeLast(targetPath, "/"));
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 获取模板,并设置编码方式,这个编码必须要与页面中的编码格式一致,否则会出现乱码
            Template template = config.getTemplate(templateName, "utf-8");
            // 合并数据模型与模板
            FileOutputStream fos = new FileOutputStream(targetPath);
            Writer out = new OutputStreamWriter(fos, "utf-8");
            template.process(params, out);
            out.flush();
            out.close();
        } catch (Exception e) {
            log.error("页面静态化时遇到错误", e);
        }
    }
}
