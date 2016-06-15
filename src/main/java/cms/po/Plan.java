package cms.po;

import cms.po.base.BaseEntity;
import cms.myenum.base.LevelEnum;

public class Plan extends BaseEntity {
    private int id;
    private String title;
    private String content;
    private String cancelReason;
    private int level;
    private LevelEnum levelEnum;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCancelReason() {
        return cancelReason;
    }

    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public LevelEnum getLevelEnum() {
        return levelEnum;
    }

    public void setLevelEnum(LevelEnum levelEnum) {
        this.levelEnum = levelEnum;
    }
}

