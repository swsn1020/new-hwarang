package hwarang.artg.exhibition.model;

import java.util.Date;

import lombok.Data;

@Data
public class ExhLikeVO {
	private String member_id;
	private int exh_seq;
	private int exh_like_status;
	private Date exh_likedate;

	public ExhLikeVO() {

	}

	public ExhLikeVO(String member_id, int exh_seq) {
		this.member_id = member_id;
		this.exh_seq = exh_seq;
	}
	
	public ExhLikeVO(String member_id, int exh_seq, int exh_like_status) {
		this.member_id = member_id;
		this.exh_seq = exh_seq;
		this.exh_like_status = exh_like_status;
	}

}
