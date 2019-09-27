package hwarang.artg.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.manager.model.QnAImgVO;
import hwarang.artg.mapper.QnAImgMapper;

@Service
public class QnAImgService {
	@Autowired
	private QnAImgMapper dao;
	
	public boolean qnaImgRegister(QnAImgVO qnaImg) {
		if(dao.insertFile(qnaImg) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean qnaImgModify(QnAImgVO qnaImg) {
		if(dao.updateFile(qnaImg) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean qnaImgRemove(String uuid) {
		if(dao.deleteFile(uuid) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean qnaImgRemoveByQNum(int num) {
		if(dao.deleteFileByQNum(num) > 0) {
			return true;
		}
		return false;
	}
	
	public QnAImgVO qnaImgGetOne(String uuid) {
		return dao.selectFile(uuid);
	}
	
	public List<QnAImgVO> qnaImgGetByQNum(int num){
		return dao.selectFilesByQNum(num);
	}
	
	public List<QnAImgVO> qnaImgGetAll() {
		return dao.selectAllFiles();
	}
	
}
