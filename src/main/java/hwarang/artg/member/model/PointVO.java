package hwarang.artg.member.model;

import java.util.Date;

public class PointVO {
//	POINT_NUM                 NUMBER(10)   
//	MEMBER_ID        NOT NULL VARCHAR2(50) 
//	POINT_GET_DATE            DATE         
//	POINT_GET_AMOUNT          NUMBER(10)   
//	POINT_USE_DATE            DATE         
//	POINT_USE_AMOUNT          NUMBER(10)   
//	POINT_MEMO                VARCHAR2(50) 
	private int point_num;
	private String member_id;
	private Date point_get_date;
	private int point_get_amount;
	private Date point_use_date;
	private int point_use_amount;
	private String point_memo;
	public int getPoint_num() {
		return point_num;
	}
	public void setPoint_num(int point_num) {
		this.point_num = point_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public Date getPoint_get_date() {
		return point_get_date;
	}
	public void setPoint_get_date(Date point_get_date) {
		this.point_get_date = point_get_date;
	}
	public int getPoint_get_amount() {
		return point_get_amount;
	}
	public void setPoint_get_amount(int point_get_amount) {
		this.point_get_amount = point_get_amount;
	}
	public Date getPoint_use_date() {
		return point_use_date;
	}
	public void setPoint_use_date(Date point_use_date) {
		this.point_use_date = point_use_date;
	}
	public int getPoint_use_amount() {
		return point_use_amount;
	}
	public void setPoint_use_amount(int point_use_amount) {
		this.point_use_amount = point_use_amount;
	}
	public String getPoint_memo() {
		return point_memo;
	}
	public void setPoint_memo(String point_memo) {
		this.point_memo = point_memo;
	}
	@Override
	public String toString() {
		return "PointVO [point_num=" + point_num + ", member_id=" + member_id + ", point_get_date=" + point_get_date
				+ ", point_get_amount=" + point_get_amount + ", point_use_date=" + point_use_date
				+ ", point_use_amount=" + point_use_amount + ", point_memo=" + point_memo + "]";
	}
	
}
