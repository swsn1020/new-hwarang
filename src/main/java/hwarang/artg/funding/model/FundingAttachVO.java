package hwarang.artg.funding.model;

import lombok.Data;

@Data 
public class FundingAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	private int funding_num;
	
}
