package hwarang.artg.member.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import hwarang.artg.mapper.MemberAuthMapper;
import hwarang.artg.mapper.MemberMapper;
import hwarang.artg.member.model.MemberAuthVO;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.rrboard.service.ReviewBoardService;

@Service
public class MemberService {
	@Autowired
	private MemberMapper membermapper;
	@Autowired
	private MemberAuthMapper maMapper;
	
	@Autowired
	private ReviewBoardService rbservice;
	
	public MemberVO memberFindId(String member_name) {
		return membermapper.selectMember_name(member_name);
	}
	
	@Transactional
	public boolean memberRegister(MemberVO member) {
		if(membermapper.insertMember(member)>0) {
			MemberAuthVO ma = member.getAuthList().get(0);
			if(maMapper.insertMember_Auth(ma)>0) {
				return true;				
			}
		}
		return false;
	}
	public boolean memberModify(MemberVO m) {
		if(membermapper.updateMember(m) > 0) {
			return true;
		}
		return false;
	}
	public boolean memberPwModify(MemberVO m) {
		if(membermapper.updateMember_pw(m) > 0) {
			return true;
		}
		return false;
	}
	public boolean memberRemove(String id) {
		if(membermapper.deleteMember(id) > 0) {
			return true;
		}
		return false;
	}
	public MemberVO memberGetOne(String id) {
		return membermapper.selectMember(id);
	}
	public List<MemberVO> memberGetAll(){
		return membermapper.selectAllMember();
	}
	public boolean memberCheckPw(String id, String pw) {
		MemberVO member = membermapper.selectMember(id);
		if(member != null) {
			if(pw.equals(member.getMember_password())) {
				return true;
			}
		}
		return false;
	}
	//나의 게시글
	public List<Object> memberBoardAll(String id){
		List<Object> boardList = null;
		rbservice.reviewboardGetIdAll(id);
		
		return boardList;
	}
}
