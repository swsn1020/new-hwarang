package hwarang.artg.community.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.text.DateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.community.model.FreeBoardVO;
import hwarang.artg.community.model.FreeLikeVO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.common.model.ReplyPager;
import hwarang.artg.community.service.FreeBoardService;
import hwarang.artg.community.service.FreeImgService;
import hwarang.artg.community.service.FreeLikeService;
import hwarang.artg.community.service.FreeReplyService;
import hwarang.artg.exhibition.model.ExhLikeVO;
import hwarang.artg.manager.model.NoticeVO;
import hwarang.artg.member.service.MemberService;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/board")
public class BoardController {
	private static final String UPLOAD_PATH = "C:\\IMAGE\\free";
	@Autowired
	private FreeBoardService fservice;
	
	@Autowired
	private FreeReplyService rservice;

	@Autowired
	private FreeImgService imgService;
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private FreeLikeService likeservice;

	@RequestMapping(value = "/freeboard", method = RequestMethod.GET)
	public String showfreeboardList(Model model, CriteriaDTO cri,Principal principal) throws Exception {
		
		PageDTO page = new PageDTO(cri, fservice.getTotal(cri));
		System.out.println(page);
		model.addAttribute("pageMaker",page);
		model.addAttribute("freeboard", fservice.pagingList(cri));
//		model.addAttribute("principal",principal);
		System.out.println(page);
		return "/board/freeboard";
	}

