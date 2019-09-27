package hwarang.artg.community.model;

import java.util.Date;

public class FreeImgVO {
	private String uuid;
	private int freeNum;
	private String uploadPath;
	private String originName;
	private Date regDate;
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public int getFreeNum() {
		return freeNum;
	}
	public void setFreeNum(int freeNum) {
		this.freeNum = freeNum;
	}
	public String getUploadPath() {
		return uploadPath;
	}
	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}
	public String getOriginName() {
		return originName;
	}
	public void setOriginName(String originName) {
		this.originName = originName;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "FreeImgVO [uuid=" + uuid + ", freeNum=" + freeNum + ", uploadPath=" + uploadPath + ", originName="
				+ originName + ", regDate=" + regDate + "]";
	}
}
