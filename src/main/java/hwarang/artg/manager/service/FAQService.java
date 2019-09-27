package hwarang.artg.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.manager.model.FAQVO;
import hwarang.artg.manager.model.NoticeVO;
import hwarang.artg.mapper.FAQMapper;

@Service
public class FAQService {
	@Autowired
	private FAQMapper dao;
	
	public boolean faqRegister(FAQVO faq) {
		if(dao.insertFAQ(faq) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean faqModify(FAQVO faq) {
		if(dao.updateFAQ(faq) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean faqRemove(int num) {
		if(dao.deleteFAQ(num) > 0) {
			return true;
		}
		return false;
	}
	
	public FAQVO faqGetOne(int num) {
		return dao.selectFAQ(num);
	}
	
	public List<FAQVO> fagGetAll(){
		return dao.selectAllFAQs();
	}
	
	//페이징 처리한 list
	public List<FAQVO> pagingList(CriteriaDTO cri){
		return dao.getListWithPaging(cri);
	}
	
	public int getTotalCount(CriteriaDTO cri) {
		return dao.getTotalCount(cri);
	}

}
