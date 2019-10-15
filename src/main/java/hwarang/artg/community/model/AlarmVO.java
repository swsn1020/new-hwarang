package hwarang.artg.community.model;

import java.util.Date;

public class AlarmVO {
//    alarm_num number(10) not null,
//    alarm_category varchar2(50) not null,
//    board_category varchar2(50), 
//    alarm_regdate date,
//    alarm_checked varchar2(10),
//    member_id varchar2(200) not null,
//    board_num number(10) not null
	private int alarm_num;
	private String alarm_category;
	private Date alarm_regdate;
	private String alarm_checked;
	private String member_id;
	private int board_num;
	private String board_Category;
	public String getBoard_Category() {
		return board_Category;
	}
	public void setBoard_Category(String board_Category) {
		this.board_Category = board_Category;
	}
	public int getAlarm_num() {
		return alarm_num;
	}
	public void setAlarm_num(int alarm_num) {
		this.alarm_num = alarm_num;
	}
	public String getAlarm_category() {
		return alarm_category;
	}
	public void setAlarm_category(String alarm_category) {
		this.alarm_category = alarm_category;
	}
	public Date getAlarm_regdate() {
		return alarm_regdate;
	}
	public void setAlarm_regdate(Date alarm_regdate) {
		this.alarm_regdate = alarm_regdate;
	}
	public String getAlarm_checked() {
		return alarm_checked;
	}
	public void setAlarm_checked(String alarm_checked) {
		this.alarm_checked = alarm_checked;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
}