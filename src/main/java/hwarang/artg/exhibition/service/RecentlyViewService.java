package hwarang.artg.exhibition.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.RecentlyViewVO;
import hwarang.artg.mapper.RecentlyViewMapper;
import lombok.Setter;

@Service
public class RecentlyViewService {
	@Setter(onMethod_= {@Autowired})
	RecentlyViewMapper mapper;
	
	public boolean addRecentlyView(RecentlyViewVO rec) {
		if(mapper.insert(rec)>0) {
			return true;
		}
		return false;
	}
	
	public boolean removeRecentlyView(RecentlyViewVO rec) {
		if(mapper.delete(rec)>0) {
			return true;
		}
		return false;
	}
	
	public RecentlyViewVO getOne(RecentlyViewVO rec) {
		return mapper.select(rec);
	}
	
	public int getTotalCount(String member_id) {
		return mapper.getTotalCount(member_id);
	}
	
	public List<RecentlyViewVO> getList(CriteriaDTO cri,String member_id){
		return mapper.selectList(cri, member_id);
	}
	
	public boolean getIsViewd(RecentlyViewVO rec) {
		return mapper.isViewd(rec)>0;
	}
	
}
