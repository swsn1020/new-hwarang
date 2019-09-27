package hwarang.artg.mapper;

import java.util.List;

import hwarang.artg.manager.model.MessageVO;

public interface MessageMapper {
	public int insertMessage(MessageVO message);
	public int updateMessage(MessageVO message);
	public int deleteMessage(int num);
	public MessageVO selectMessage(int num);
	public List<MessageVO> selectAllMessages();
}
