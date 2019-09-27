package hwarang.artg.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.community.model.PartyMemberVO;
import hwarang.artg.mapper.PartyMemberMapper;

@Service
public class PartyMemberService {
	@Autowired
	private PartyMemberMapper partymemberMapper;
		
	public boolean partymemberRegisTer(PartyMemberVO partymember) {
		if(partymemberMapper.insertParty(partymember)>0) {
			return true;
		}
		return false;
	}
	public boolean partymemberRemove(int num) {
		if(partymemberMapper.deleteParty(num)>0) {
			return true;
		}
		return false;
	}
	public List<PartyMemberVO> partymemberGetAll(){
		return partymemberMapper.selectAll();
	}
	public PartyMemberVO partymemberGetOne(int num) {
		return partymemberMapper.selectOne(num);
	}
}
