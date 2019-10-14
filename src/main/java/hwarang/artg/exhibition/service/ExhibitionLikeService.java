package hwarang.artg.exhibition.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.exhibition.model.ExhLikeVO;
import hwarang.artg.mapper.ExhibitionLikeMapper;

@Service
public class ExhibitionLikeService {
	@Autowired
	private ExhibitionLikeMapper mapper;
	
	public boolean addLikeStatus(ExhLikeVO like) {
		if(mapper.insert(like)>0) {
			return true;
		}
		return false;
	}
	
	public boolean removeLikeStatus(ExhLikeVO like) {
		if(mapper.delete(like)>0) {
			return true;
		}
		return false;
	}
}
