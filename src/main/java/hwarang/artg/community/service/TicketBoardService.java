package hwarang.artg.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.community.model.FreeBoardVO;
import hwarang.artg.community.model.TicketBoardVO;
import hwarang.artg.mapper.TicketBoardMapper;

@Service
public class TicketBoardService {

	@Autowired
	private TicketBoardMapper ticketboardMapper;
	public boolean ticketboardRegister(TicketBoardVO ticketboard) {
		if(ticketboardMapper.insertBoard(ticketboard)>0) {
			return true;
		}
		return false;
	}
	public boolean ticketboardModify(TicketBoardVO ticketboard) {
		if(ticketboardMapper.updateBoard(ticketboard)>0) {
			return true;
		}
		return false;
	}
	public boolean ticketboardRemove(int num) {
		if(ticketboardMapper.deleteBoard(num)>0) {
			return true;
		}
		return false;
	}
	public List<TicketBoardVO> ticketboardGetAll(){
		return ticketboardMapper.selectAll();
	}
	public TicketBoardVO ticketboardGetone(int num) {
		return ticketboardMapper.selectOne(num);
	}
	// 상세보기 조회(조회수 증가)
	public TicketBoardVO IncreaseReadCnt(int num) {
		//조회수 증가하는 update 문장이 필요
		//board조회 하고나서,조회수 update
		TicketBoardVO ticketboard = null;
		//조회수가 증가 했을 때만, 게시글 정보 반환
		if(ticketboardMapper.updateReadCount(num)>0) {
			ticketboard = ticketboardMapper.selectOne(num);
		}
		return ticketboard;
	}
}
