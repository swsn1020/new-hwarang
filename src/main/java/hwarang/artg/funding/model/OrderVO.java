package hwarang.artg.funding.model;

import java.util.Date;

import org.springframework.stereotype.Repository;

import lombok.Data;
/*
 *  CREATE TABLE "T_SHOPPING_ORDER" 
   (	"ORDER_SEQ_NUM" NUMBER(20,0) primary key, 
	"ORDER_ID" NUMBER(20,0), 
	"MEMBER_ID" VARCHAR2(20 BYTE), 
	"GOODS_ID" NUMBER(20,0), 
	"ORDERER_NAME" VARCHAR2(50 BYTE), 
	"GOODS_TITLE" VARCHAR2(100 BYTE), 
	"ORDER_GOODS_QTY" NUMBER(5,0), 
	"GOODS_SALES_PRICE" NUMBER(5,0), 
	"GOODS_FILENAME" VARCHAR2(60 BYTE), 
	"RECEIVER_NAME" VARCHAR2(50 BYTE), 
	"RECEIVER_HP1" VARCHAR2(20 BYTE), 
	"RECEIVER_HP2" VARCHAR2(20 BYTE), 
	"RECEIVER_HP3" VARCHAR2(20 BYTE), 
	"RECEIVER_TEL1" VARCHAR2(20 BYTE), 
	"RECEIVER_TEL2" VARCHAR2(20 BYTE), 
	"RECEIVER_TEL3" VARCHAR2(20 BYTE), 
	"DELIVERY_ADDRESS" VARCHAR2(500 BYTE), 
	"DELIVERY_METHOD" VARCHAR2(40 BYTE), 
	"DELIVERY_MESSAGE" VARCHAR2(300 BYTE), 
	"GIFT_WRAPPING" VARCHAR2(20 BYTE), 
	"PAY_METHOD" VARCHAR2(200 BYTE), 
	"CARD_COM_NAME" VARCHAR2(50 BYTE), 
	"CARD_PAY_MONTH" VARCHAR2(20 BYTE), 
	"PAY_ORDERER_HP_NUM" VARCHAR2(20 BYTE), 
	"DELIVERY_STATE" VARCHAR2(20 BYTE) DEFAULT 'delivery_prepared', 
	"PAY_ORDER_TIME" DATE DEFAULT sysdate, 
	"ORDERER_HP" VARCHAR2(50 BYTE)
   ) ;
 * */
@Data
public class OrderVO {
	private String order_seq_num;
	private String order_id;
	private String member_id;
	private String order_rec;
	private String member_address;
	private String order_phone;
	private int amount;
	private Date order_date;
}
