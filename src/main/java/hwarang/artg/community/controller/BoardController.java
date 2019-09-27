package hwarang.artg.community.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.community.model.FreeBoardVO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.community.service.FreeBoardService;
import hwarang.artg.community.service.FreeImgService;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/board")
public class BoardController {
	private static final String UPLOAD_PATH = "C:\\IMAGE";
	@Autowired
	private FreeBoardService fservice;

	@Autowired
	private FreeImgService imgService;

	@RequestMapping(value = "/freeboard", method = RequestMethod.GET)
	public String showfreeboardList(Model model, CriteriaDTO cri) throws Exception {
		PageDTO page = new PageDTO(cri, fservice.getTotal(cri));
		System.out.println(page);
		model.addAttribute("pageMaker", page);
		model.addAttribute("freeboard", fservice.pagingList(cri));
		System.out.println(page);
		return "/board/freeboard";
	}

	@RequestMapping("/freeboardView")
	public String showfreeboardView(Model model, int num) {
		model.addAttribute("fboard", fservice.IncreaseReadCnt(num));
		System.out.println(imgService.freeImgGetByFNum(num));
		model.addAttribute("freeImgList",imgService.freeImgGetByFNum(num));
		return "/board/freeboardView";
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String showRegisterfreeForm() {
		return "/board/freeboardRegister";

	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String RegisterfreeBoard(FreeBoardVO freeboard, Model model, MultipartHttpServletRequest request) {
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
}
