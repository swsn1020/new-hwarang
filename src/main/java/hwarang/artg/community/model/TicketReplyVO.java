package hwarang.artg.community.model;

import java.util.Date;

public class TicketReplyVO {
	private int num;
	private int boardNum;
	private String userid;
	private String content;
	private Date regDate;
	private Date upDateDate;
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
	@Override
	public String toString() {
		return "TicketReplyVO [num=" + num + ", boardNum=" + boardNum + ", userid=" + userid + ", content=" + content
				+ ", regDate=" + regDate + ", upDateDate=" + upDateDate + "]";
	}
}
