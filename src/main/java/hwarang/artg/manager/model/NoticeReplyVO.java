package hwarang.artg.manager.model;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeReplyVO {
//	NOTICE_REPLY_NUM	NUMBER(10,0)
//	NOTICE_NUM	VARCHAR2(10 BYTE)
//	MEMBER_ID	VARCHAR2(50 BYTE)
//	NOTICE_REPLY_CONTENT	VARCHAR2(4000 BYTE)
//	NOTICE_REPLY_REGDATE	DATE
//	NOTICE_REPLY_UPDATEDATE	DATE
	private int num;
	private int boardNum;
	private String memId;
	private String content;
	private Date regDate;
	private Date modiDate;
	private String block;
}
	


