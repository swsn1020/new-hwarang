package hwarang.artg.manager.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.manager.model.ReportVO;
import hwarang.artg.manager.service.ReportImgService;
import hwarang.artg.manager.service.ReportService;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/report")
public class ReportController {
	@Autowired
	private ReportService service;
	@Autowired
	private ReportImgService imgService;
	
	@RequestMapping("/reportList")
	public String showReportList(CriteriaDTO cri, Model model) {
		System.out.println("reportList요청");
		PageDTO page = new PageDTO(cri, service.getTotalCount());
		model.addAttribute("pageMaker", page);
		model.addAttribute("reportList", service.pagingList(cri));
		return "manager/report/reportList";
	}
	
	@RequestMapping("/reportWrite")
	public String showReportWriteForm() {
		return "manager/report/reportWriteForm";
	}
	
	@RequestMapping(value="/reportWrite", method=RequestMethod.POST)
	public String doReportWrite(ReportVO report, String subCategory, Model model, MultipartHttpServletRequest request) {
		System.out.println("reportWrite 요청");
		String category = report.getCategory();
		report.setCategory(category+"_"+subCategory);
		String msg = "Report등록에 실패하였습니다. 다시 시도하세요";
		String url = "reportList";
		List<MultipartFile> fileList = request.getFiles("file");
		if(service.reportRegister(report, fileList)) {
			System.out.println("report 등록성공");
			msg = "Report가 등록되었습니다.";
		}else {
			System.out.println("report 등록실패");
			url = "reportWrite";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	@RequestMapping("/reportView")
	public String showReportView(int num, Model model) {
		model.addAttribute("report", service.reportGetOne(num));
		model.addAttribute("reportImgList", imgService.reportImgGetByRNum(num));
		return "manager/report/reportView";
	}
	
	@RequestMapping("/reportModify")
	public String showReportModifyForm(int num, Model model) {
		model.addAttribute("report", service.reportGetOne(num));
		model.addAttribute("reportImgList", imgService.reportImgGetByRNum(num));
		return "manager/report/reportModifyForm";
	}
	
	@RequestMapping(value="/reportModify", method=RequestMethod.POST)
	public String doReportModify(ReportVO report, String subCategory, Model model, MultipartHttpServletRequest request) {
		int reportNum = report.getNum();
		String category = report.getCategory();
		report.setCategory(category+"_"+subCategory);
		String msg = "QnA 수정에 실패하였습니다. 다시 시도하세요.";
		String url = "reportView?num="+reportNum;
		List<MultipartFile> fileList = request.getFiles("file");
		if(service.reportModify(report, fileList)) {
			System.out.println("Report 수정성공");
			msg = "Report가 수정되었습니다.";
		}else {
			System.out.println("Report 수정 실패");
			url = "reportModify?num="+reportNum;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	@RequestMapping(value="/replyModify", method=RequestMethod.POST)
	public String doReplyModify(int num, String reply, Model model) {
		String msg = "답변 등록에 실패하였습니다. 다시 시도하세요.";
		String url = "reportList";
		if(service.replyModify(num, reply)) {
			msg = "답변이 등록되었습니다.";
		}else {
			url = "reportView?num="+num;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "manager/result";
	}
	
	@RequestMapping(value="/checkPw", method=RequestMethod.POST)
	public String doCheckPw(int num, String type, String password, Model model) {
		String url = "reportList";
		String msg = "";
		ReportVO report = service.reportGetOne(num);
		if(report != null && password.equals("true")) {
			//비밀번호 일치
			if(type.equals("delete")) {
				// 삭제요청
				if(service.reportRemove(num)) {
					//삭제 성공(파일 삭제) >> 이동할 화면
					System.out.println("report삭제 성공");
					msg = "report가 삭제되었습니다";
				}else {
					//삭제실패
					msg = "report 삭제에 실패하였습니다.";
					System.out.println("report삭제 실패");
				}
			}else if(type.equals("modify")) {
				//수정요청
				System.out.println("수정요청");
				return "redirect:reportModify?num="+num;
			}
		}else {
			//비밀번호 불일치
			System.out.println("비밀번호가 틀렸습니다.");
			msg = "비밀번호를 다시 확인하세요.";
			url = "reportView?num="+num;
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
		    Thumbnails.of(image).size(50, 50).outputFormat("png").toFile(thumbnail);
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
		return imgService.reportImgRemove(uuid);
	}
}
