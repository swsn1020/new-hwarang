package hwarang.artg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.FavoriteMarkVO;

public interface FavoriteMarkMapper {
	public int insert(FavoriteMarkVO fav);
	public int update(FavoriteMarkVO fav);
	public int delete(FavoriteMarkVO fav);
	public FavoriteMarkVO selectOne(FavoriteMarkVO fav);
	public List<FavoriteMarkVO> selectAll();
	public List<FavoriteMarkVO> selectFavorite(FavoriteMarkVO fav);
	public List<FavoriteMarkVO> selectFavoriteWithPaging(@Param("fav")FavoriteMarkVO fav, @Param("cri")CriteriaDTO cri);
	public List<String> getGroup(String member_id);
	public int getSeq(FavoriteMarkVO fav);
	public int getTotalCount(String favorite_group);
	public int getTotalCountById(@Param("favorite_group")String favorite_group, @Param("member_id")String member_id);

}
