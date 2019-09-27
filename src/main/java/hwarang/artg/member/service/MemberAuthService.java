package hwarang.artg.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.mapper.MemberAuthMapper;
import hwarang.artg.member.model.MemberAuthVO;
@Service
public class MemberAuthService {
	@Autowired
	private MemberAuthMapper memberauthmapper;
	
	public boolean memberauthRegister(String id,String auth) {
		MemberAuthVO ma = new MemberAuthVO();
		ma.setMember_id(id);
		ma.setMember_auth(auth);
		int count = memberauthmapper.insertMember_Auth(ma);
		if(count > 0) {
			return true;
		}
		return false;
	}
	public boolean memberauthModify(MemberAuthVO ma) {
		if(memberauthmapper.updateMamber_Auth(ma) > 0) {
			return true;
		}
		return false;
	}
	public boolean memberauthRemove(String id) {
		if(memberauthmapper.deleteMember_Auth(id) > 0) {
			return true;
		}
		return false;
	}
	public MemberAuthVO memberauthGetOne(String id){
		return memberauthmapper.selectMember_Auth(id);
	}
	public List<MemberAuthVO> memberauthGetAll(){
		return memberauthmapper.selectAllMember_Auth();
	}
}
