package hwarang.artg.manager.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.common.model.ReplyPager;
import hwarang.artg.manager.model.NoticeReplyVO;
import hwarang.artg.manager.model.NoticeVO;
import hwarang.artg.manager.service.NoticeService;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.member.service.MemberService;


@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	private PasswordEncoder pwEncoder;
	@Autowired
	private NoticeService service;
	@Autowired
	private MemberService memService;
	
	@RequestMapping("/noticeList")
	public String showNoticeList(CriteriaDTO cri, Model model) {
//		List<NoticeVO> n_List = service.noticeGetAll();
//		model.addAttribute("noticeList", n_List);
		//페이징 처리 List
		System.out.println("noticeList요청");
		PageDTO page = new PageDTO(cri, service.getTotalCount(cri));
		model.addAttribute("pageMaker", page);
		model.addAttribute("noticeList", service.pagingList(cri));
		return "manager/notice/noticeList";
	}
	
	@RequestMapping("/noticeWrite")
	public String showNoticeWriteForm() {
		return "manager/notice/noticeWriteForm";
	}
	
	@RequestMapping(value="/noticeWrite", method=RequestMethod.POST)
	public String doNoticeRegister(NoticeVO notice, Model model) {
		String msg = "공지사항 등록에 실패하였습니다.";
		String url = "noticeList";
		if(service.noticeRegister(notice)) {
			//등록 성공 -> noticeList로 돌아감
			msg = "공지사항이 등록되었습니다.";
		}else {
			// 등록 실패 -> writeForm 위치 유지
			url = "notice/noticeWriteForm";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	/*
	@RequestMapping("/noticeView")
	public String showNoticeView(int num, Model model) {
		NoticeVO notice = service.noticeGetOne(num);
		model.addAttribute("notice", notice);
		return "manager/notice/noticeView";
	}
	*/
	
	//조회수 증가
	@RequestMapping("/noticeView")
	public String showNoticeView(int num, HttpServletRequest request, HttpServletResponse response, Model model, @RequestParam(defaultValue = "1")int curPage) {
		NoticeVO notice = service.noticeGetOne(num);
		Cookie[] cookies = request.getCookies(); 
		Cookie targetCookie = null;
		
		String url = "";
		String msg = "";
		//상세보기 요청 들어올때마다 쿠키 검사
		//쿠키가 있는 경우
		if(cookies != null && cookies.length > 0) {
			System.out.println("cookie 있음");
			//쿠키 배열 검사 (게시글 번호, 아이디)
			for(int i=0; i<cookies.length; i++) {
				// Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
				if(cookies[i].getName().equals("nCookie"+num)) {
					System.out.println("이미 조회한 게시물, 쿠키 생성 후 재진입");
					targetCookie = cookies[i];
				}
			}
		}
		
		//해당 번호의 게시글(얻어옴) 있으면 쿠키 생성
		if(notice != null) {
			//해당번호의 게시물 있음
			System.out.println("쿠키생성할까요?");
			if(targetCookie == null) {
				//이미 생성된 쿠키 없음 >> 처음 클릭
				System.out.println("생성된 쿠키없음");
				//쿠키 생성(이름, 값)
				Cookie newCookie = new Cookie("nCookie"+num, "|"+num+"|");
				//쿠키 추가
				response.addCookie(newCookie);
				//쿠키 추가 후 조회수 올리기
				if(service.increaseViewCnt(num)) {
					System.out.println("조회수 증가");
				}else {
					System.out.println("조회수 증가 실패");
				}
			}else {
				//이미 생성된 쿠키 없음  >> 쿠키 값 받아옴
				String name = targetCookie.getName();
				String value = targetCookie.getValue();
				System.out.println("쿠키 이름: "+name);
				System.out.println("쿠키 값: "+value);
			}
			notice = service.noticeGetOne(num);
			model.addAttribute("notice", notice);
			int boardNum = num;
			int count = service.getTotalReplies(boardNum);
			ReplyPager rPager = new ReplyPager(count, curPage);
			model.addAttribute("rPager", rPager);
			System.out.println(curPage);
			return "manager/notice/noticeView";
		}
		//선택된 게시물 없음
		model.addAttribute(msg, "삭제된 게시물 입니다.");
		model.addAttribute(url, "noticeList");
		
		
		return "manager/result";
	}
	
	
	@RequestMapping("/noticeModify")
	public String showNoticeModifyForm(int num, Model model) {
		model.addAttribute("notice", service.noticeGetOne(num));
		return "manager/notice/noticeModifyForm";
	}
	
	@RequestMapping(value="/noticeModify", method=RequestMethod.POST)
	public String doNoticeModify(NoticeVO notice, Model model) {
		String msg ="공지사항 수정에 실패하였습니다.";
		String url = "noticeView?num="+notice.getNum();
		if(service.noticeModify(notice)) {
			msg = "공지사항 수정에 성공하였습니다.";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	/* 삭제 부분
	@RequestMapping(value="/noticeRemove", method=RequestMethod.POST)
	public boolean doNoticeRemove(int num) {
		System.out.println(num);
		return service.noticeRemove(num);
	}
	*/
	
	
//	pwEncoder.matches(받아온 pw, 오리지널pw)
	
	/**** 비밀번호 확인(checkPassword) ****/
	@RequestMapping(value="/checkPw", method=RequestMethod.POST)
	public String doCheckPw(int num, String type, String password, Model model, Principal principal) {
		String url = "noticeList";
		String msg = "";
		String id = principal.getName();
//		System.out.println("id는"+id);
//		System.out.println("로그인한 아이디: "+id);
		MemberVO mem = memService.memberGetOne(id);
//		System.out.println(mem);
		String originPw = mem.getMember_password();
//		System.out.println("originPw"+originPw);
		NoticeVO notice = service.noticeGetOne(num);
		if(notice != null && pwEncoder.matches(password, originPw)) {
			//비밀번호 일치
			if(type.equals("delete")) {
				// 삭제요청
				if(service.nReplyRemoveByBNum(num)) {
					System.out.println("해당 notice Reply 삭제완료");
				}else {
					System.out.println("해당 notice Reply 삭제 실패");
				}
				if(service.noticeRemove(num)) {
					//삭제 성공(파일 삭제) >> 이동할 화면
					//Service에서 작성하기
					System.out.println("Notice삭제 성공");
					msg = "공지가 삭제되었습니다";
				}else {
					//삭제실패
					url = "noticeView?num="+num;
					msg = "공지 삭제에 실패하였습니다.";
					System.out.println("Notice삭제 실패");
				}
			}
		}else {
			//비밀번호 불일치
			System.out.println("비밀번호가 틀렸습니다.");
			msg = "비밀번호를 다시 확인하세요.";
			url = "noticeView?num="+num;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	//Notice_reply 처리
	@ResponseBody
	@RequestMapping(value="/reply/write", method=RequestMethod.POST)
	public boolean replyRegister(NoticeReplyVO nReply) throws Exception {
		return service.nReplyRegister(nReply);
	}
	
	@ResponseBody
	@RequestMapping("/reply/all")
	public Map<String, Object> getAllByBNum(@RequestParam("boardNum")int boardNum, @RequestParam(defaultValue = "1")int curPage, Model model){
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		int count = service.getTotalReplies(boardNum);
		ReplyPager rPager = new ReplyPager(count, curPage);
		int start = rPager.getPageBegin();
		int end = rPager.getPageEnd();
		rMap.put("rPager", rPager);
		rMap.put("replies", service.nRepliesGetByBNum(boardNum, start, end));
		return rMap;
	}
	
	
	//댓글수 가져오는 요청 처리
	@ResponseBody
	@RequestMapping("/reply/getReplyCnt")
	public int getReplyCount(int boardNum) {
		System.out.println("replyCount 요청 들어옴");
		return service.getnReplyCount(boardNum);
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/modify", method=RequestMethod.POST)
	public boolean replyModify(NoticeReplyVO nReply, String pw) {
		//비밀번호 같으면 수정
		NoticeReplyVO reply = service.nReplyGetOne(nReply.getNum());
		if(reply != null && pw.equals("true")) {
			System.out.println("비밀번호 일치");
//			System.out.println(nReply.toString());
			return service.nReplyModify(nReply);
		}else {
			return false;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/delete", method=RequestMethod.POST)
	public boolean replyRemove(int num, String pw) throws Exception {
		NoticeReplyVO reply = service.nReplyGetOne(num);
		if(reply != null && pw.equals("true")) {
			return service.nReplyRemove(num);
		}else {
			return false;
		}
	}
}
