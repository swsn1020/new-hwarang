package hwarang.artg.community.model;

import java.util.Date;

public class FreeBoardVO {
//	free_num number(10) primary key,
//	member_id varchar2(50) not null,
//	free_title varchar(100) not null,
//	free_content varchar(4000) not null,
//	free_regdate date DEFAULT sysdate,
//	free_updatedate date DEFAULT sysdate,
//	free_readcnt number(10) default 0,
//	free_recomm_cnt number(10) default 0,
//	free_disrecomm_cnt number(10) default 0
	private int num;
	private String userid;
	private String title;
	private String content;
	private Date regDate;
	private Date upDateDate;
	private int readCount;
	private int recommCount;
	private int disrecommCount;
	private int free_like_status;
	private int replyCount;
//	private int boardNum;
	
	/* 신고처리 -hj- */
	private String block;
	//신고 getter,setter
	public String getBlock() {
		return block;
	}
	public void setBlock(String block) {
		this.block = block;
	}

	
	public FreeBoardVO() {
		
	}
	public FreeBoardVO(String userid,String title,String content) {
		this.userid = userid;
		this.title = title;
		this.content = content;
	}	
	public int getFree_like_status() {
		return free_like_status;
	}
	public void setFree_like_status(int free_like_status) {
		this.free_like_status = free_like_status;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public Date getUpDateDate() {
		return upDateDate;
	}
	public void setUpDateDate(Date upDateDate) {
		this.upDateDate = upDateDate;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getRecommCount() {
		return recommCount;
	}
	public void setRecommCount(int recommCount) {
		this.recommCount = recommCount;
	}
	public int getDisrecommCount() {
		return disrecommCount;
	}
	public void setDisrecommCount(int disrecommCount) {
		this.disrecommCount = disrecommCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	
	@Override
	public String toString() {
		return "FreeBoardVO [num=" + num + ", userid=" + userid + ", title=" + title + ", content=" + content
				+ ", regDate=" + regDate + ", upDateDate=" + upDateDate + ", readCount=" + readCount + ", recommCount="
				+ recommCount + ", disrecommCount=" + disrecommCount + ", replyCount=" + replyCount + ", block=" + block
				+ "]";
	}
	
	
}
