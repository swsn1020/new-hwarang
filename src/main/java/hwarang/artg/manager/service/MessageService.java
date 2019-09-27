package hwarang.artg.manager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.manager.model.MessageVO;
import hwarang.artg.mapper.MessageMapper;

@Service
public class MessageService {
	@Autowired
	private MessageMapper dao;
	
	public boolean msgRegister(MessageVO message) {
		if(dao.insertMessage(message) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean msgModify(MessageVO message) {
		if(dao.updateMessage(message) > 0) {
			return true;
		}
		return false;
	}
	
	public boolean msgRemove(int num) {
		if(dao.deleteMessage(num) > 0) {
			return true;
		}
		return false;
	}
	
	public MessageVO msgGetOne(int num) {
		return dao.selectMessage(num);
	}
	
	public List<MessageVO> qnaGetAll() {
		return dao.selectAllMessages();
	}

}
