package hwarang.artg.manager.model;

import java.util.Date;

import lombok.Data;

@Data
public class QnAImgVO {
//	QNA_IMG
//	QNA_UUID         VARCHAR2(200) 
//	QNA_NUM          NUMBER(10)    
//	QNA_UPLOAD_PATH  VARCHAR2(100) 
//	QNA_FILENAME     VARCHAR2(200) 
//	IMG_REG_DATE	DATE
	private String uuid;
	private int qnaNum;
	private String uploadPath;
	private String originName;
	private Date regDate;

}
