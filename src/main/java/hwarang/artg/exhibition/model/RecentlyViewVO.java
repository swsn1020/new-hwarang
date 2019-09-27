package hwarang.artg.exhibition.model;

import java.util.Date;

import lombok.Data;
@Data
public class RecentlyViewVO {
	private int exh_seq;
	private String member_id;
	private Date rec_viewdate;
	
	private String exh_title;
	private String exh_place;
	private String exh_price;
	private int exh_value;
	private String exh_imgurl;
	private String exh_realmName;
	private Date exh_startDate;
	private Date exh_endDate;
	
	public RecentlyViewVO() {	
	}
	
	public RecentlyViewVO(int exh_seq,String member_id){
		this.exh_seq = exh_seq;
		this.member_id = member_id;
	}
}
