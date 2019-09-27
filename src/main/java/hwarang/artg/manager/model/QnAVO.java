package hwarang.artg.manager.model;

import java.util.Date;

import lombok.Data;

@Data
public class QnAVO {
//	QNA
//	QNA_NUM	NUMBER(10,0)
//	MEMBER_ID	VARCHAR2(50 BYTE)
//	QNA_TITLE	VARCHAR2(100 BYTE)
//	QNA_CONTENT	VARCHAR2(4000 BYTE)
//	QNA_REG_DATE	DATE
//	QNA_CATEGORY	VARCHAR2(30 BYTE)
//	QNA_REPLY	VARCHAR2(2000 BYTE)
	private int num;
	private String memId;
	private String title;
	private String content;
	private Date regDate;
	private String category;
	private String reply;

}
