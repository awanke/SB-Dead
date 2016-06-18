package cms.utils;

import cms.config.GlobalConfig;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.log4j.Logger;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Date;

public class UploadUtil {
    private static Logger log = Logger.getLogger(UploadUtil.class);
    /**
     * 用于保存附件的目录
     */
    public static final String SUBDIR_ATTACHMENT = "attachment";
    /**
     * 用于保存图片的目录
     */
    public static final String SUBDIR_IMAGE = "image";

    /**
     * @param subdir attachment,image
     */
    public static String upload(MultipartFile file, String subdir) {
        // 上传图片
        String fileName = file.getOriginalFilename();
        String dateDir = DateFormatUtils.format(new Date(), "yyyy/MM/dd/");
        String baseDir = "/upload/" + subdir + "/";
        String newName = RandomStringUtils.randomAlphanumeric(10) + "." + FilenameUtils.getExtension(fileName);
        File targetFile = new File(GlobalConfig.realPath + baseDir + dateDir, newName);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        // 保存
        try {
            file.transferTo(targetFile);
        } catch (Exception e) {
            log.error("上传错误", e);
            return StringUtils.EMPTY;
        }
        return baseDir + dateDir + newName;
    }
}
