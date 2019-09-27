package hwarang.artg.community.model;

import java.util.Date;

public class PartyBoardVO {
	
	private int num;
	private String userid;
	private String title;
	private String content;
	private Date regDate;
	private Date upDateDate;
	private int limitCount;
	private int readCount;
	private int recommCount;
	private int disrecommCount;
	
	public PartyBoardVO() {
		
	}
	public PartyBoardVO(String userid,String title,String content) {
		this.userid = userid;
		this.title = title;
		this.content = content;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
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
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getUpDateDate() {
		return upDateDate;
	}
	public void setUpDateDate(Date upDateDate) {
		this.upDateDate = upDateDate;
	}
	public int getlimitCount() {
		return limitCount;
	}
	public void setlimitCount(int limitCount) {
		this.limitCount = limitCount;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getRecommCount() {
		return recommCount;
	}
	public void setRecommCount(int recommCount) {
		this.recommCount = recommCount;
	}
	public int getDisrecommCount() {
		return disrecommCount;
	}
	public void setDisrecommCount(int disrecommCount) {
		this.disrecommCount = disrecommCount;
	}
	@Override
	public String toString() {
		return "PartyBoardVO [num=" + num + ", userid=" + userid + ", title=" + title + ", content=" + content
				+ ", regDate=" + regDate + ", upDateDate=" + upDateDate + ", limitCount=" + limitCount + ", readCount="
				+ readCount + ", recommCount=" + recommCount + ", disrecommCount=" + disrecommCount + "]";
	}
}
