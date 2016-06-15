package cms.vo;

import java.io.Serializable;

public class PicVo implements Serializable {
    private static final long serialVersionUID = 1L;
    private int success;
    private String message;
    private String url;

    public int getSuccess() {
        return success;
    }

    public void setSuccess(int success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
