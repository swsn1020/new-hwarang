package hwarang.artg.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.community.model.FreeReplyVO;
import hwarang.artg.community.model.TicketReplyVO;
import hwarang.artg.mapper.TicketReplyMapper;

@Service
public class TicketReplyService {

	@Autowired
	private TicketReplyMapper ticketreplyMapper;
	public boolean ticketreplyRegister(TicketReplyVO ticketreply) {
		if(ticketreplyMapper.insertReply(ticketreply)>0) {
			return true;
		}
		return false;
	}
	public boolean ticketreplyModify(TicketReplyVO ticketreply) {
		if(ticketreplyMapper.updateReply(ticketreply)>0) {
			return true;
		}
		return false;
	}
	public boolean ticketreplyRemove(int num) {
		if(ticketreplyMapper.deleteReply(num)>0) {
			return true;
		}
		return false;
	}
	public List<TicketReplyVO> ticketreplyGetAll(){
		return ticketreplyMapper.selectAll();
	}
	public TicketReplyVO ticketreplyGetone(int num) {
		return ticketreplyMapper.selectOne(num);
	}
}
