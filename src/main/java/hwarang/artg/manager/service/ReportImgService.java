package hwarang.artg.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.manager.model.ReportImgVO;
import hwarang.artg.mapper.ReportImgMapper;

@Service
public class ReportImgService {
	@Autowired
	private ReportImgMapper dao;
	
	public boolean reportImgRegister(ReportImgVO reportImg) {
		if(dao.insertFile(reportImg) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean reportImgModify(ReportImgVO reportImg) {
		if(dao.updateFile(reportImg) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean reportImgRemove(String uuid) {
		if(dao.deleteFile(uuid) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean reportImgRemoveByRNum(int num) {
		if(dao.deleteFileByRNum(num) > 0) {
			return true;
		}
		return false;
	}
	
	public ReportImgVO reportImgGetOne(String uuid) {
		return dao.selectFile(uuid);
	}
	
	public List<ReportImgVO> reportImgGetByRNum(int num){
		return dao.selectFilesByRNum(num);
	}
	
	public List<ReportImgVO> reportImgGetAll() {
		return dao.selectAllFiles();
	}

}
