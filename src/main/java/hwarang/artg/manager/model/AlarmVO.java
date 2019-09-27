package hwarang.artg.manager.model;

import lombok.Data;

@Data
public class AlarmVO {
	//ALARM
//	ALARM_NUM	NUMBER(10,0)
//	MEMBER_ID	VARCHAR2(50 BYTE)
//	ALARM_CONTENT	VARCHAR2(2000 BYTE)
//	ALARM_CATEGORY	VARCHAR2(30 BYTE)
//	ALARM_KEYWORD	VARCHAR2(100 BYTE)
	private int num;
	private String memId;
	private String content;
	private String category;
	private String keyword;


}
