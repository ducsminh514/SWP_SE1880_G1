package Module;

public class Setting {
    private Integer settingId;
    private String type;
    private String value;
    private Integer order;
    private boolean status;
    private String createdAt;
    private String updatedAt;
    private String description;

    public Setting() {

    }

    public Setting(Integer settingId, String type, String value, Integer order, boolean status, String createdAt, String updatedAt, String description) {
        this.settingId = settingId;
        this.type = type;
        this.value = value;
        this.order = order;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.description = description;
    }

    public Integer getSettingId() {
        return settingId;
    }

    public void setSettingId(Integer settingId) {
        this.settingId = settingId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Integer getOrder() {
        return order;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Setting{" +
                "id=" + settingId +
                ", type='" + type + '\'' +
                ", value='" + value + '\'' +
                ", order=" + order +
                ", status='" + status + '\'' +
                ", createdAt='" + createdAt + '\'' +
                ", updatedAt='" + updatedAt + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
