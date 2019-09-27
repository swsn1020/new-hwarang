package hwarang.artg.community.model;

import java.util.Date;

public class PartyReplyVO {
	private int num;
	private int boardNum;
	private String userid;
	private String content;
	private Date regDate;
	private Date upDateDate;
	
	public PartyReplyVO() {
		
	}
	public PartyReplyVO(String userid,String content,int boardNum) {
		this.userid = userid;
		this.content = content;
		this.boardNum = boardNum;
	}
	@Override
	public String toString() {
		return "PartyReplyVO [num=" + num + ", boardNum=" + boardNum + ", userid=" + userid + ", content=" + content
				+ ", regDate=" + regDate + ", upDateDate=" + upDateDate + "]";
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
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
	
	
}
