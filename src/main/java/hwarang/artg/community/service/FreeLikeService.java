package hwarang.artg.community.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.community.model.FreeLikeVO;
import hwarang.artg.exhibition.model.ExhLikeVO;
import hwarang.artg.mapper.FreeBoardLikeMapper;

@Service
public class FreeLikeService {
	@Autowired
	private FreeBoardLikeMapper mapper;
	
	public boolean addLikeStatus(FreeLikeVO like) {
		if(mapper.insert(like)>0) {
			return true;
		}
		return false;
	}
	
	public boolean removeLikeStatus(FreeLikeVO like) {
		if(mapper.delete(like)>0) {
			return true;
		}
		return false;
	}
	
	public boolean modifyLikeStatus(FreeLikeVO like) {
		if(mapper.update(like)>0) {
			return true;
		}
		return false;
	}
	
}
