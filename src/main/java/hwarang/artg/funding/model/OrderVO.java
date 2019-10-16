package hwarang.artg.funding.model;

import java.util.Date;

import org.springframework.stereotype.Repository;

import lombok.Data;

@Data
public class OrderVO {
	private String order_seq_num;
	private String order_name;
	private int order_price;
	private String order_id;
	private String member_id;
	private String order_rec;
	private String member_address;
	private String order_phone;
	private int amount;
	private Date order_date;
}
