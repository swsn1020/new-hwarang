package hwarang.artg.manager.model;

import java.util.Date;

import lombok.Data;

@Data
public class ManagerAlarmVO {
	//Manager_ALARM
//	AL_NUM         NOT NULL NUMBER(10)   
//	AL_CATEGORY    NOT NULL VARCHAR2(30) 
//	AL_REG_DATE             DATE         
//	AL_CHECKED              VARCHAR2(10) 
//	BOARD_CATEGORY          VARCHAR2(30)
//	BOARD_NUM      NOT NULL NUMBER(10) 
	private int num;
	private String category;
	private Date regDate;
	private String checked;
	private String boardCategory;
	private int boardNum;

}
