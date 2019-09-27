package hwarang.artg.manager.model;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {
//	NOTICE_BOARD
//	NOTICE_NUM	NUMBER(10,0)
//	NOTICE_TITLE	VARCHAR2(100 BYTE)
//	NOTICE_CONTENT	VARCHAR2(4000 BYTE)
//	NOTICE_CATEGORY	VARCHAR2(30 BYTE)
//	NOTICE_REG_DATE	DATE
//	NOTICE_READ_COUNT	NUMBER(10,0)
//	NOTICE_REPLY_COUNT
//	BLOCK
	private int num;
	private String title;
	private String content;
	private String category;
	private Date regDate;
	private int readCnt;
	private int replyCnt;
	private String block;

}
