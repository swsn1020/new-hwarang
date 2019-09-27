package hwarang.artg.manager.model;

import java.util.Date;

import lombok.Data;

@Data
public class FAQVO {
//	FAQ
//	FAQ_NUM      NOT NULL NUMBER(10)    
//	QUESTION     NOT NULL VARCHAR2(100) 
//	ANSWER       NOT NULL VARCHAR2(200) 
//	FAQ_CATEGORY NOT NULL VARCHAR2(30)  
//	FAQ_REG_DATE          DATE     
	private int num;
	private String question;
	private String answer;
	private String category;
	private Date regDate;

}
