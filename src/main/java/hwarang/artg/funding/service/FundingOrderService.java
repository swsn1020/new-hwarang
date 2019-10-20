package hwarang.artg.funding.service;

import java.util.List;

import hwarang.artg.funding.model.OrderVO;

public interface FundingOrderService {
	public OrderVO select(int order_seq_num);
	public int insertOrder(OrderVO order);
	public List<OrderVO> selectAll();
}
