package hwarang.artg.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.community.model.FreeBoardVO;
import hwarang.artg.community.model.PartyBoardVO;
import hwarang.artg.mapper.PartyBoardMapper;

@Service
public class PartyBoardService {
	@Autowired
	private PartyBoardMapper partyboardMapper;
	
	public boolean partyboardRegister(PartyBoardVO partyboard) {
		if(partyboardMapper.insertBoard(partyboard)>0) {
			return true;
		}
		return false;
	}
	public boolean partyboardModify(PartyBoardVO partyboard) {
		if(partyboardMapper.updateBoard(partyboard)>0) {
			return true;
		}
		return false;
	}
	public boolean partyboardRemove(int num) {
		if(partyboardMapper.deleteBoard(num)>0) {
			return true;
		}
		return false;
	}
	public List<PartyBoardVO> partyboardGetAll(){
		return partyboardMapper.selectAll();
	}
	public PartyBoardVO partyboardGetone(int num) {
		return partyboardMapper.selectOne(num);
	}
	// 상세보기 조회(조회수 증가)
	public PartyBoardVO IncreaseReadCnt(int num) {
		//조회수 증가하는 update 문장이 필요
		//board조회 하고나서,조회수 update
		PartyBoardVO partyboard = null;
		//조회수가 증가 했을 때만, 게시글 정보 반환
		if(partyboardMapper.updateReadCount(num)>0) {
			partyboard = partyboardMapper.selectOne(num);
		}
		return partyboard;
	}
}
