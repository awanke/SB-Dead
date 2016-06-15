package cms.mapper;

import java.util.List;

import cms.po.Attachment;
import cms.mapper.base.BasicMapper;

public interface AttachmentMapper extends BasicMapper<Attachment> {

    public void updateDownloads(int id);

    public List<Attachment> getByArticleId(int articleId);
}
