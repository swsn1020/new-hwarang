package hwarang.artg.mapper;

import hwarang.artg.funding.model.OrderVO;


public interface FundingOrderMapper {
	public OrderVO getOne(int order_seq_num);
	//public List<OrderVO> selectAll(@Param("order_seq_num")int order_seq_num, @Param("member_id")String member_id);
}
