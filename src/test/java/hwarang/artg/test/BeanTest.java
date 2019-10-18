package hwarang.artg.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import hwarang.artg.mapper.ManagerMainMapper;
import hwarang.artg.mapper.MemberAuthMapper;
import hwarang.artg.mapper.MemberMapper;
import hwarang.artg.mapper.PointMapper;
import hwarang.artg.mapper.RecommendBoardMapper;
import hwarang.artg.mapper.RecommendImgMapper;
import hwarang.artg.mapper.RecommendReplyMapper;
import hwarang.artg.mapper.ReviewBoardMapper;
import hwarang.artg.mapper.ReviewImgMapper;
import hwarang.artg.mapper.ReviewReplyMapper;
import hwarang.artg.mapper.TasteMapper;
import hwarang.artg.member.model.MemberAuthVO;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.member.model.PointVO;
import hwarang.artg.member.model.TasteVO;
import hwarang.artg.member.service.MemberAuthService;
import hwarang.artg.member.service.MemberService;
import hwarang.artg.member.service.PointService;
import hwarang.artg.member.service.TasteService;
import hwarang.artg.rrboard.model.RecommendBoardVO;
import hwarang.artg.rrboard.model.RecommendImgVO;
import hwarang.artg.rrboard.model.RecommendReplyVO;
import hwarang.artg.rrboard.model.ReviewBoardVO;
import hwarang.artg.rrboard.model.ReviewImgVO;
import hwarang.artg.rrboard.model.ReviewReplyVO;
import hwarang.artg.rrboard.service.RecommendBoardService;
import hwarang.artg.rrboard.service.RecommendImgService;
import hwarang.artg.rrboard.service.RecommendReplyService;
import hwarang.artg.rrboard.service.ReviewBoardService;
import hwarang.artg.rrboard.service.ReviewImgService;
import hwarang.artg.rrboard.service.ReviewReplyService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BeanTest {
//	@Autowired
//	private MemberMapper dao;
//	@Autowired
//	private MemberService service;
//	@Autowired
//	private MemberAuthMapper dao;
//	@Autowired
//	private MemberAuthService service;
//	private TasteMapper dao;
//	private TasteService s;
//	private PointMapper dao;
//	private PointService s;
//	private RecommendBoardMapper dao;
//	private RecommendBoardService s;
//	private RecommendImgMapper dao;
//	private RecommendImgService s;
//	private RecommendReplyMapper dao;
//	private RecommendReplyService s;
//	private ReviewBoardMapper dao;
//	private ReviewBoardService s;
//	private ReviewImgMapper dao;
//	private ReviewImgService s;
//	private ReviewReplyMapper dao;
//	private ReviewReplyService s;
	
	@Autowired
	private ManagerMainMapper dao;
//	private MemberService ms;
//	private MemberAuthService memas;
	
	
	
	@Test
	public void test() {
		System.out.println(dao.getTotals().get("TOTREP"));
		
//		System.out.println(memas.memberauthGetOne("id1"));
//		s.pointGetRegister(1, 100, "포인트사용", "bbb");
		
		
//		System.out.println(s.pointRemove(24));
//		System.out.println(s.pointGetOne(24));
//		System.out.println(s.pointGetAll());
//		System.out.println(dao.deletePoint(25));
//		System.out.println(dao.selectPoint(25));
//		System.out.println(dao.selectAllPoint());
//		System.out.println(s.tasteRemove("tastename4"));
//		System.out.println(s.tasteGetOne("tastename4"));
//		System.out.println(s.tasteGetAll());
//		System.out.println(dao.deleteTaste("tastename5"));
//		System.out.println(dao.selectTaste("tastename1"));
//		System.out.println(dao.selectAllTaste());
//		System.out.println(s.reviewreplyRemove(4));
//		System.out.println(s.reviewreplyGetOne(4));
//		System.out.println(s.reviewreplyGetAll());
//		dao.deleteReview_Reply(5);
//		System.out.println(dao.selectReview_Reply(5));
//		System.out.println(dao.selectAllReview_Reply());
//		System.out.println(s.reviewimgNumRemove(4));
//		System.out.println(s.reviewimgGetAll());
//		System.out.println(s.reviewimgGetOne(4));
//		System.out.println(dao.deleteReview_Img_num(5));
//		System.out.println(dao.selectReview_Img(5));
//		System.out.println(dao.selectAllReview_Img());
//		System.out.println(s.reviewboardGetOne(1));
//		System.out.println(s.reviewboardRemove(4));
//		System.out.println(s.reviewboardRemove(4));
//		System.out.println(s.reviewboardGetAll());
//		dao.deleteReview_Board(5);
//		System.out.println(dao.selectAllReview_Board());
//		System.out.println(dao.selectReview_Board(1));
//		System.out.println(s.recommendimgGetAll());
//		System.out.println(s.recommendimgGetOne(3));
//		System.out.println(s.recommendimgNumRemove(4));
//		System.out.println(dao.selectAllRecomm_Img());
//		System.out.println(dao.deleteRecomm_Img_num(5));
//		System.out.println(dao.selectRecomm_Img(4));
//		System.out.println(s.recommendreplyRemove(3));
//		System.out.println(s.recommendreplyGetOne(3));
//		System.out.println(s.recommendreplyGetAll());
//		System.out.println(dao.deleteRecommend_Reply(5));
//		System.out.println(dao.selectRecommend_Reply(4));
//		System.out.println(dao.selectAllRecommend_Reply());
//		System.out.println(dao.deleteRecomm_Img_num(1));
//		System.out.println(s.recommendimgNumRemove(1));
//		System.out.println(s.recommendimgGetAll());
//		System.out.println(s.recommendimgGetOne(1));
//		System.out.println(dao.selectAllRecomm_Img());
//		System.out.println(dao.selectRecomm_Img(1));
//		System.out.println(s.recommendimgGetOne(1));
		
//		System.out.println(s.recommendboardRemove(99));
//		System.out.println(s.recommendboardGetAll());
		
//		System.out.println(service.pointRemove(1));
		
//		PointVO p = new PointVO();
//		p.setMember_id("test1");
//		dao.insertPoint(p);
	
//		System.out.println(service.tasteGetAll());
//		TasteVO t = new TasteVO();
//		t.setMember_id("test");
//		t.setTaste_name("...");
//		dao.insertTaste(t);
//		dao.deleteTaste("...");
//		System.out.println(dao.selectTaste("..."));
		
//		System.out.println(service.memberauthGetAll());
		
//		MemberAuthVO ma = new MemberAuthVO();
//		ma.setMember_id("test1");
//		ma.setMember_auth("usable");
//		dao.insertMember_Auth(ma);
//		System.out.println(dao.selectMember_Auth("test1"));
//		System.out.println(dao.selectAllMember_Auth());
//		dao.deleteMember_Auth("test1");
		
		
//		for(int i=1;i<6;i++) {
//			PointVO p = new PointVO();
//			p.setMember_id("test"+i);
//			dao.insertPoint(p);
			
//			TasteVO t = new TasteVO();
//			t.setMember_id("test1");
//			t.setTaste_name("tastename"+i);
//			dao.insertTaste(t);
			
//			ReviewReplyVO r = new ReviewReplyVO();
//			r.setReview_num(1);
//			r.setMember_id("test"+i);
//			r.setReview_reply_content("testcontent");
//			dao.insertReview_Reply(r);
			
//			ReviewImgVO r = new ReviewImgVO();
//			r.setReview_uuid("test"+i);
//			r.setReview_upload_path("/src/test");
//			r.setReview_filename("testname");
//			dao.insertReview_Img(r);
			
//			ReviewBoardVO r  = new ReviewBoardVO();
//			r.setMember_id("test"+i);
//			r.setReview_title("testtitle"+i);
//			r.setReview_exh_name("testname");
//			r.setReview_content("testcontent");
//			dao.insertReview_Board(r);
			
//			RecommendImgVO ri = new RecommendImgVO();
//			ri.setRecomm_uuid("test"+i);
//			ri.setRecomm_upload_path("/file/tset");
//			ri.setRecomm_filename("testname"+i);
//			dao.insertRecomm_Img(ri);
			
//			RecommendReplyVO rr = new RecommendReplyVO();
//			rr.setRecomm_num(1);
//			rr.setMember_id("test"+i);
//			rr.setRecomm_reply_content("testcontent");
//			dao.insertRecommend_Reply(rr);
			
//			RecommendBoardVO rb = new RecommendBoardVO();
//			rb.setMember_id("test"+i);
//			rb.setRecomm_title("testtitle"+i);
//			rb.setRecomm_content("testing");
//			dao.insertRecommend_Board(rb);
			
//			MemberVO m = new MemberVO();
//			m.setMember_id("test"+i);
//			m.setMember_name("testname"+i);
//			m.setMember_password("1234");
//			m.setMember_email("test"+i+"@test.com");
//			m.setMember_gender(1);
//			m.setMember_phonenum("010-1234-1234");
//			m.setMember_address("강남구 test빌딩");
//			membermapper.insertMember(m);
		}
		
//		System.out.println(membermapper.selectAllMember());
//		service.memberRegister("test200", "testname200", "1234", "test200@test.com", 1, "010-1234-1234", "강남구 test빌딩");
//		System.out.println(service.memberGetOne("test199"));
//		System.out.println(membermapper.selectMember("test199"));
		
//		ms.memberGetOne("id1");
		
//	}
}
