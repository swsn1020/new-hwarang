package hwarang.artg.manager.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.manager.model.QnAVO;
import hwarang.artg.manager.service.QnAImgService;
import hwarang.artg.manager.service.QnAService;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.member.service.MemberAuthService;
import hwarang.artg.member.service.MemberService;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/qna")
public class QnAController {
	@Autowired
	private QnAService service;
	@Autowired
	private QnAImgService imgService;
	@Autowired
	private PasswordEncoder pwEncoder;
	@Autowired
	private MemberService memService;
	@Autowired
	private MemberAuthService memAuthService;
	
	@RequestMapping("/qnaListForManager")
	public String showQnAList(CriteriaDTO cri, Model model, Principal principal) {
		System.out.println("qnaListForManager요청");
		
		String id = principal.getName();
		List<String> auths = memAuthService.memberAuthsById(id);
		if(auths.contains("ROLE_ADMIN") || auths.contains("ROLE_MANAGER")) {
			//페이징 처리 없는 list
//		model.addAttribute("qnaList", service.qnaGetAll());
			PageDTO page = new PageDTO(cri, service.getTotalCount());
			model.addAttribute("pageMaker", page);
			model.addAttribute("qnaList", service.pagingList(cri));
			return "manager/qna/managerQnaList";
		}else {
			String msg = "접근 권한이 없는 페이지입니다.";
			String url = "/";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "manager/result";
		}
		
	}
	
	@RequestMapping("/qnaListForUser")
	public String showQnAListForUser(CriteriaDTO cri, String memId, Model model, Principal principal) {
		System.out.println("qnaListForUser요청");
		String id = principal.getName();
		if(memId.equals(id)) {
			PageDTO page = new PageDTO(cri, service.getTotalCount(memId));
			model.addAttribute("pageMaker", page);
			model.addAttribute("qnaList", service.pagingList(cri, memId));
			return "manager/qna/userQnaList";
		}else {
			String msg = "해당 Q&A 작성자만 열람 가능합니다.";
			String url = "qnaListForUser?memId="+id;
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "manager/result";
		}
	}

	@RequestMapping("/qnaWrite")
	public String showQnAWriteForm() {
		return "manager/qna/qnaWriteForm";
	}
	
	@RequestMapping(value="/qnaWrite", method=RequestMethod.POST)
	public String doQnARegister(QnAVO QnA, String subCategory, Model model, MultipartHttpServletRequest request) {
		System.out.println("qnaWrite 요청");
		String category = QnA.getCategory();
		QnA.setCategory(category+"_"+subCategory);
		String msg = "QnA 등록에 실패하였습니다. 다시 시도하세요";
		String url = "qnaListForUser?memId="+QnA.getMemId(); 	// 사용자는 등록 후 qnaList로 돌아가면 안된다(main)
		List<MultipartFile> fileList = request.getFiles("file");
		if(service.qnaRegister(QnA, fileList)) {
			//질문 등록 성공(파일도)
			System.out.println("QnA 등록성공");
			msg = "QnA가 등록되었습니다.";
		}else {
			//질문 등록 실패
			System.out.println("QnA 등록실패");
			url = "qnaWrite";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	@RequestMapping("/qnaView")
	public String showQnAView(int num, Model model, Principal principal) {
		System.out.println("View 요청 들어옴");
		String writer = service.qnaGetOne(num).getMemId();
		String id = principal.getName();
		List<String> auths = memAuthService.memberAuthsById(id);
		System.out.println("현재로그인한 아이디:"+id);
		if(writer.equals(id)||auths.contains("ROLE_ADMIN") || auths.contains("ROLE_MANAGER")) {
			model.addAttribute("qna", service.qnaGetOne(num));
			model.addAttribute("qnaImgList", imgService.qnaImgGetByQNum(num));
			return "manager/qna/qnaView";
		}else {
			String msg = "해당 Q&A 작성자만 열람 가능합니다.";
			String url = "qnaListForUser?memId="+id;
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "manager/result";
		}
		
	}
	
	//사용자_문의 수정
	@RequestMapping("/qnaModify")
	public String showQnAModifyForm(int num, Model model) {
		model.addAttribute("qna", service.qnaGetOne(num));
		model.addAttribute("qnaImgList", imgService.qnaImgGetByQNum(num));
		return "manager/qna/qnaModifyForm";
	}
	@RequestMapping(value="/qnaModify", method=RequestMethod.POST)
	public String doQnAModify(QnAVO QnA, String category, String subCategory, Model model, MultipartHttpServletRequest request) {
		int qnaNum = QnA.getNum();
		category = category+"_"+subCategory;
		QnA.setCategory(subCategory);
		String msg = "QnA 수정에 실패하였습니다. 다시 시도하세요.";
		String url = "qnaView?num="+qnaNum;
		List<MultipartFile> fileList = request.getFiles("file");
//		System.out.println(fileList.get(0).getOriginalFilename());
//		System.out.println("Controller"+fileList.get(0));
		if(service.qnaModify(QnA, fileList)) {
			System.out.println("QnA 수정성공");
			msg = "QnA가 수정되었습니다.";
		}else {
			System.out.println("QnA 수정 실패");
			url = "qnaModify?num="+qnaNum;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	//관리자_ 답변 수정
//	@ResponseBody
	@RequestMapping(value="/replyModify", method=RequestMethod.POST)
	public String doReplyModify(int num, String reply, Model model) {
		String msg = "답글 등록에 실패하였습니다. 다시시도하세요.";
		String url = "qnaListForManager";
		if(service.qnaModify(num, reply)) {
			msg = "답글이 등록되었습니다.";
		}else {
			url = "qnaView?num="+num;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	@RequestMapping(value="/checkPw", method=RequestMethod.POST)
	public String doCheckPw(int num, String type, String password, Principal principal, Model model) {
		System.out.println("checkPw요청들어옴 "+type);
		String id = principal.getName();
		String msg = "";
		String url = "qnaListForUser?memId="+id;
		MemberVO mem = memService.memberGetOne(id);
		String originPw = mem.getMember_password();
		QnAVO qna = service.qnaGetOne(num);
		if(qna != null && pwEncoder.matches(password, originPw)) {
			//비밀번호 일치
			if(type.equals("delete")) {
				// 삭제요청
				if(service.qnaRemove(num)) {
					//삭제 성공(파일 삭제) >> 이동할 화면
					System.out.println("QnA삭제 성공");
					msg = "QnA가 삭제되었습니다";
				}else {
					//삭제실패
					url = "qnaView?num="+num;
					msg = "QnA삭제에 실패하였습니다.";
					System.out.println("QnA삭제 실패");
				}
			}else if(type.equals("modify")) {
				//수정요청 (수정폼 불러오기)
				System.out.println("수정요청");
				return "redirect:qnaModify?num="+num;
			}
		}else {
			//비밀번호 불일치
			System.out.println("비밀번호가 틀렸습니다.");
			msg = "비밀번호를 다시 확인하세요.";
			url = "qnaView?num="+num;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	//첨부 파일 저장(Thumbnail)
	public static final String UPLOAD_PATH = "C:\\IMAGE\\Report";
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
		
	//파일 다운로드
	@RequestMapping("/download")
	public View download(String uuid) {
		System.out.println("파일uuid : "+uuid);
		return service.getAttachment(uuid);
	}
	
	@ResponseBody
	@RequestMapping(value="/fileDelete", method=RequestMethod.POST)
	public boolean doFileDelete(String uuid) {
		return imgService.qnaImgRemove(uuid);
	}
	

}
