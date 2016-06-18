package cms.po;

import cms.po.base.BaseEntity;

import java.util.Calendar;
import java.util.Date;

public class Article extends BaseEntity {
    private int id;
    private String name;
    private String title;
    private String keywords;
    private String description;
    private int source;
    private String writer;
    private String content;
    private Date publishDate;
    private int catalogId;
    private int pageView;
    private String environment;
    private int download;

    /**
     * 三天内发布的文章
     */
    public boolean isNewFlag() {
        if (this.getPublishDate() == null) {
            return false;
        }
        Calendar c = Calendar.getInstance();
        // 过去的天数
        int pastDay = 3;
        c.add(Calendar.DATE, -Math.abs(pastDay));
        return this.getPublishDate().getTime() > c.getTime().getTime();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getSource() {
        return source;
    }

    public void setSource(int source) {
        this.source = source;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        content = content.replace("<", "&lt;").replace(">", "&gt;");
        this.content = content;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public int getCatalogId() {
        return catalogId;
    }

    public void setCatalogId(int catalogId) {
        this.catalogId = catalogId;
    }

    public int getPageView() {
        return pageView;
    }

    public void setPageView(int pageView) {
        this.pageView = pageView;
    }

    public String getEnvironment() {
        return environment;
    }

    public void setEnvironment(String environment) {
        this.environment = environment;
    }

    public int getDownload() {
        return download;
    }

    public void setDownload(int download) {
        this.download = download;
    }
}
