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
import hwarang.artg.manager.model.ReportImgVO;
import hwarang.artg.manager.model.ReportVO;
import hwarang.artg.mapper.ReportImgMapper;
import hwarang.artg.mapper.ReportMapper;

@Service
public class ReportService {
	@Autowired
	private ReportMapper dao;
	@Autowired
	private ReportImgMapper imgDao;
	
	@Transactional
	public boolean reportRegister(ReportVO report, List<MultipartFile> fileList) {
		if (dao.insertReport(report) > 0) {
			if (fileList.get(0).getOriginalFilename().equals("")) {
				System.out.println("파일선택하지 않음");
				return true;
			} else {
				// DB에 저장
				System.out.println("선택fileList" + fileList.size());
				List<Map<String, Object>> fList = writeFile(fileList);
				System.out.println(fList.toString());
				for (int i = 0; i < fList.size(); i++) {
					Map<String, Object> fileMap = fList.get(i);
					fileMap.put("reportNum", report.getNum());
					ReportImgVO reportImg = new ReportImgVO();
					reportImg.setUuid((String) fileMap.get("uuid"));
					reportImg.setReportNum((int) fileMap.get("reportNum"));
					reportImg.setUploadPath((String) fileMap.get("uploadPath"));
					reportImg.setOriginName((String) fileMap.get("originName"));
					if (imgDao.insertFile(reportImg) > 0) {
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
	
	@Transactional
	public boolean reportModify(ReportVO report, List<MultipartFile> fileList) {
		if(dao.updateReport(report) > 0) {
			if (fileList.get(0).getOriginalFilename().equals("")) {
				System.out.println("파일 선택하지 않음");
				return true;
			} else {
				System.out.println("선택fileList" + fileList.size());
				List<Map<String, Object>> fList = writeFile(fileList);
				for (int i = 0; i < fList.size(); i++) {
					Map<String, Object> fileMap = fList.get(i);
					fileMap.put("reportNum", report.getNum());
					ReportImgVO reportImg = new ReportImgVO();
					reportImg.setUuid((String) fileMap.get("uuid"));
					reportImg.setReportNum((int) fileMap.get("reportNum"));
					reportImg.setUploadPath((String) fileMap.get("uploadPath"));
					reportImg.setOriginName((String) fileMap.get("originName"));
					if (imgDao.insertFile(reportImg) > 0) {
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
	
	//답변 수정하기
	public boolean replyModify(int num, String reply) {
		if(dao.updateReply(num, reply) > 0) {
			return true;
		}
		return false;
	}
	
	@Transactional
	public boolean reportRemove(int num) {
		if(dao.deleteReport(num) > 0) {
			//포함된 파일 모두 삭제
			System.out.println("ReportDAO 삭제요청");
			if(!imgDao.selectFilesByRNum(num).isEmpty()) {
				System.out.println("파일 있음");
				if(imgDao.deleteFileByRNum(num)>0) {
					System.out.println("Report파일 삭제 성공");
					return true;
				}
			}else {
				//첨부된 파일 없음
				System.out.println("파일 없음");
				return true;
			}
		}
		return false;
	}
	
	public ReportVO reportGetOne(int num) {
		return dao.selectReport(num);
	}
	
	public List<ReportVO> reportGetAll() {
		return dao.selectAllReports();
	}
	
	//페이징 처리한 list
	public List<ReportVO> pagingList(CriteriaDTO cri){
		return dao.getListWithPaging(cri);
	}
	
	public int getTotalCount() {
		return dao.getTotalCount();
	}
	
	//파일저장경로
	public static final String UPLOAD_PATH = "C:\\IMAGE\\Report";
	
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
		ReportImgVO reportImg = imgDao.selectFile(uuid);
		String fileName = reportImg.getUuid();
		File file = new File(UPLOAD_PATH, fileName);
		View view = new DownloadView(file);
		return view;
	}
	

}
