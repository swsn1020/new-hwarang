package hwarang.artg.exhibition.model;

import java.util.Date;

import lombok.Data;

@Data
public class ExhibitionReplyVO {
	private int reply_num;
	private int exh_seq;
	private String member_id;
	private String reply_content;
	private Date reply_reg_date;
	private Date reply_update_date;
}
