package hwarang.artg.exhibition.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.ExhibitionReplyVO;
import hwarang.artg.mapper.ExhibitionReplyMapper;
import lombok.Setter;

@Service
public class ExhibitionReplyService {
	@Setter(onMethod_ = { @Autowired })
	private ExhibitionReplyMapper mapper;

	public boolean register(ExhibitionReplyVO vo) {
		if (mapper.insert(vo) > 0) {
				return true;
		}return false;
	}

	public boolean modify(ExhibitionReplyVO vo) {
		if (mapper.update(vo) > 0) {
			return true;
		}
		return false;
	}

	public boolean remove(int reply_num) {
		if (mapper.delete(reply_num) > 0) {
				return true;
		}
		return false;
	}

	public ExhibitionReplyVO get(int reply_num) {
		return mapper.select(reply_num);
	}

	public List<ExhibitionReplyVO> getList(CriteriaDTO cri, int exh_seq) {
		return mapper.getListWithPaging(cri, exh_seq);
	}
}

