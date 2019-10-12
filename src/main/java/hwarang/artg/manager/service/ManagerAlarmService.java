package hwarang.artg.manager.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.community.model.FreeBoardVO;
import hwarang.artg.community.service.FreeBoardService;
import hwarang.artg.manager.model.BlockStatusVO;
import hwarang.artg.manager.model.FAQVO;
import hwarang.artg.manager.model.ManagerAlarmVO;
import hwarang.artg.manager.model.NoticeVO;
import hwarang.artg.manager.model.QnAVO;
import hwarang.artg.manager.model.ReportVO;
import hwarang.artg.mapper.ManagerAlarmMapper;
import hwarang.artg.mapper.ReportMapper;
import hwarang.artg.rrboard.model.RecommendBoardVO;
import hwarang.artg.rrboard.model.ReviewBoardVO;
import hwarang.artg.rrboard.service.RecommendBoardService;
import hwarang.artg.rrboard.service.ReviewBoardService;

@Service
public class ManagerAlarmService {
	@Autowired
	private ManagerAlarmMapper dao;
	@Autowired
	private QnAService qnaService;
	@Autowired
	private ReportService reportService;
	@Autowired
	private BlockStatusService blockService;
	@Autowired
	private FAQService faqService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private FreeBoardService freeBoardService;
	@Autowired
	private ReviewBoardService reviewBoardService;
	@Autowired
	private RecommendBoardService recommBoardService;
	
	
	public boolean alarmRegister(ManagerAlarmVO alarm) {
		if(dao.insertManagerAlarm(alarm) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean alarmModify(int num) {
		if(dao.updateManagerAlarm(num) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean alarmRemove(int num) {
		if(dao.deleteManagerAlarm(num) > 0) {
			return true;
		}
		return false;
	}
	
	public ManagerAlarmVO alarmGetOne(int num) {
		return dao.selectManagerAlarm(num);
	}
	
	
	public int unReadAlarmCount() {
		return dao.unReadAlarmCount();
	}
	
	public List<Map<String, Object>> getFourAlarms(){
		return checkAlarmCategory(dao.selectFourAlarms());
	}
	
	public List<Map<String, Object>> alarmGetAll() {
		return checkAlarmCategory(dao.selectAllManagerAlarms());
	}
	
	public List<Map<String, Object>> pagingList(CriteriaDTO cri){
		return checkAlarmCategory(dao.getListWithPaging(cri));
	}
	
	public int getTotalCount() {
		return dao.getTotalCount();
	}
	
	
	//Alarm Map만들기
	public List<Map<String, Object>> checkAlarmCategory(List<ManagerAlarmVO> alarmList) {
		List<Map<String, Object>> params = new ArrayList<Map<String,Object>>();
		for(ManagerAlarmVO alarm : alarmList) {
			Map<String, Object> alMap = checkAlarmCategory(alarm);
			/*
			Map<String, Object> alMap = new HashMap<String, Object>();
			alMap.put("alarm", alarm);
			String originCategory = alarm.getBoardCategory();
			String category = originCategory.substring(0, (originCategory.indexOf("_")));
			String subCategory = originCategory.substring((originCategory.indexOf("_")+1));
			if(subCategory.equals("Reply")) {
				subCategory = "댓글";
			}else {
				subCategory = "게시글";
			}
			int boardNum = alarm.getBoardNum();
			
			switch(category) {
			case "Notice" :
				category = "공지사항";
				alMap.put("url", "/notice/noticeView?num="+boardNum);
				break;
			case "FAQ" :
				category = "자주하는 질문";
				alMap.put("url", "/faq/faqList");
				break;
			case "Report" :
				category = "신고게시판";
				alMap.put("url", "/report/reportView?num="+boardNum);
				break;
			case "QnA" :
				category = "1:1문의";
				alMap.put("url", "/qna/qnaView?num="+boardNum);
				break;
			case "Block" :
				category = "신고";
				alMap.put("url", "/block/blockView?num="+boardNum);
				break;
			case "Free" :
				category = "자유게시판";
				alMap.put("url", "/board/freeboardView?num="+boardNum);
				break;
			case "Recommend" :
				category = "추천게시판";
				alMap.put("url", "/recommend/view?num="+boardNum);
				break;
			case "Review" :
				category = "후기게시판";
				alMap.put("url", "/review/view?num="+boardNum);
				break;
			}
			alMap.put("category", category);
			alMap.put("subCategory", subCategory);
//			alMap.put("boardNum", boardNum);
			 */
			params.add(alMap);
		}
		return params;
	}
	
	public Map<String, Object> checkAlarmCategory(ManagerAlarmVO alarm) {
		//alarm 한개 처리
		Map<String, Object> alMap = new HashMap<String, Object>();
		alMap.put("alarm", alarm);
		String originCategory = alarm.getBoardCategory();
		String category = originCategory.substring(0, (originCategory.indexOf("_")));
		String subCategory = originCategory.substring((originCategory.indexOf("_")+1));
		if(subCategory.equals("Reply")) {
			subCategory = "댓글";
		}else {
			subCategory = "게시글";
		}
		int boardNum = alarm.getBoardNum();
		
		switch(category) {
		case "Notice" :
			category = "공지사항";
			alMap.put("url", "/notice/noticeView?num="+boardNum);
			break;
		case "FAQ" :
			category = "자주하는 질문";
			alMap.put("url", "/faq/faqList");
			break;
		case "Report" :
			category = "신고게시판";
			alMap.put("url", "/report/reportView?num="+boardNum);
			break;
		case "QnA" :
			category = "1:1문의";
			alMap.put("url", "/qna/qnaView?num="+boardNum);
			break;
		case "Block" :
			category = "신고";
			alMap.put("url", "/block/blockView?num="+boardNum);
			break;
		case "Free" :
			category = "자유게시판";
			alMap.put("url", "/board/freeboardView?num="+boardNum);
			break;
		case "Recommend" :
			category = "추천게시판";
			alMap.put("url", "/recommend/view?num="+boardNum);
			break;
		case "Review" :
			category = "후기게시판";
			alMap.put("url", "/review/view?num="+boardNum);
			break;
		}
		alMap.put("category", category);
		alMap.put("subCategory", subCategory);
		return alMap; //alarm 객체 한개에 대한 category 등 정보..
	}

}
