package hwarang.artg.manager.model;

import java.util.Date;

import lombok.Data;

@Data
public class MessageVO {
	//MESSAGE
//	MSG_NUM	NUMBER(10,0)
//	MEMBER_ID	VARCHAR2(50 BYTE)
//	MSG_TITLE	VARCHAR2(100 BYTE)
//	MSG_CONTENT	VARCHAR2(2000 BYTE)
//	MSG_CATEGORY	VARCHAR2(30 BYTE)
//	MSG_REG_DATE 	DATE
	private int num;
	private String memId;
	private String title;
	private String content;
	private String category;
	private Date regDate;

}
