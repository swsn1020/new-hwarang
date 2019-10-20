package hwarang.artg.funding.model;

import java.util.Date;
import java.util.List;

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
	private String funding_video;
	private String funding_hashtag;
	private String funding_news;
	private String funding_image;
	private String reward_title;
	private String reward_title2;
	private String reward_shippingCost;
	private String reward_startDay;
	private int reward_Total;
	private String maker_name;
	private String maker_facebook;
	private String maker_insta;
	private int maker_pnum;
	private String maker_logo;
	private String maker_homepage;
	
	private int replyCnt;
	
	
}
