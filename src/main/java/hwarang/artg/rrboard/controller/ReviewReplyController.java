package hwarang.artg.rrboard.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import hwarang.artg.member.model.MemberVO;
import hwarang.artg.member.service.MemberService;
import hwarang.artg.rrboard.model.ReviewReplyVO;
import hwarang.artg.rrboard.service.ReviewReplyService;

@Controller
@RequestMapping("/reply")
public class ReviewReplyController {
	@Autowired
	private ReviewReplyService service;
	
	@ResponseBody
	@RequestMapping("/rwrite")
	public boolean showRwrite(String member_id,int num,String rcontent) {
		ReviewReplyVO rr = new ReviewReplyVO();
		rr.setMember_id(member_id);
		rr.setReview_num(num);
		rr.setReview_reply_content(rcontent);
		return service.reviewreplyRegister(rr);
	}
	@ResponseBody
	@RequestMapping("/replyView")
	public List<ReviewReplyVO> showReplyView(int num) {
		List<ReviewReplyVO> replyList = service.reviewreplyGetAll(num);
		return replyList;
	}
	@ResponseBody
	@RequestMapping("/rmodify")
	public boolean showRmodify(int num,String content) {
		ReviewReplyVO rr = service.reviewreplyGetOne(num);
		rr.setReview_reply_content(content);
		service.reviewreplyModify(rr);
		return true;
	}
	@ResponseBody
	@RequestMapping("/rdelete")
	public boolean showRdelete(int num){
		service.reviewreplyRemove(num);
		return true;
	}
}
