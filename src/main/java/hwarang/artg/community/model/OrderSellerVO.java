package hwarang.artg.community.model;

import java.util.Date;

public class OrderSellerVO {
	private int num;
	private int ticketnum;
	private String userid;
	private String status; 
	private Date purchaseDate;
	
	public OrderSellerVO() {
		
	}
	public OrderSellerVO(String userid,String status) {
		this.userid = userid;
		this.status = status;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getTicketnum() {
		return ticketnum;
	}
	public void setTicketnum(int ticketnum) {
		this.ticketnum = ticketnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
}
