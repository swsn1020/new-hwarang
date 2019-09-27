package hwarang.artg.manager.model;

import java.util.Date;

import lombok.Data;

@Data
public class ReportImgVO {
	//REPORT_IMG
//	REPORT_UUID	VARCHAR2(200 BYTE)
//	REPORT_NUM	NUMBER(10,0)
//	REPORT_UPLOAD_PATH	VARCHAR2(100 BYTE)
//	REPORT_FILENAME	VARCHAR2(200 BYTE)
//	IMG_REG_DATE	DATE
	private String uuid;
	private int reportNum;
	private String uploadPath;
	private String originName;
	private Date regDate;
	
}
