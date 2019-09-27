package hwarang.artg.exhibition.model;

import java.util.Date;

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
	private String exh_subTitle = "정보없음";
	private String exh_price = "정보없음";
	private int exh_value;
	private String exh_contents = "정보없음";
	private String exh_contents1 = "정보없음";
	private String exh_contents2 = "정보없음";
	private String exh_url = "정보없음";
	private String exh_phone = "정보없음";
	private String exh_imgurl = "정보없음";
	private String exh_gpsx = "정보없음";
	private String exh_gpsy = "정보없음";
	private String exh_placeurl = "정보없음";
	private String exh_placeaddr = "정보없음";
	private String exh_placeseq = "정보없음";
	private String favorite_status;
	private int co_num;
	private String exh_memo;
	private int exh_recomm_cnt;
}
