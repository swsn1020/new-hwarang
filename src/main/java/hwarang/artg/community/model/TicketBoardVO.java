package hwarang.artg.community.model;

import java.util.Date;

public class TicketBoardVO {
//	TICKET_NUM	NUMBER(10,0)
//	MEMBER_ID	VARCHAR2(50 BYTE)
//	TICKET_TITLE	VARCHAR2(100 BYTE)
//	TICKET_CONTENT	VARCHAR2(4000 BYTE)
//	TICKET_PRICE	NUMBER(10,0)
// 	TICKET_REGDATE DATE	
//	TICKET_UPDATEDATE	DATE
//	TICKET_REDCNT	NUMBER(10,0)
//	TICKET_RECOMM_CNT	NUMBER(10,0)
//	TICKET_DISRECOMM_CNT	NUMBER(10,0)
	private int num;
	private String userid;
	private String title;
	private String content;
	private int price;
	private Date regDate;
	private Date upDateDate;
	private int readCount;
	private int recommCount;
	private int discrecommCount;
	
	public TicketBoardVO() {
		
	}
	public TicketBoardVO(String userid,String title,String content,int price) {
		this.userid = userid;
		this.title = title;
		this.content = content;
		this.price = price;
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
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
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
	public int getDiscrecommCount() {
		return discrecommCount;
	}
	public void setDiscrecommCount(int discrecommCount) {
		this.discrecommCount = discrecommCount;
	}
	@Override
	public String toString() {
		return "TicketBoardVO [num=" + num + ", userid=" + userid + ", title=" + title + ", content=" + content
				+ ", price=" + price + ", regDate=" + regDate + ", upDateDate=" + upDateDate + ", readCount="
				+ readCount + ", recommCount=" + recommCount + ", discrecommCount=" + discrecommCount + "]";
	}	
}
