package hwarang.artg.manager.model;

import java.util.Date;

import lombok.Data;

@Data
public class ReportVO {
	//REPORT_BOARD
//	REPORT_NUM	NUMBER(10,0)
//	MEMBER_ID	VARCHAR2(50 BYTE)
//	REPORT_TITLE	VARCHAR2(100 BYTE)
//	REPORT_CATEGORY	VARCHAR2(30 BYTE)
//	REPORT_CONTENT	VARCHAR2(4000 BYTE)
//	REPORT_REG_DATE	DATE
//	REPORT_MODI_DATE	DATE
//	REPORT_REPLY	VARCHAR2(2000 BYTE)
	private int num;	//게시글 번호
	private String memId;
	private String title;
	private String category;
	private String content;
	private Date regDate;
	private Date modiDate;
	private String reply;	//답변
	

}
