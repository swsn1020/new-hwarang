package hwarang.artg.funding.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.funding.model.CrowdfundingVO;
import hwarang.artg.mapper.CrowdfundingMapper;

/*
 * 삽입 : memberRegister
수정 : memberModify
삭제 :memberRemove
개체하나선택 : memberGetOne
모든개체선택 : memberGetAll
페이징처리후개체선택 : memberGetListByPaging
비밀번호 확인 : memberCheckPw
 * */

public interface CrowdfundingService {
	
	public void register(CrowdfundingVO funding);
    public CrowdfundingVO get(int funding_num);
    public boolean modify(CrowdfundingVO funding);
    public boolean remove(int funding_num);
    public List<CrowdfundingVO> getList(CriteriaDTO cri);
    public int getTotal(CriteriaDTO cri);
    public CrowdfundingVO payment(int funding_num);
}
