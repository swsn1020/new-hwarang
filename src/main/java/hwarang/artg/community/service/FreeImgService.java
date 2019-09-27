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

import hwarang.artg.common.model.DownloadView;
import hwarang.artg.community.model.FreeBoardVO;
import hwarang.artg.community.model.FreeImgVO;
import hwarang.artg.mapper.FreeBoardMapper;
import hwarang.artg.mapper.FreeImgMapper;

@Service
public class FreeImgService {
	//파일 저장경로
	public static final String UPLOAD_PATH = "C:\\IMAGE";
	@Autowired
	private FreeBoardMapper freeboardMapper;
	
	@Autowired
	private FreeImgMapper freeimgMapper;
	
		public boolean freeboardRegister(FreeImgVO freeImg,List<MultipartFile> fileList) {
			if(freeimgMapper.insertFile(freeImg)>0) {
				return true;
			}
			return false;
		}
		
			public boolean freeBoardModify(FreeImgVO freeImg) {
			if(freeimgMapper.updateFile(freeImg)>0) {
					return true;
			}
			return false;
		}
		public boolean freeImgRemoveByRNum(int num) {
			if(freeimgMapper.deleteFileByFNum(num) > 0) {
				return true;
			}
			return false;
		}
		public boolean freeImgRemove(String uuid) {
			if(freeimgMapper.deleteFile(uuid)>0) {
				System.out.println("삭제되었습니다");
				return true;
			}
			return false;
		}
		public FreeImgVO freeImgGetOne(String uuid) {
			return freeimgMapper.selectFile(uuid);
		}
		public List<FreeImgVO> freeImgGetAll() {
			return freeimgMapper.selectAllFiles();
		}
		public List<FreeImgVO> freeImgGetByFNum(int num){
			return freeimgMapper.selectFilesByFNum(num);
		}
}
