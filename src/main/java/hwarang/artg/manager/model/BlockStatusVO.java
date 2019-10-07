package hwarang.artg.manager.model;

import java.util.Date;

import lombok.Data;

@Data
public class BlockStatusVO {
	//신고처리 객체
		//BLOCK_STATUS
//		BS_NUM	NUMBER(10,0)
//		CATEGORY	VARCHAR2(30 BYTE)
//		BOARDNUM	VARCHAR2(10 BYTE)
//		B_MEMBER_ID	VARCHAR2(50 BYTE)
//		MEMBER_ID	VARCHAR2(50 BYTE)
//		BS_CONTENT	VARCHAR2(200 BYTE)
//		BS_REPLY	VARCHAR2(200 BYTE)
//		B_REG_DATE	DATE
//		B_MANAGE_DATE	DATE
		private int num;
		//분류(freeboard, free_reply)
		private String category;
		//해당 번호
		private int boardNum;
		//신고받은 아이디
		private String blockMemId;
//		신고한 아이디
		private String memId;
		private String content;
		private String reply;
		private Date regDate;
		private Date manageDate;
		private String boardTitle;
	
}
