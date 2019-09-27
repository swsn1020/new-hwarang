package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.rrboard.model.RecommendImgVO;

public interface RecommendImgMapper {
	public int insertRecomm_Img(RecommendImgVO ri);
	public int updateRecomm_Img(RecommendImgVO ri);
	
	public int deleteRecomm_Img_uuid(String recomm_uuid);
	public int deleteRecomm_Img_num(int recomm_num);
	
	public RecommendImgVO selectRecomm_Img(int recomm_num);
	public List<RecommendImgVO> selectAllRecomm_Img();
	
}	
