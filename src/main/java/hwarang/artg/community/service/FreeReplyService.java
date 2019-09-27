package hwarang.artg.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.community.model.FreeReplyVO;
import hwarang.artg.mapper.FreeReplyMapper;

@Service
public class FreeReplyService {

	@Autowired
	private FreeReplyMapper freereplyMapper;
	public boolean freereplyRegister(FreeReplyVO freereply) {
		if(freereplyMapper.insertReply(freereply)>0) {
			return true;
		}
		return false;
	}
	public boolean freereplyModify(FreeReplyVO freereply) {
		if(freereplyMapper.updateReply(freereply)>0) {
			return true;
		}
		return false;
	}
	public boolean freereplyRemove(int num) {
		if(freereplyMapper.deleteReply(num)>0) {
			return true;
		}
		return false;
	}
	public List<FreeReplyVO> freereplyGetAll(){
		return freereplyMapper.selectAll();
	}
	public FreeReplyVO freereplyGetone(int num) {
		return freereplyMapper.selectOne(num);
	}
	public List<FreeReplyVO> freeReplyByBoard(int fboardNum){
		return freereplyMapper.selectListByBnum(fboardNum);
	}
	public String idCheck(int num) {
		return freereplyMapper.replyUserIdCheck(num);
	}
	
	
	/*신고처리 -hj*/
	//Block 처리하기2(Reply)
	public boolean doReplyBlock(String block, int num) {
		if(freereplyMapper.updateBlock(block, num) > 0) {
			return true;
		}
		return false;
	}
}
