package hwarang.artg.exhibition.model;

import java.util.Date;

import lombok.Data;

@Data
public class ExhibitionMentionVO {
	private int mention_no;
	private int exh_seq;
	private String member_id;
	private String mention_content;
	private int mention_score;
	private Date mention_regdate;
}
