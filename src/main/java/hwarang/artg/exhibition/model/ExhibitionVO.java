package hwarang.artg.exhibition.model;

import lombok.Data;

@Data
public class ExhibitionVO {
	private int exh_seq;
	private String exh_title;
	private String exh_startDate;
	private String exh_endDate;
	private String exh_place;
	private String exh_realmName;
	private String exh_area;
	private String exh_subTitle;
	private String exh_price;
	private int exh_value;
	private String exh_contents;
	private String exh_contents1;
	private String exh_contents2;
	private String exh_url;
	private String exh_phone;
	private String exh_imgurl;
	private String exh_gpsx;
	private String exh_gpsy;
	private String exh_placeurl;
	private String exh_placeaddr;
	private String exh_placeseq;
	private String favorite_status;
	private int co_num;
	private String exh_memo;
	private int exh_recomm_cnt;
	private int exh_like;
	private int exh_unlike;
	private int exh_like_status;
	private int exh_order_status;
}
