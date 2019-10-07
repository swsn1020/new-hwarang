package hwarang.artg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.manager.model.BlockStatusVO;

public interface BlockStatusMapper {
	public int insertBlock(BlockStatusVO block);
	public int updateBlock(BlockStatusVO block);
	//응답 수정
	public int updateReply(@Param("reply")String reply, @Param("num")int num);
	public int deleteBlock(int num);
	public BlockStatusVO selectBlock(int num);
	//신고당한 아이디 
	public List<BlockStatusVO> selectAllBlocksByBId(String blockMemId);
	//내 아이디로 신고한 게시물
	public List<BlockStatusVO> selectAllBlocksById(String memId);
	//전체 신고사항 보기
	public List<BlockStatusVO> selectAllBlocks();
	
	//전체 신고수 (매니저)
	public List<BlockStatusVO> getListWithPaging(CriteriaDTO cri);
	public int getTotalCount();
	
	//페이징처리 게시글 조회
	public List<BlockStatusVO> getPagingListById(@Param("cri")CriteriaDTO cri, @Param("memId")String memId);
	//사용자아이디로 신고한 게시글 조회
	public int getTotalCountById(String memId);
	
	//최근 신고접수 불러오기(날짜 정렬)
	public List<BlockStatusVO> getListByRegDate();
	
	//미확인 차단 수(manager sidebar)
	public int getCountNotChecked();

}
