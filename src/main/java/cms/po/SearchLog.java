package cms.po;

import cms.po.base.BaseEntity;

import java.util.Date;

public class SearchLog extends BaseEntity {
    private int id;
    private String keywords;
    private int times;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public int getTimes() {
        return times;
    }

    public void setTimes(int times) {
        this.times = times;
    }
}
