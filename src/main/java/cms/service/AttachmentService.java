package cms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cms.po.Attachment;
import cms.mapper.AttachmentMapper;

@Component
public class AttachmentService {
    @Autowired
    private AttachmentMapper attachmentMapper;

    public void insert(Attachment attachment) {
        attachmentMapper.insert(attachment);
    }

    public void deleteById(int id) {
        attachmentMapper.deleteById(id);
    }

    public void updateDownloads(int id) {
        attachmentMapper.updateDownloads(id);
    }

    public Attachment getById(int id) {
        return attachmentMapper.getById(id);
    }

    public List<Attachment> getByArticleId(int articleId) {
        return attachmentMapper.getByArticleId(articleId);
    }
}
