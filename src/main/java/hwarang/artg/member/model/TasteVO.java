package hwarang.artg.member.model;

public class TasteVO {
//	MEMBER_ID   NOT NULL VARCHAR2(50) 
//	TASTE_NAME  NOT NULL VARCHAR2(50) 
//	TASTE_POINT          NUMBER(10) 
	private String member_id;
	private String taste_name;
	private int taste_point;
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getTaste_name() {
		return taste_name;
	}
	public void setTaste_name(String taste_name) {
		this.taste_name = taste_name;
	}
	public int getTaste_point() {
		return taste_point;
	}
	public void setTaste_point(int taste_point) {
		this.taste_point = taste_point;
	}
	@Override
	public String toString() {
		return "Taste [member_id=" + member_id + ", taste_name=" + taste_name + ", taste_point=" + taste_point + "]";
	}
	

}
