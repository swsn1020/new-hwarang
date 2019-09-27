package hwarang.artg.rrboard.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import hwarang.artg.mapper.RecommendBoardMapper;
import hwarang.artg.mapper.RecommendImgMapper;
import hwarang.artg.rrboard.model.RecommendBoardVO;
import hwarang.artg.rrboard.model.RecommendImgVO;
@Service
public class RecommendBoardService {
	//파일 저장할 경로
	private static final String UPLOAD_PATH="d:\\temp";
	@Autowired
	private RecommendBoardMapper rbmapper;
	@Autowired
	private RecommendImgMapper rimapper;
	
	//리뷰후기와 파일업로드 같이 작성하기
	public boolean recommendboardRegister(RecommendBoardVO rb,MultipartFile file) {
		if(rbmapper.insertRecommend_Board(rb) > 0) {
			if(file.isEmpty()) {			
				return true;
			}else {
				return true;
			}
		}
		return false;
	}
	//파일업로드를 위한 파일읽기,파일이름 변환
	public String writeFile(MultipartFile file) {
		String fullName = null;
		UUID uuid = UUID.randomUUID();
		fullName = uuid.toString()+"_"+file.getOriginalFilename();
		File target = new File(UPLOAD_PATH,fullName);
		
		try {
			FileCopyUtils.copy(file.getBytes(), target);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("File Copy Error");
			return null;
		}
		return fullName;
	}
	//파일이 저장된 경로에서 파일 얻어오기
//	public View getAttachment(int num) {
//		RecommendImgVO ri = rimapper.selectRecomm_Img(num);
//		String filename = ri.getRecomm_filename();
//		File file = new File(UPLOAD_PATH, filename);
//		View view = new DownloadView(file);
//		return view;
//	}
	
	public boolean recommendboardModify(RecommendBoardVO rb) {
		if(rbmapper.updateRecommend_Board(rb) > 0) {
			return true;
		}
		return false;
	}
	public boolean recommendboardRemove(int num) {
		if(rbmapper.deleteRecommend_Board(num) > 0) {
			return true;
		}
		return false;
	}
	public RecommendBoardVO recommendboardGetOne(int num) {
		return rbmapper.selectRecommend_Board(num);
	}
	public List<RecommendBoardVO> recommendboardGetAll(){
		return rbmapper.selectAllRecommend_Board();
	}
	//조회수
	public RecommendBoardVO increasReadCnt(int num){
		RecommendBoardVO rb = null;
		if(rbmapper.updateRecommend_Count(num) > 0) {
			rb = rbmapper.selectRecommend_Board(num);
		}
		return rb;
	}
	
//	public List<RecommendBoardVO> recommendboardGetListByPaging(){
//		return rbmapper.selectPageRecommend_Board(1, 10);
//	}
}
