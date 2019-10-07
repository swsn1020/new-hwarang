package hwarang.artg.mapper;

import java.util.List;
import java.util.Map;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.manager.model.FAQVO;


public interface FAQMapper {
	public int insertFAQ(FAQVO faq);
	public int updateFAQ(FAQVO faq);
	public int deleteFAQ(int num);
	public FAQVO selectFAQ(int num);
	public List<FAQVO> selectAllFAQs();
	
	//MAIN에 띄울 FAQ 리스트
	public List<FAQVO> selectRecentFAQs();
	
	//페이징처리
	public List<FAQVO> getListWithPaging(CriteriaDTO cri);
	public int getTotalCount(CriteriaDTO cri);
	

}
