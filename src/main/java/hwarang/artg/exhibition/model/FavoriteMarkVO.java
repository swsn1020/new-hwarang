package hwarang.artg.exhibition.model;

import java.util.Date;

import lombok.Data;

@Data
public class FavoriteMarkVO {

	private int exh_seq;
	private String member_id;
	private Date favorite_date;
	private String favorite_group;
	private String favorite_status;
	
	private String exh_title;
	private String exh_place;
	private String exh_price;
	private String exh_imgurl;
	private String exh_realmName;
	private Date exh_startDate;
	private Date exh_endDate;
}
