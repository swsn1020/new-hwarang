package hwarang.artg.community.model;

import java.util.Date;

public class FreeReplyVO {
	private int num;
	private int fboardNum;
	private String userid;
	private String content;
	private Date regDate;
	private Date upDateDate;
	
	/* 신고처리 -hj- */
	private String block;
	//신고 getter,setter
	public String getBlock() {
		return block;
	}
	public void setBlock(String block) {
		this.block = block;
	}
	
	public FreeReplyVO() {
		
	}
	public FreeReplyVO(String userid,String content,int fboardNum) {
		this.userid = userid;
		this.content = content;
		this.fboardNum = fboardNum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getBoardNum() {
		return fboardNum;
	}
	public void setBoardNum(int boardNum) {
		this.fboardNum = boardNum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
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
	@Override
	public String toString() {
		return "FreeReplyVO [num=" + num + ", boardNum=" + fboardNum + ", userid=" + userid + ", content=" + content
				+ ", regDate=" + regDate + ", upDateDate=" + upDateDate + "]";
	}
}
