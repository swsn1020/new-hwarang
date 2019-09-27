package hwarang.artg.funding.model;

import java.util.Date;

import lombok.Data;

@Data
public class CrowdfundingVO {
	private int funding_num;
	private int funding_price;
	private String funding_subject ;
	private String funding_content;
	private Date funding_created_date;
	private Date funding_target_date;
	private int funding_target_amount;
	private String funding_current_collection;
	private int funding_hit;
	private String funding_writer;
}
