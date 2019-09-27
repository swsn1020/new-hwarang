package hwarang.artg.exhibition.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.FavoriteMarkVO;
import hwarang.artg.mapper.FavoriteMarkMapper;
import lombok.Setter;

@Service
public class FavoriteMarkService {
	@Setter(onMethod_ = { @Autowired })
	FavoriteMarkMapper mapper;
	
	public boolean addFavorite(FavoriteMarkVO fav) {
		if(mapper.insert(fav)>0) {
			return true;
		}
		return false;
	}
	
	public boolean modifyFavorite(FavoriteMarkVO fav) {
		if(mapper.update(fav)>0) {
			return true;
		}
		return false;
	}
	
	public boolean removeFavorite(FavoriteMarkVO fav) {
		if(mapper.delete(fav)>0) {
			return true;
		}
		return false;
	}
	
	public FavoriteMarkVO getOne(FavoriteMarkVO fav) {
		return mapper.selectOne(fav);
	}
	
	public List<FavoriteMarkVO> getAll(){
		return mapper.selectAll();
	}
	
	public List<FavoriteMarkVO> getFavoriteList(FavoriteMarkVO fav) {
		return mapper.selectFavorite(fav);
	}
	
	public List<FavoriteMarkVO> paigingFavoriteList(FavoriteMarkVO fav, CriteriaDTO cri) {
		return mapper.selectFavoriteWithPaging(fav, cri);
	}

	public List<String> getGroup(String member_id) {
		return mapper.getGroup(member_id);
	}
	
	public int getSeq(FavoriteMarkVO fav) {
		return mapper.getSeq(fav);
	}
	
	public int getTotalCount(String favorite_group) {
		return mapper.getTotalCount(favorite_group);
	}
	public int getTotalCountById(String member_id) {
		return mapper.getTotalCountById(member_id);
	}
	
	
}
