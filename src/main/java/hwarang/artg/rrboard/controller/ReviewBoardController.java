package hwarang.artg.rrboard.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.print.attribute.standard.Severity;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.junit.jupiter.EnabledIfCondition;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.member.service.MemberService;
import hwarang.artg.rrboard.model.ReviewBoardVO;
import hwarang.artg.rrboard.model.ReviewImgVO;
import hwarang.artg.rrboard.service.ReviewBoardService;
import hwarang.artg.rrboard.service.ReviewImgService;
import hwarang.artg.rrboard.service.ReviewReplyService;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/review")
public class ReviewBoardController {
	@Autowired
	private MemberService memberservice;
	@Autowired
	private ReviewBoardService service;
	@Autowired
	private ReviewImgService imgservice;
	@Autowired
	private ReviewReplyService replyservice;

	@RequestMapping(value = "/reviewboard",method = RequestMethod.GET)
	public String showreviewboard(Model model,CriteriaDTO cri,Principal principal) {
		PageDTO page = new PageDTO(cri, service.getTotalCount(cri));
		model.addAttribute("pageMaker", page);
		model.addAttribute("reviewList", service.pagingList(cri));
		model.addAttribute("principal", principal);
		return "/review/reviewboardForm";
	}

	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String showreviewwrite(Principal principal,Model model) {
		model.addAttribute("principal", principal);
		return "/review/reviewwriteForm";
	}

	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String showrwrite(String member_id, String review_exh_name, String review_title, String review_content,
			 Model model,MultipartHttpServletRequest request){
		// exh_name : 결제한 프로그램 명
		List<MultipartFile> fileList =request.getFiles("file");
		ReviewBoardVO rb = new ReviewBoardVO();
		rb.setMember_id(member_id);
		rb.setReview_title(review_title);
		rb.setReview_exh_name(review_exh_name);
		rb.setReview_content(review_content);
		String msg = "";
		String url = "";

//		boolean result = service.reviewboardRegister_file(rb, file);
		boolean result = service.reviewboardRegister_files(rb, fileList);
		if (result) {
			msg = "작성되었습니다.";
			url = "view?num=" + rb.getReview_num();
		} else {
			msg = "다시 작성해주세요.";
			url = "write";
		}
		model.addAttribute("review", service.reviewboardGetOne(rb.getReview_num()));
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "/review/result";
	}

	@RequestMapping("/view")
	public String showreview(Model model, int num,Principal principal) {
		model.addAttribute("review", service.increasReadCnt(num));
		model.addAttribute("imgs", imgservice.reviewimgGetImgList(num));
		model.addAttribute("principal", principal);
		return "/review/review";
	}
//	@RequestMapping(value = "/checkPw",method = RequestMethod.GET)
//	public String showcheck() {
//		return "/review/reviewPwForm";
//	}
//
//	@RequestMapping(value = "/checkPw",method = RequestMethod.POST)
//	public String showcheckPw(String button, String id, String pw, int num,Model model) {
//		String msg = "다시 시도해주세요.";
//		String url = "view?num=" + num;
//		ReviewBoardVO rb = service.reviewboardGetOne(num);
//		if (id.equals(rb.getMember_id())) {
//			MemberVO m = memberservice.memberGetOne(id);
//			if (pw.equals(m.getMember_password())) {
//				if (button.equals("modify")) {
//					url = "modify?num=" + num;
//					msg = "";
//				} else if (button.equals("remove")) {
//					replyservice.reviewreplysRemoves(num);
//					imgservice.reviewimgNumRemove(num);
//					service.reviewboardRemove(num);
//					
//					msg = "삭제되었습니다.";
//					url = "reviewboard";
//				}
//			}
//		}
//		model.addAttribute("url", url);
//		model.addAttribute("msg", msg);
//		return "/review/result";
//	}
	@RequestMapping("/remove")
	public String showreviewremove(int num,Model model) {
		service.reviewboardRemove(num);
		model.addAttribute("msg", "삭제되었습니다.");
		model.addAttribute("url", "reviewboard");
		return "/review/result";
	}
	// 게시글의 글쓴이가 아닌경우 수정버튼 안보이도록 설정
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String showreviewmodify(Model model, int num) {
		model.addAttribute("review", service.reviewboardGetOne(num));
		model.addAttribute("imgs", imgservice.reviewimgGetImgList(num));
		return "/review/reviewmodifyForm";
	}

	// 수정후에 수정날짜로 바꾸도록?
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String showmodify(MultipartHttpServletRequest request,String id, Model model, int num, String title, String content) {
		List<MultipartFile> fileList = request.getFiles("file");
		ReviewBoardVO review = service.reviewboardGetOne(num);
		review.setReview_title(title);
		review.setReview_content(content);

//		int count = imgservice.reviewimgListCount(num);
//		ReviewImgVO img = imgservice.reviewimgGetOne(num);
		
//		int count = imgservice.reviewimgListCount(num);
//		System.out.println(count);
//		if(count>0) {//수정한경우:기존 첨부파일이 있는 경우 삭제
//			imgservice.reviewimgNumRemove(num);	//기존의 첨부파일 삭제하고 새로운 첨부파일 등록하기
//			System.out.println("count:"+count);
//		}
		boolean result = service.reviewimgModify(review,fileList);
		System.out.println(result);
		
		String msg = "다시 작성해주세요.";
		String url = "modify?num="+num;
		if (result) {
			msg = "수정되었습니다.";
			url = "view?num=" + num;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "/review/result";
	}

	//이미지 미리보기(썸네일)
    //경로 게시판마다 지정
	public static final String UPLOAD_PATH = "c:\\image\\";

	@RequestMapping("/downloadThumb")
	protected void download(String uuid, HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath = UPLOAD_PATH + "\\" + uuid;
		File image = new File(filePath);
		int lastIndex = uuid.lastIndexOf(".");
		String fileName = uuid.substring(0,lastIndex);
		File thumbnail = new File(UPLOAD_PATH+"\\"+"thumbnail"+"\\"+fileName+".png");
		if (image.exists()) { 
			thumbnail.getParentFile().mkdirs();
			Thumbnails.of(image).size(100, 100).outputFormat("png").toFile(thumbnail);
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
	
	//파일 다운로드(파일이름 클릭 시 다운로드됨)
	@RequestMapping("/download")
	public View download(String uuid) {
		System.out.println("파일uuid : "+uuid);
		return service.getAttachment(uuid);
	}
	
	//상세보기 화면에서 파일 이름 옆에 삭제 버튼 클릭시 삭제
	@ResponseBody
	@RequestMapping(value="/fileDelete", method=RequestMethod.POST)
	public boolean doFileDelete(String uuid) {
		return imgservice.reviewimgUuidRemove(uuid);
	}

}
