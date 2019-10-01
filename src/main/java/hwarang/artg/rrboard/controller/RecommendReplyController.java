package hwarang.artg.rrboard.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import hwarang.artg.member.service.MemberService;
import hwarang.artg.rrboard.model.RecommendReplyVO;
import hwarang.artg.rrboard.model.ReviewReplyVO;
import hwarang.artg.rrboard.service.RecommendReplyService;
import hwarang.artg.rrboard.service.ReviewReplyService;

@Controller
@RequestMapping("/rreply")
public class RecommendReplyController {
	@Autowired
	private RecommendReplyService service;

	@ResponseBody
	@RequestMapping("/rwrite")
	public boolean showRwrite(String member_id,int recomm_num,String rcontent) {
		RecommendReplyVO rr = new RecommendReplyVO();
		rr.setMember_id(member_id);
		rr.setRecomm_num(recomm_num);
		rr.setRecomm_reply_content(rcontent);
		return service.recommendreplyRegister(rr);
	}
	@ResponseBody
	@RequestMapping("/replyView")
	public List<RecommendReplyVO> showReplyView(int num) {
		List<RecommendReplyVO> replyList = service.recommendreplyGetAll(num);
		return replyList;
	}
	@ResponseBody
	@RequestMapping("/rmodify")
	public boolean showRmodify(int num,String content) {
		RecommendReplyVO rr = service.recommendreplyGetOne(num);
		rr.setRecomm_reply_content(content);
		service.recommendreplyModify(rr);
		return true;
	}
	@ResponseBody
	@RequestMapping("/rdelete")
	public boolean showRdelete(int num){
		service.recommendreplyRemove(num);
		return true;
	}
}
