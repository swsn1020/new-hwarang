package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.community.model.OrderSellerVO;

public interface OrderSellerMapper {
	public int insertOrder(OrderSellerVO orderseller);
	public int updateOrder(OrderSellerVO orderseller);
	public int delete(int num);
	public OrderSellerVO selectOne(int num);
	public List<OrderSellerVO> selectAll(); 
}
