package hwarang.artg.community.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import hwarang.artg.community.model.FreeReplyVO;
import hwarang.artg.community.service.FreeBoardService;
import hwarang.artg.community.service.FreeReplyService;

@RestController
@RequestMapping("/reply")
public class ReplyController {
	@Autowired
	private FreeReplyService freereplyservice;
	
	
	@ResponseBody
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public boolean registerfreeReply(FreeReplyVO freereply) {
		return freereplyservice.freereplyRegister(freereply);
	}
	@ResponseBody
	@RequestMapping(value = "/modifyReply", method = {RequestMethod.POST})
	public boolean modifyfreeReply(FreeReplyVO freereply) {
		return freereplyservice.freereplyModify(freereply);
	}
	@ResponseBody
	@RequestMapping(value = "/removeReply", method = RequestMethod.POST)
	public boolean removefreeReply(int num,HttpSession session,FreeReplyVO freereply) {
		return freereplyservice.freereplyRemove(num);
	}
	@ResponseBody
	@RequestMapping(value = "/all/{fboardNum}", method = RequestMethod.GET)
	public List<FreeReplyVO> getfreeReplyList(@PathVariable("fboardNum") int fboardNum) {
		return freereplyservice.freeReplyByBoard(fboardNum);
	}
}
