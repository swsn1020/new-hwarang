package hwarang.artg.exhibition.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.ExhibitionMentionPageDTO;
import hwarang.artg.exhibition.model.ExhibitionMentionVO;
import hwarang.artg.mapper.ExhibitionMentionMapper;

@Service
public class ExhibitionMentionService {
	@Autowired
	ExhibitionMentionMapper mapper;
	
	public boolean insert(ExhibitionMentionVO vo) {
		return mapper.insert(vo)==1;		
	}
	public boolean update(ExhibitionMentionVO vo) {
		return mapper.update(vo)==1;
	}
	public boolean delete(int mention_no) {
		return mapper.delete(mention_no)==1;
	}
	public ExhibitionMentionVO select(int mention_no) {
		return mapper.select(mention_no);
	}
	public List<ExhibitionMentionVO> selectAll(){
		return mapper.selectAll();
	}
	public ExhibitionMentionPageDTO selectListBySeq(CriteriaDTO cri, int exh_seq){
		return new ExhibitionMentionPageDTO(mapper.getTotalCount(exh_seq),mapper.selectListBySeq(cri,exh_seq));
	}
	public int getTotalCount(int exh_seq) {
		return mapper.getTotalCount(exh_seq);
	}
	
	public int getMentionStatus(String member_id, int exh_seq) {
		return mapper.getMentionStatus(member_id,exh_seq);
	}
}
