package Module;

import java.util.Date;

public class Slider {
    private int slideId ;
    private String slideUrl ;
    private Marketing marketing ;
    private String title ;
    private String image ;
    private String description ;
    private boolean isShow ;
    private Date createDate ;
    private Date updateDate ;
    private boolean status ;
    private String backLink ;

    public Slider() {
    }

    public Slider(int slideId, String slideUrl, Marketing marketing, String title, String image, String description, boolean isShow, Date createDate, Date updateDate, boolean status, String backLink) {
        this.slideId = slideId;
        this.slideUrl = slideUrl;
        this.marketing = marketing;
        this.title = title;
        this.image = image;
        this.description = description;
        this.isShow = isShow;
        this.createDate = createDate;
        this.updateDate = updateDate;
        this.status = status;
        this.backLink = backLink;
    }

    public int getSlideId() {
        return slideId;
    }

    public void setSlideId(int slideId) {
        this.slideId = slideId;
    }

    public String getSlideUrl() {
        return slideUrl;
    }

    public void setSlideUrl(String slideUrl) {
        this.slideUrl = slideUrl;
    }

    public Marketing getMarketing() {
        return marketing;
    }

    public void setMarketing(Marketing marketing) {
        this.marketing = marketing;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isShow() {
        return isShow;
    }

    public void setShow(boolean show) {
        isShow = show;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getBackLink() {
        return backLink;
    }

    public void setBackLink(String backLink) {
        this.backLink = backLink;
    }
}
