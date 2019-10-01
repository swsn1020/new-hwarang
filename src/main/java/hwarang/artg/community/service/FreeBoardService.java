package hwarang.artg.community.service;

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
import hwarang.artg.community.model.FreeBoardVO;
import hwarang.artg.community.model.FreeImgVO;
import hwarang.artg.mapper.FreeBoardMapper;
import hwarang.artg.mapper.FreeImgMapper;
import hwarang.artg.mapper.FreeReplyMapper;

@Service
public class FreeBoardService {
	//파일 저장경로
	public static final String UPLOAD_PATH = "C:\\IMAGE\\free";
	
	@Autowired
	private FreeBoardMapper freeboardMapper;
	
	@Autowired
	private FreeReplyMapper freereplyMapper;
	
	@Autowired
	private FreeImgMapper freeimgMapper;
	
	public List<FreeBoardVO> freeboardGetAllId(String id) {
		return freeboardMapper.selectOne_id(id);
	}
	@Transactional
	public boolean freeboardRegister(FreeBoardVO freeboard,List<MultipartFile> fileList) {
		if(freeboardMapper.insertBoard(freeboard)>0) {
			if(fileList.get(0).getOriginalFilename().equals("")) {
				System.out.println("파일선택하지않음");	
				return true;
			}else {
				//DB에 저장
				System.out.println("선택 fileList" + fileList.size());
				List<Map<String,Object>> fList = writeFile(fileList);
				System.out.println(fList.toString());
				for(int i=0;i<fList.size();i++) {
					Map<String,Object> fileMap = fList.get(i);
					fileMap.put("freeNum",freeboard.getNum());
					System.out.println(fileMap.put("freeNum",freeboard.getNum()));
					FreeImgVO freeImg = new FreeImgVO();
					freeImg.setUuid((String) fileMap.get("uuid")); 
					freeImg.setFreeNum((Integer) fileMap.get("freeNum"));
					freeImg.setUploadPath((String) fileMap.get("uploadPath"));
					freeImg.setOriginName((String) fileMap.get("originName"));
					if(freeimgMapper.insertFile(freeImg)>0) {
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
	@Transactional
	public boolean freeboardModify(FreeBoardVO freeboard, List<MultipartFile> fileList) {
		if(freeboardMapper.updateBoard(freeboard)>0) {
			if(fileList.get(0).getOriginalFilename().equals("")) {
				System.out.println("파일 선택하지 않음");
				return true;
			}else {
				System.out.println("선택 fileList" + fileList.size());
				List<Map<String,Object>> fList = writeFile(fileList);
				for(int i=0;i<fList.size();i++) {
					Map<String,Object> fileMap = fList.get(i);
					fileMap.put("freeNum",freeboard.getNum());
					FreeImgVO freeImg = new FreeImgVO();
					freeImg.setUuid((String) fileMap.get("uuid")); 
					freeImg.setFreeNum((Integer) fileMap.get("freeNum"));
					freeImg.setUploadPath((String) fileMap.get("uploadPath"));
					freeImg.setOriginName((String) fileMap.get("originName"));
					if(freeimgMapper.insertFile(freeImg)>0) {
						System.out.println("파일 db등록 성공");
					}else {
						System.out.println("파일 db등록 실패");
					}
				}
				return true;
			}
		}
		return false;
	}
	public boolean freeboardRemove(int num) {
		if(freeboardMapper.deleteBoard(num)>0) {
			System.out.println("삭제되었습니다");
			if(freeimgMapper.deleteFileByFNum(num)>0) {
				System.out.println("free 파일 삭제 성공");
				return true;
			}
		}
		System.out.println("삭제실패");
		return false;
	}
	public List<FreeBoardVO> freeboardGetAll(){
		return freeboardMapper.selectAll();
	}
	public FreeBoardVO freeboardGetone(int num) {
		return freeboardMapper.selectOne(num);
	}
	
	// 상세보기 조회(조회수 증가)
	public boolean IncreaseReadCnt(int num) {
		if(freeboardMapper.updateReadCount(num)>0) {
			return true;
		}
		return false;
	}
	
	public int getTotal(CriteriaDTO cri) {
		return freeboardMapper.getTotalCount(cri);
	}
	
	public List<FreeBoardVO> pagingList(CriteriaDTO cri){
		return freeboardMapper.getListWithPaging(cri);
	}
	private List<Map<String, Object>> writeFile(List<MultipartFile> fileList) {
		List<Map<String,Object>> targetList = new ArrayList<Map<String,Object>>();
		for(int i=0;i<fileList.size();i++) {
			MultipartFile file = fileList.get(i);
			String originName  = file.getOriginalFilename();
			String fullName = null;
			UUID uuid = UUID.randomUUID();
			fullName = i + "_" + uuid.toString()+"_"+originName;
			File target = new File(UPLOAD_PATH,fullName);
			try {
					FileCopyUtils.copy(file.getBytes(),target);
			} catch(IOException e) {
					e.printStackTrace();
					System.out.println("파일 복사 예외 발생");
					return null;
			}
			Map<String,Object> copyList = new HashMap<String,Object>();
			copyList.put("uuid",fullName);
			copyList.put("uploadPath",UPLOAD_PATH);
			copyList.put("originName",originName);
			targetList.add(copyList);
		}
		return targetList;
	}
	
	//파일다운로드
	public View getAttachment(String uuid) {
		FreeImgVO freeImg = freeimgMapper.selectFile(uuid);
		String fileName = freeImg.getUuid();
		File file = new File(UPLOAD_PATH, fileName);
		View view = new DownloadView(file);
		return view;
	}
	public int getnReplyCount(int num) {
		return freereplyMapper.getReplyCnt(num);
	}
	/*block 처리 -hj*/
	//Block 처리하기1(Notice)
	public boolean doBoardBlock(String block, int num) {
		if(freeboardMapper.updateBlock(block, num) > 0) {
			return true;
		}
		return false;
	}
	
	
}