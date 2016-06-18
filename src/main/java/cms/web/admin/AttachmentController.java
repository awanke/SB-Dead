package cms.web.admin;

import cms.config.GlobalConfig;
import cms.po.Attachment;
import cms.service.AttachmentService;
import cms.utils.MyObjectMapper;
import cms.utils.UploadUtil;
import cms.vo.PicVo;
import cms.web.admin.base.BaseController;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.charset.Charset;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin/attachment")
public class AttachmentController extends BaseController {
    private static Logger log = Logger.getLogger(AttachmentController.class);
    @Autowired
    private AttachmentService attachmentService;

    @ResponseBody
    @RequestMapping(value = StringUtils.EMPTY)
    public List<Attachment> list(@RequestParam int articleId) {
        return attachmentService.getByArticleId(articleId);
    }

    @ResponseBody
    @RequiresPermissions("attachment:save")
    @RequestMapping(value = "save")
    public ResponseEntity<String> save(@RequestParam MultipartFile uploadFile, @RequestParam int articleId) {
        String url = UploadUtil.upload(uploadFile, UploadUtil.SUBDIR_ATTACHMENT);
        if (StringUtils.isBlank(url)) {
            return null;
        }

        Attachment attachment = new Attachment();
        attachment.setName(uploadFile.getOriginalFilename());
        attachment.setSize(FileUtils.byteCountToDisplaySize(uploadFile.getSize()));
        attachment.setUrl(url);
        attachment.setArticleId(articleId);
        attachment.setCreateDate(new Date());
        attachmentService.insert(attachment);

        // uploadify 由flash发出请求，和常规ajax不太一样，需要如下处理，防止中文乱码。
        String body = StringUtils.EMPTY;
        try {
            body = new MyObjectMapper().writeValueAsString(attachment);
        } catch (Exception e) {
            log.error("上传附件时写json错误", e);
        }

        HttpHeaders responseHeaders = new HttpHeaders();
        MediaType mediaType = new MediaType("text", "html", Charset.forName("UTF-8"));
        responseHeaders.setContentType(mediaType);
        ResponseEntity<String> responseEntity = new ResponseEntity<String>(body, responseHeaders, HttpStatus.CREATED);

        return responseEntity;
    }


    @ResponseBody
    @RequiresPermissions("attachment:save")
    @RequestMapping(value = "savePic")
    public PicVo savePic(@RequestParam(value = "editormd-image-file") MultipartFile uploadFile) {
        String url = UploadUtil.upload(uploadFile, UploadUtil.SUBDIR_IMAGE);
        if (StringUtils.isBlank(url)) {
            return null;
        }

        PicVo pv = new PicVo();
        pv.setMessage("success");
        pv.setSuccess(1);
        pv.setUrl(url);
        return pv;
    }


    @ResponseBody
    @RequiresPermissions("attachment:delete")
    @RequestMapping(value = "delete")
    public Attachment delete(@RequestParam int id) {
        // 删除文件
        Attachment attachment = attachmentService.getById(id);
        File file = new File(GlobalConfig.realPath + attachment.getUrl());
        file.delete();

        // 删除记录
        attachmentService.deleteById(id);
        return attachment;
    }
}
