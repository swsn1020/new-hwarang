package hwarang.artg.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.community.model.FreeReplyVO;
import hwarang.artg.community.model.PartyReplyVO;
import hwarang.artg.mapper.PartyReplyMapper;

@Service
public class PartyReplyService {

	@Autowired
	private PartyReplyMapper partyreplyMapper;
	
	public boolean partyreplyRegister(PartyReplyVO partyreply) {
		if(partyreplyMapper.insertReply(partyreply)>0) {
			return true;
		}
		return false;
	}
	public boolean partyreplyModify(PartyReplyVO partyreply) {
		if(partyreplyMapper.updateReply(partyreply)>0) {
			return true;
		}
		return false;
	}
	public boolean partyreplyRemove(int num) {
		if(partyreplyMapper.deleteReply(num)>0) {
			return true;
		}
		return false;
	}
	public List<PartyReplyVO> partyreplyGetAll(){
		return partyreplyMapper.selectAll();
	}
	public PartyReplyVO partyreplyGetone(int num) {
		return partyreplyMapper.selectOne(num);
	}
	
}
