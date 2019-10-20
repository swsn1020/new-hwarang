package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.funding.model.OrderVO;


public interface FundingOrderMapper {
	public OrderVO selectOne(int order_seq_num);
	public int insertOrder(OrderVO order);
	public List<OrderVO> selectAll();
}
