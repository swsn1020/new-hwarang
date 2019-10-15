package hwarang.artg.community.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.community.model.AlarmVO;
import hwarang.artg.manager.model.ManagerAlarmVO;
import hwarang.artg.manager.service.BlockStatusService;
import hwarang.artg.manager.service.FAQService;
import hwarang.artg.manager.service.NoticeService;
import hwarang.artg.manager.service.QnAService;
import hwarang.artg.manager.service.ReportService;
import hwarang.artg.mapper.AlarmMapper;
import hwarang.artg.rrboard.service.RecommendBoardService;
import hwarang.artg.rrboard.service.ReviewBoardService;

@Service
public class AlarmService {
	@Autowired
	private AlarmMapper mapper;
	
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
	public boolean alarmRegister(AlarmVO alarm) {
		if(mapper.insertAlarm(alarm) > 0) {
			return true;
		}
		return false;
	}
	public AlarmVO alarmGetOne(int alarm_num) {
		return mapper.selectAlarm(alarm_num);
	}
	public int unReadAlarmCount() {
		return mapper.unReadAlarmCount();
	}
	public List<Map<String, Object>> getFourAlarms(){
		return checkAlarmCategory(mapper.selectFourAlarms());
	}
	public List<Map<String, Object>> alarmGetAll() {
		return checkAlarmCategory(mapper.selectAllAlarms());
	}
	public int getTotalCount() {
		return mapper.getTotalCount();
	}
	//Alarm Map만들기
		public List<Map<String, Object>> checkAlarmCategory(List<AlarmVO> alarmList) {
			List<Map<String, Object>> params = new ArrayList<Map<String,Object>>();
			for(AlarmVO alarm : alarmList) {
				Map<String, Object> alMap = checkAlarmCategory(alarm);
				params.add(alMap);
			}
			return params;
		}
		
	public Map<String, Object> checkAlarmCategory(AlarmVO alarm) {
		//alarm 한개 처리
			Map<String, Object> alMap = new HashMap<String, Object>();
			alMap.put("alarm",alarm);
			String originCategory = alarm.getBoard_Category();
			String category = originCategory.substring(0, (originCategory.indexOf("_")));
			String subCategory = originCategory.substring((originCategory.indexOf("_")+1));
			
			if(subCategory.equals("Reply")) {
				subCategory = "댓글";
			}
			int boardNum = alarm.getBoard_num();
			
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
			return alMap;
	}
}
