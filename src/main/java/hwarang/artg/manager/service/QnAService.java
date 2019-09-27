package hwarang.artg.manager.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.DownloadView;
import hwarang.artg.manager.model.QnAImgVO;
import hwarang.artg.manager.model.QnAVO;
import hwarang.artg.mapper.QnAImgMapper;
import hwarang.artg.mapper.QnAMapper;

@Service
public class QnAService {
	@Autowired
	private QnAMapper dao;
	@Autowired
	private QnAImgMapper imgDao;
	
	@Transactional
	public boolean qnaRegister(QnAVO QnA, List<MultipartFile> fileList) {
		if(dao.insertQnA(QnA) > 0) {
			//첨부파일 없으면
			if(fileList.get(0).getOriginalFilename().equals("")) {
				System.out.println("파일선택하지 않음");
				return true;
			}else {
				//DB에 저장
				System.out.println("선택fileList"+fileList.size());
				List<Map<String, Object>> fList = writeFile(fileList);
				System.out.println(fList.toString());
				for(int i=0; i<fList.size(); i++) {
					Map<String, Object> fileMap = fList.get(i);
					fileMap.put("qnaNum", QnA.getNum());
					QnAImgVO qnaImg = new QnAImgVO();
					qnaImg.setUuid((String)fileMap.get("uuid"));
					qnaImg.setQnaNum((int)fileMap.get("qnaNum"));
					qnaImg.setUploadPath((String)fileMap.get("uploadPath"));
					qnaImg.setOriginName((String)fileMap.get("originName"));
					if(imgDao.insertFile(qnaImg) > 0) {
						System.out.println("파일 DB등록 성공");
					}else {
						System.out.println("파일 DB등록 실패");
					}
				}
				return true;
			}
		}
		return false;
	}
	
	
	//사용자_ 질문 수정하기
	@Transactional
	public boolean qnaModify(QnAVO QnA, List<MultipartFile> fileList) {
		if (dao.updateQnA(QnA) > 0) {
			//fileList는 null값을 보내지 않음 >> fileName으로 검사!!
			if (fileList.get(0).getOriginalFilename().equals("")) {
				System.out.println("파일 선택하지 않음");
				return true;
			} else {
				System.out.println("선택fileList" + fileList.size());
				List<Map<String, Object>> fList = writeFile(fileList);
				for (int i = 0; i < fList.size(); i++) {
					Map<String, Object> fileMap = fList.get(i);
					fileMap.put("qnaNum", QnA.getNum());
					QnAImgVO qnaImg = new QnAImgVO();
					qnaImg.setUuid((String) fileMap.get("uuid"));
					qnaImg.setQnaNum((int) fileMap.get("qnaNum"));
					qnaImg.setUploadPath((String) fileMap.get("uploadPath"));
					qnaImg.setOriginName((String) fileMap.get("originName"));
					if (imgDao.insertFile(qnaImg) > 0) {
						System.out.println("파일 DB등록 성공");
					} else {
						System.out.println("파일 DB등록 실패");
					}
				}
				return true;
			}
		}
		return false;
	}
	
	//관리자_답변 수정하기
		public boolean qnaModify(int num, String reply) {
			if(dao.updateReply(num, reply) > 0) {
				return true;
			}
			return false;
		}
	
	@Transactional
	public boolean qnaRemove(int num) {
		if(dao.deleteQnA(num) > 0) {
			//포함된 파일 모두 삭제
			System.out.println("qna삭제요청");
			if(imgDao.deleteFileByQNum(num)>0) {
				System.out.println("파일 삭제 성공");
				return true;
			}
		}
		System.out.println("QnA 삭제 실패");
		return false;
	}
	
	public QnAVO qnaGetOne(int num) {
		return dao.selectQnA(num);
	}
	
	
	public List<QnAVO> qnaGetAll() {
		return dao.selectAllQnAs();
	}
	
	//최근게시물 5개 불러오기
	public List<QnAVO> qnaGetByRegDate(){
		return dao.getListByRegDate();
	}
	
	//user위한 페이징 처리 (사용자 아이디로)
	public List<QnAVO> pagingList(CriteriaDTO cri, String memId) {
		return dao.getPagingListById(cri, memId);
	}
	public int getTotalCount(String memId) {
		return dao.getTotalCountById(memId);
	}
	
	//페이징 처리 list
	public List<QnAVO> pagingList(CriteriaDTO cri){
		return dao.getListWithPaging(cri);
	}
	public int getTotalCount() {
		return dao.getTotalCount();
	}
	
	

	//파일저장경로
	public static final String UPLOAD_PATH = "C:\\IMAGE\\QnA";
	
	//파일 복사 저장하는 메서드
	public List<Map<String, Object>> writeFile(List<MultipartFile> fileList) {
		List<Map<String, Object>> targetList = new ArrayList<Map<String,Object>>();
		for(int i=0; i < fileList.size(); i++) {
			MultipartFile file = fileList.get(i);
			String originName = file.getOriginalFilename();
			String fullName = null;
			UUID uuid = UUID.randomUUID();
			fullName = i+"_"+uuid.toString()+"_"+originName;
			File target = new File(UPLOAD_PATH, fullName);
			try {
				FileCopyUtils.copy(file.getBytes(), target);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("파일 복사 예외 발생");
				return null;
			}
			Map<String, Object> copyList = new HashMap<String, Object>();
			copyList.put("uuid", fullName);
			copyList.put("uploadPath", UPLOAD_PATH);
			copyList.put("originName", originName);
			targetList.add(copyList);
		}
		return targetList;
	}
	
	//파일 다운로드
	public View getAttachment(String uuid) {
		QnAImgVO qnaImg = imgDao.selectFile(uuid);
		String fileName = qnaImg.getUuid();
		File file = new File(UPLOAD_PATH, fileName);
		View view = new DownloadView(file);
		return view;
	}
	
	
	
}
