package hwarang.artg.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.community.model.OrderSellerVO;
import hwarang.artg.mapper.OrderSellerMapper;

@Service
public class OrderSellerService {
	@Autowired
	private OrderSellerMapper ordersellerMapper;
	
	public boolean ordersellerRegister(OrderSellerVO orderseller) {
		if(ordersellerMapper.insertOrder(orderseller)>0) {
			return true;
		}
		return false;
	}
	public boolean ordersellerModify(OrderSellerVO orderseller) {
		if(ordersellerMapper.updateOrder(orderseller)>0) {
			return true;
		}
		return false;
	}
	public boolean ordersellerRemove(int num) {
		if(ordersellerMapper.delete(num)>0){
			return true;
		}
		return false;
	}
	public List<OrderSellerVO> ordersellerGetAll(){
		return ordersellerMapper.selectAll();
	}
	public OrderSellerVO ordersellerGetOne(int num) {
		return ordersellerMapper.selectOne(num);
	}
}
