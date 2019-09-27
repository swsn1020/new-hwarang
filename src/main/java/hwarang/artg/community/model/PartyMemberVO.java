package hwarang.artg.community.model;

public class PartyMemberVO {
//party_num 파티게시물 번호
//member_id 유저아이디
	public int partyboardnum;
	public String userid;
	public void setPartyboardnum(int partyboardnum) {
		this.partyboardnum = partyboardnum;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	@Override
	public String toString() {
		return "PartyMemberVO [partyboardnum=" + partyboardnum + ", userid=" + userid + "]";
	}
	

}
