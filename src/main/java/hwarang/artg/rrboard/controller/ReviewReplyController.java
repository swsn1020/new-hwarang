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
	@Autowired
	private MemberService Mservice;
	
	@ResponseBody
	@RequestMapping("/rwrite")
	public boolean showRRegister(String member_id,int review_num,String rcontent) {
		ReviewReplyVO rr = new ReviewReplyVO();
		rr.setMember_id(member_id);
		rr.setReview_num(review_num);
		rr.setReview_reply_content(rcontent);
		return service.reviewreplyRegister(rr);
	}
	@ResponseBody
	@RequestMapping("/replyView")
	public List<ReviewReplyVO> showReplyView(int num) {
		List<ReviewReplyVO> replyList = service.reviewreplyGetAll(num);
		System.out.println(replyList);
		return replyList;
	}
	@ResponseBody
	@RequestMapping("/rmodify")
	public boolean showRmodify(int num,String id,String pw,String content) {
		ReviewReplyVO rr = service.reviewreplyGetOne(num);
		if(id.equals(rr.getMember_id())) {
			if(Mservice.memberCheckPw(id, pw)) {
				rr.setReview_reply_content(content);
				service.reviewreplyModify(rr);
				return true;
			}
		}
		return false;
	}
	@ResponseBody
	@RequestMapping("/rdelete")
	public boolean showRdelete(int num2,String id2,String pw2){
		ReviewReplyVO rr = service.reviewreplyGetOne(num2);
		if(id2.equals(rr.getMember_id())) {
			if(Mservice.memberCheckPw(id2, pw2)) {
				service.reviewreplyRemove(num2);
				return true;
			}
		}
		return false;
	}
}
