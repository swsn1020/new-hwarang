package hwarang.artg.community.model;

import java.util.Date;

public class FreeLikeVO {
	private String member_id;
	private int free_num;
	private int free_like_status;
	private Date free_likedate;
	
	public FreeLikeVO() {
		
	}
	public FreeLikeVO(String member_id,int free_num) {
		this.member_id = member_id;
		this.free_num = free_num;
	}
	public FreeLikeVO(String member_id,int free_num ,int free_like_status) {
		this.member_id = member_id;
		this.free_num = free_num;
		this.free_like_status = free_like_status;	
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getFree_num() {
		return free_num;
	}
	public void setFree_num(int free_num) {
		this.free_num = free_num;
	}
	public int getFree_like_status() {
		return free_like_status;
	}
	public void setFree_like_status(int free_like_status) {
		this.free_like_status = free_like_status;
	}
	public Date getFree_likedate() {
		return free_likedate;
	}
	public void setFree_likedate(Date free_likedate) {
		this.free_likedate = free_likedate;
	}
	@Override
	public String toString() {
		return "FreeLikeVO [member_id=" + member_id + ", free_num=" + free_num + ", free_like_status="
				+ free_like_status + ", free_likedate=" + free_likedate + "]";
	}
}
