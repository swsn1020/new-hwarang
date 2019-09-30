package hwarang.artg.funding.service;

import java.util.List;

import org.springframework.dao.DataAccessException;

import hwarang.artg.funding.model.CrowdfundingVO;
import hwarang.artg.funding.model.OrderVO;
import hwarang.artg.mapper.FundingOrderMapper;


public interface FundingOrderService {
	public OrderVO select(int order_seq_num);
}
