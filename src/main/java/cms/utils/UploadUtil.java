package cms.utils;

import cms.config.GlobalConfig;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;

public class UploadUtil {
    private static Logger log = Logger.getLogger(UploadUtil.class);
    /**
     * 附件目录
     */
    public static final String SUBDIR_ATTACHMENT = "attachment";
    /**
     * 图片目录
     */
    public static final String SUBDIR_IMAGE = "image";

    public static String upload(MultipartFile file, String subdir) {
        String dateDir = DateFormatUtils.format(new Date(), "yyyy/MM/dd/");
        String baseDir = "/upload/" + subdir + "/";
        String newName = RandomStringUtils.randomAlphanumeric(10) + "." + FilenameUtils.getExtension(file.getOriginalFilename());

        File targetFile = new File(GlobalConfig.realPath + baseDir + dateDir, newName);

        if (!targetFile.getParentFile().exists()) {
            targetFile.getParentFile().mkdirs();
        }

        try {
            byte[] bytes = file.getBytes();
            BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(targetFile));
            stream.write(bytes);
            stream.close();
        } catch (Exception e) {
            log.error("上传错误", e);
            return StringUtils.EMPTY;
        }

        return GlobalConfig.websiteUr +baseDir + dateDir + newName;
    }
}
