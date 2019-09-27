package hwarang.artg.funding.model;

import java.util.Date;

import lombok.Data;

@Data
public class FundingReplyVO {
	private long rno;
	private long funding_num;
	
	private String funding_reply;
	private String funding_replyer;
	private Date funding_replyDate;
	private Date funding_updateDate;
}
