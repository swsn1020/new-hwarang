package hwarang.artg.funding.model;

import lombok.Data;

@Data
public class OrderVO {
	private String member_id;
	private int order_seq_num;
	private String order_title;
	private int order_price;
	private String order_qty;
	private String order_image;
}
