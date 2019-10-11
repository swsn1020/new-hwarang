package hwarang.artg.community.model;

import java.util.Date;

public class AlarmVO {
//    notice_seq number not null,
//    member_id varchar2(200) not null,
//    board_category  varchar2(50) not null,
//    board_num number(10),
//    alarm_message varchar2(200) not null,
//    alarm_type varchar2(2),
//   alarm_regdate date not null,
//   alarm_readdate date
	private int notice_seq;
	private String member_id;
	private String board_category;
	private int board_num;
	private String alarm_message;
	private String alarm_type;
	private Date alarm_regdate;
	private Date alarm_readdate;
	public int getNotice_seq() {
		return notice_seq;
	}
	public void setNotice_seq(int notice_seq) {
		this.notice_seq = notice_seq;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getBoard_category() {
		return board_category;
	}
	public void setBoard_category(String board_category) {
		this.board_category = board_category;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getAlarm_message() {
		return alarm_message;
	}
	public void setAlarm_message(String alarm_message) {
		this.alarm_message = alarm_message;
	}
	public String getAlarm_type() {
		return alarm_type;
	}
	public void setAlarm_type(String alarm_type) {
		this.alarm_type = alarm_type;
	}
	public Date getAlarm_regdate() {
		return alarm_regdate;
	}
	public void setAlarm_regdate(Date alarm_regdate) {
		this.alarm_regdate = alarm_regdate;
	}
	public Date getAlarm_readdate() {
		return alarm_readdate;
	}
	public void setAlarm_readdate(Date alarm_readdate) {
		this.alarm_readdate = alarm_readdate;
	}
	@Override
	public String toString() {
		return "AlarmVO [notice_seq=" + notice_seq + ", member_id=" + member_id + ", board_category=" + board_category
				+ ", board_num=" + board_num + ", alarm_message=" + alarm_message + ", alarm_type=" + alarm_type
				+ ", alarm_regdate=" + alarm_regdate + ", alarm_readdate=" + alarm_readdate + "]";
	}
}
