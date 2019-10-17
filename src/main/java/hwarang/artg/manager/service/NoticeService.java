package hwarang.artg.manager.service;

import java.util.List;

import javax.naming.NoInitialContextException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.manager.model.NoticeReplyVO;
import hwarang.artg.manager.model.NoticeVO;
import hwarang.artg.mapper.NoticeMapper;
import hwarang.artg.mapper.NoticeReplyMapper;

@Service
public class NoticeService {
	@Autowired
	private NoticeMapper dao;
	@Autowired
	private NoticeReplyMapper rDao;
	
	public boolean noticeRegister(NoticeVO notice) {
		if(dao.insertNotice(notice) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean noticeModify(NoticeVO notice) {
		if(dao.updateNotice(notice) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean noticeRemove(int num) {
		if(dao.deleteNotice(num) > 0) {
			System.out.println("해당 notice 삭제 성공");
				return true;
		}
		return false;
	}
	
	public NoticeVO noticeGetOne(int num) {
		return dao.selectNotice(num);
	}
	
	public List<NoticeVO> noticeGetAll() {
		return dao.selectAllNotices();
	}
	
	public List<NoticeVO> noticeRecentAll(){
		return dao.selectRecentNotices();
	}
	
	//페이징 처리한 list
	public List<NoticeVO> pagingList(CriteriaDTO cri){
		return dao.getListWithPaging(cri);
	}
	
	//검색 기능 추가
	public int getTotalCount(CriteriaDTO cri) {
		return dao.getTotalCount(cri);
	}
	
	
	//조회수 수정하기
	public boolean increaseViewCnt(int num) {
		if(dao.updateViewCnt(num) > 0) {
			return true;
		}
		return false;
	}
	
	//공지사항 상단 고정
	public List<NoticeVO> getTopNotices(){
		return dao.topNotices();
	}
	
	
	
	//Notice_Reply 처리(댓글 증가 처리)
	@Transactional
	public boolean nReplyRegister(NoticeReplyVO nReply) throws Exception {
		if(rDao.insertReply(nReply) > 0) {
//			dao.updateReplyCnt(nReply.getBoardNum(), 1);
			return true;
		}
		return false;
	}
	
	public boolean nReplyModify(NoticeReplyVO nReply) {
		if(rDao.updateReply(nReply) > 0) {
			return true;
		}
		return false;
	}
	
//	@Transactional
	public boolean nReplyRemove(int num) throws Exception {
//		int boardNum = rDao.getBoardNum(num);
		if(rDao.deleteReply(num) > 0) {
//			dao.updateReplyCnt(boardNum, -1);
			return true;
		}
		return false;
	}
	
	public boolean nReplyRemoveByBNum(int boardNum) {
		if(rDao.deleteReplyByBNum(boardNum) > 0) {
			return true;
		}
		return false;
	}
	
	public NoticeReplyVO nReplyGetOne(int num) {
		return rDao.selectReply(num);
	}
	
	public List<NoticeReplyVO> nRepliesGetByBNum(int boardNum, int start, int end){
		return rDao.getListWithPaging(boardNum, start, end);
	}
	//페이징
	public int getTotalReplies(int boardNum) {
		return rDao.getTotalCountByBNum(boardNum);
	}
	
	public int getnReplyCount(int num) {
		return rDao.getReplyCnt(num);
	}
	
	
	//Block 처리하기1(Notice)
	public boolean doNoticeBlock(String block, int num) {
		if(dao.updateBlock(block, num) > 0) {
			return true;
		}
		return false;
	}
	
	//Block 처리하기2(Reply)
	public boolean doNoticeReplyBlock(String block, int num) {
		if(rDao.updateBlock(block, num) > 0) {
			return true;
		}
		return false;
	}
	
	

}