	@RequestMapping("/freeboardView")
	public String showfreeboardView(Model model, int num,HttpServletRequest request, HttpServletResponse response, @RequestParam(defaultValue = "1")int curPage,Principal principal) {
//		String id = principal.getName();
//		model.addAttribute("id",id);
//		model.addAttribute("principal",principal);
		FreeBoardVO free = fservice.freeboardGetone(num);
		Cookie [] cookies = request.getCookies();
		Cookie targetCookie = null;
		
		String url = "";
		String msg = "";
		//상세보기 요청 들어올때마다 쿠키 검사
		//쿠키가 있는 경우
		if(cookies != null && cookies.length>0) {
			System.out.println("cookie 있음");
			//쿠키 배열검사 (게시글 번호, 아이디)
			for(int i=0;i<cookies.length;i++) {
				// Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
				if(cookies[i].getName().equals("nCookie"+num)) {
					System.out.println("이미 조회한 게시물,쿠키 생성후 재진입");
					targetCookie = cookies[i];
				}
			}
		}
		//해당 번호의 게시글(얻어옴) 있으면 쿠키 생성
		if(free != null) {
			//해당번호의 게시물 있음
			System.out.println("쿠키생성할까요??");
			if(targetCookie ==null) {
				//이미 생성된 쿠키 없음 >> 처음클릭
				System.out.println("생성된 쿠키없음");
				//쿠키생성(이름,값)
				Cookie newCookie = new Cookie("nCookie"+num,"|"+num+"|");
				//쿠키 추가
				response.addCookie(newCookie);
				//쿠키추가 후 조회수 올리기
				if(fservice.IncreaseReadCnt(num)) {
					System.out.println("조회수 증가");
				}else {
					System.out.println("조회수 증가 실패");
				}
			}else {
				//이미 생성된 쿠키 없음 >> 쿠키 값 받아옴
				String name = targetCookie.getName();
				String value = targetCookie.getValue();
				System.out.println("쿠키 이름:"+name);
				System.out.println("쿠키 값 : "+value);
			}
			free = fservice.freeboardGetone(num);
			model.addAttribute("fboard",free);
			int fboardNum = num;
			int count = rservice.getTotalReplies(fboardNum);
			ReplyPager rPager = new ReplyPager(count,curPage);
			model.addAttribute("rPager",rPager);
			model.addAttribute("freeImgList",imgService.freeImgGetByFNum(fboardNum));
			System.out.println(curPage);
			return "/board/freeboardView";			
		}
		//선택된 게시물 없음
		model.addAttribute(msg, "삭제된 게시물 입니다.");
		model.addAttribute(url, "freeboard");
		return "board/result";
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String showRegisterfreeForm(Model model) {
		return "/board/freeboardRegister";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String freeBoardRegister(FreeBoardVO freeboard, Model model, MultipartHttpServletRequest request) {
		System.out.println("test");
		List<MultipartFile> fileList = request.getFiles("file");
		boolean result = fservice.freeboardRegister(freeboard, fileList);
		String url = "freeboard";
		String msg = "";
		if (result) {
			msg = "등록되었습니다.";
		} else {
			msg = "등록실패했습니다.";
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		return "/board/result";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String showmodifyForm(Model model, int num) {
		model.addAttribute("fboard",fservice.freeboardGetone(num));
		model.addAttribute("freeImgList",imgService.freeImgGetByFNum(num));
		return "/board/freemodifyForm";

	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyfreeboard(FreeBoardVO freeboard, Model model,MultipartHttpServletRequest request) {
		String url = "freeboard";
		String msg = "";
		List<MultipartFile> fileList = request.getFiles("file");
		if (fservice.freeboardModify(freeboard,fileList)) {
			msg = "수정되었습니다";
		} else {
			msg = "수정 실패";
		}
		System.out.println(fileList.size());
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "/board/result";
	}

	@RequestMapping(value = "remove")
	public String removefreeboard(int num, Model model) {
		fservice.freeboardRemove(num);
		model.addAttribute("msg", "삭제되었습니다");
		model.addAttribute("url", "freeboard");
		return "/board/result";

	}

	@RequestMapping("/downloadThumb")
	protected void download(String uuid, HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath = UPLOAD_PATH + "\\" + uuid;
		File image = new File(filePath);
		int lastIndex = uuid.lastIndexOf(".");
		String fileName = uuid.substring(0, lastIndex);
		File thumbnail = new File(UPLOAD_PATH + "\\" + "thumbnail" + "\\" + fileName + ".jpg");
		if (image.exists()) {
			thumbnail.getParentFile().mkdirs();
			Thumbnails.of(image).size(100, 100).outputFormat("jpg").toFile(thumbnail);
		}
		FileInputStream in = new FileInputStream(thumbnail);
		byte[] buffer = new byte[1024 * 8];
		while (true) {
			int count = in.read(buffer); // 버퍼에 읽어들인 문자개수
			if (count == -1) // 버퍼의 마지막에 도달했는지 체크
				break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}

	// 파일 다운로드(파일이름 클릭 시 다운로드됨)
	@RequestMapping("/download")
	public View download(String uuid) {
		System.out.println("파일uuid : " + uuid);
		return fservice.getAttachment(uuid);
	}

	// 상세보기 화면에서 파일 이름 옆에 삭제 버튼 클릭시 삭제
	@ResponseBody
	@RequestMapping(value = "/fileDelete", method = RequestMethod.POST)
	public boolean doFileDelete(String uuid) {
		System.out.println("파일 삭제 test");
		return imgService.freeImgRemove(uuid);
	}
	
	//댓글수 가져오는 요청 처리
	@ResponseBody
	@RequestMapping("/reply/getReplyCnt")
	public int getReplyCount(int fboardNum) {
		System.out.println("replyCount 요청 들어옴");
		return fservice.getnReplyCount(fboardNum);
	}	
	
	//수정한것
	@RequestMapping("checkUserNotice")
	public @ResponseBody Map<String, Object> checkUserNotify(
			@RequestParam("member_id") String member_id) throws Exception {
		Map<String, Object> ret = new HashMap<>();
		int result = memberservice.getNoticeCount(member_id);
		ret.put("result", result );
		return ret;
	}
	
	@RequestMapping("getUserNotice")
	public @ResponseBody List<NoticeVO> getUserNotice(@RequestParam("member_id") String member_id){
		List<NoticeVO> result = memberservice.getUserNotice(member_id);
		if(result!=null) memberservice.readUserNotice(member_id);
		return result;
	}
	
	//추천 하기
	@RequestMapping("/like/add")
	public String likeAdd(Principal principal,int num) {
		FreeLikeVO like = new FreeLikeVO(principal.getName(),num,1);
		likeservice.addLikeStatus(like);
		fservice.updateLike(num);
//		return "/board/freeboardView";
		return "redirect:/board/freeboardView?num="+num;
	}	
	@RequestMapping("/like/modify")
	public String likeModi(Principal principal, int num, int status) {
		System.out.println(num+"번 추천 수정요청!");
		FreeLikeVO like = new FreeLikeVO(principal.getName(),num, status);
		likeservice.modifyLikeStatus(like);
		fservice.updateLike(num);
//		return "/board/freeboardView";
		return "redirect:/board/freeboardView?num="+num;
	}
	@RequestMapping("/unlike/add")
	public String unlikeAdd(Principal principal,int num) {
		FreeLikeVO like = new FreeLikeVO(principal.getName(),num,2);
		likeservice.addLikeStatus(like);
		fservice.updateLike(num);
		return "redirect:/board/freeboardView?num="+num;
	}	
}
