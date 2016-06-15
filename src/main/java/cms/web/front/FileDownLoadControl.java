package cms.web.front;

import cms.po.Attachment;
import cms.service.AttachmentService;
import cms.utils.ConfigUtil;
import cms.web.admin.base.BaseController;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;

@Controller
@RequestMapping("/")
public class FileDownLoadControl extends BaseController {
    private static Logger log = Logger.getLogger(FileDownLoadControl.class);

    @Autowired
    private AttachmentService attachmentService;

    /**
     * 附件下载,同时更新下载次数
     */
    @RequestMapping("/download/{id}")
    public void download(@PathVariable("id") int id, HttpServletRequest request, HttpServletResponse response) {
        Attachment attachment = attachmentService.getById(id);
        String filePath = ConfigUtil.getValue("apache.htdocs.dir") + attachment.getUrl();
        InputStream inputStream;
        try {
            String fileName = attachment.getName();
            fileName = new String(fileName.getBytes("gbk"), "ISO8859-1");
            inputStream = new FileInputStream(filePath);
            response.reset();
            response.setContentType("application/octet-stream;charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
            byte data[] = new byte[1024];
            while (inputStream.read(data, 0, 1024) >= 0) {
                outputStream.write(data);
            }
            outputStream.flush();
            outputStream.close();
        } catch (Exception e) {
            log.error("附件下载时遇到异常", e);
        }

        // 更新下载量
        attachmentService.updateDownloads(id);
    }
}
