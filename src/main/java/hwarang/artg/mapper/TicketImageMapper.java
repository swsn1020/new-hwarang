package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.community.model.TicketImageVO;

public interface TicketImageMapper {
	public String insertImg(TicketImageVO ticketimg);
	public String updateImg(TicketImageVO ticketimg);
	public String deleteImg(String ticketuuid);
	public List<TicketImageVO> selectAll();
	public TicketImageVO selectOne(String ticketuuid);
}
