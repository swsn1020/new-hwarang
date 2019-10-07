package hwarang.artg.member.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.security.Principal;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hwarang.artg.common.model.EmailDTO;
import hwarang.artg.common.model.EmailSender;
import hwarang.artg.community.service.FreeBoardService;
import hwarang.artg.manager.service.ReportService;
import hwarang.artg.member.model.MemberAuthVO;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.member.service.KakaoService;
import hwarang.artg.member.service.MemberService;
import hwarang.artg.member.service.NaverService;
import hwarang.artg.member.service.PointService;
import hwarang.artg.rrboard.service.RecommendBoardService;
import hwarang.artg.rrboard.service.ReviewBoardService;


@RequestMapping("/member")
@Controller
public class MemberController {
	@Autowired
	private EmailDTO email;
	@Autowired
	private EmailSender emailSender;
	@Autowired
	private MemberService service;
	@Autowired
	private NaverService nservice;
	@Autowired
	private KakaoService kservice;
	@Autowired
	private PointService pservice;
	@Autowired
	private ReviewBoardService reviewservice;
	@Autowired
	private RecommendBoardService recommendservice;
	@Autowired
	private PasswordEncoder pwencoder;
	@Autowired
	private FreeBoardService freeservice;
	@Autowired
	private ReportService reportservice;
	
	
	@Autowired
	@Qualifier("authenticationManager")
	private AuthenticationManager authManager;
//
//	@Autowired
//	@Qualifier("customAuthenticationProvider")
//	private AuthenticationProvider authenticationProvider;
	

	@RequestMapping("/loginForm")
	public String showLoginForm(Model model,HttpSession session) {
		String state = nservice.getState();
		session.setAttribute("state", state);
		model.addAttribute("url", nservice.getURL(state));
		return "/member/loginForm";
	}
	
	@RequestMapping("/login")
	public String showLogin(String member_id,String member_password,Model model) {
		MemberVO member = service.memberGetOne(member_id);
		if(member!=null) {
			if(member_password.equals(member.getMember_password())) {
				return "redirect:/index?result=success&id="+member_id;
			}
		}
		model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력하셨습니다.");
		model.addAttribute("url", "loginForm");
		return "/member/result";			
	}
	
	@RequestMapping("/naverLogin")
	public String showMain(Model model,HttpSession session,HttpServletRequest request) {
		
		
		
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		Map<String, Object> userInfo = nservice.getUserInfo(code, state);
		
		System.out.println("userInfo:"+userInfo);
		//id는 네이버아이디마다 고유하게 발급되는 값	
		
		String id = "(naver)";
		id += (String) userInfo.get("email");

		MemberVO member = service.memberGetOne(id);
		String pw= (String) userInfo.get("id");
		
		if(member == null) {
			MemberVO vo  =new MemberVO();
			String name = (String) userInfo.get("name");
//			pw = (String) userInfo.get("id");
			String email = (String) userInfo.get("email");			
			String gender2 = (String) userInfo.get("gender");
			int gender = 00;
			if(gender2 != null) {
				if(gender2.equals("F")) {
					gender = 1;//여자
				}else if(gender2.equals("M")) {
					gender = 0;//남자
				}else if(gender2.equals("U")) {
					gender = 3;//확인불가
				}				
			}
			if(name == null || email == null || gender2 == null) {
				model.addAttribute("msg", "로그인을 하기 위해서 정보제공을 동의해주세요.");
				model.addAttribute("url", "loginForm");
				return "/member/result";
			}else {				
				//주소,핸드폰 나중에 개인정보수정 및 결제시 필수로 만들기
				List<MemberAuthVO> authList = new ArrayList<MemberAuthVO>();
				authList.add(new MemberAuthVO(id, "ROLE_USER"));
				vo.setAuthList(authList);
				vo.setMember_name(name);
				vo.setMember_id(id);
				vo.setMember_password(pwencoder.encode(pw));
				vo.setMember_email(email);
				vo.setMember_gender(gender);
				vo.setMember_phonenum(" ");
				vo.setMember_address(" ");
				service.memberRegister(vo);				
			}
		} else {
			System.out.println("네이버 사용자 있음");
		}
		
//		System.out.println("match: " + pwencoder.matches(pw, member.getMember_password()));
		
		List<GrantedAuthority> authList =new ArrayList<GrantedAuthority>();
		authList.add(()->"ROLE_USER"); 
		 UsernamePasswordAuthenticationToken authReq
	      = new UsernamePasswordAuthenticationToken(id, pw,authList);

		try {			
			Authentication auth = authManager.authenticate(authReq);
			SecurityContext sc = SecurityContextHolder.getContext();
			sc.setAuthentication(auth);
			session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, sc);
			session.setAttribute("naverName", userInfo.get("name"));
			session.setAttribute("id", id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		 
		return "redirect:/";
	}

	@ResponseBody
	@RequestMapping("/kakaoLogin")
	public boolean showKakaoLogin(@RequestParam Map<String, Object> params,HttpSession session,HttpServletRequest request) {
//		String password = (String) authentication.getCredentials();
		//Rest Api의 토큰 보안을 위한 시큐리티 설정
//		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken("kakaoLogin", "1234");
//		token.setDetails(new WebAuthenticationDetails(request));
//		Authentication authentication = this.authenticationProvider.authenticate(token);
//		logger.debug("Logging in with [{}]", authentication.getPrincipal());
//		SecurityContextHolder.getContext().setAuthentication(authentication);

		System.out.println("controller /kakaoLogin :" + params);
		String access_token = (String) params.get("access_token");

			//이메일과 성별 제공 동의 확인하기
			String scope = (String) params.get("scope");
			System.out.println("scope:"+scope);
					
			Map<String, Object> userInfo = kservice.getUserInfo(access_token);
			System.out.println("/kakaoLogin : " + userInfo);
			
			String id = "(kakao)"+(String) userInfo.get("email"); 
			MemberVO member = service.memberGetOne(id);
			
			String name = (String) userInfo.get("name");
			String pw = (String) userInfo.get("id");
			
			if (member == null) {
				
				MemberVO vo  =new MemberVO();
				String email = (String) userInfo.get("email");
				String gender2 = (String) userInfo.get("gender");
				int gender = 00;
				if(gender2 != null) {
					if(gender2.equals("male")) {
						gender = 0;
					}else if(gender2.equals("female")) {
						gender = 1;
					}
				}else {
					gender = 3;//확인불가
				}
				vo.setMember_name(name);
				vo.setMember_id(id);
				vo.setMember_password(pwencoder.encode(pw));
				vo.setMember_email(email);
				vo.setMember_gender(gender);
				vo.setMember_phonenum(" ");
				vo.setMember_address(" ");
				List<MemberAuthVO> authList = new ArrayList<MemberAuthVO>();
				authList.add(new MemberAuthVO(id, "ROLE_USER"));
				vo.setAuthList(authList);
				boolean result = service.memberRegister(vo);
				if(result) {
					session.setAttribute("kakaoName", name);
				}
				
			} else {
				System.out.println("카카오톡 사용자 있음");
				session.setAttribute("kakaoName", name);
			}
			
			
			List<GrantedAuthority> authList =new ArrayList<GrantedAuthority>();
			authList.add(()->"ROLE_USER"); 
			UsernamePasswordAuthenticationToken authReq
		     = new UsernamePasswordAuthenticationToken(id,pw,authList);
			try {
				Authentication auth = authManager.authenticate(authReq);
				SecurityContext sc = SecurityContextHolder.getContext();
				sc.setAuthentication(auth);
				session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, sc);
				session.setAttribute("naverName", userInfo.get("name"));
			
			}catch (Exception e) {
				e.printStackTrace();
			}
			return true;


	}
	
	
	@RequestMapping("/joinForm")
	public String showJoinForm() {
		return "/member/joinForm";
	}
	
	
	
	@ResponseBody
	@RequestMapping("/checkId")
	public String showCheckId(String id){
		System.out.println("data:"+id);
		MemberVO member = service.memberGetOne(id);
		if(id.equals("") || id.equals(null)) {
			return "no";
		}else {
			if(member==null) {
				return "true";
			}else {
				return "false";
			}
		}
	}
	@RequestMapping("/jusoPopup")
	public String showAddressForm() {
		return "/member/jusoPopup";
	}
	@RequestMapping("/join")
	public String showJoin(String id,String password,String name,int gender,String tel1,String tel2,String tel3,
			String email1,String email2,String zipNo,String roadAddrPart1,String addrDetail,Model model,String auth) {
		MemberVO member = new MemberVO();
		//멤버권한 넣기
		List<MemberAuthVO> authList = new ArrayList<MemberAuthVO>();
		authList.add(new MemberAuthVO(id, "ROLE_USER"));
		member.setAuthList(authList);
		//권한제외 멤버정보 넣기
		member.setMember_id(id);
		member.setMember_password(pwencoder.encode(password));
		member.setMember_name(name);
		member.setMember_gender(gender); //0:남자, 1:여자
		String phoneNum = tel1+"-"+tel2+"-"+tel3;
		member.setMember_phonenum(phoneNum);
		String email = email1+"@"+email2;
		member.setMember_email(email);
		String address = "["+zipNo+"]"+roadAddrPart1+","+addrDetail;
		member.setMember_address(address);
		boolean result = service.memberRegister(member);
		String msg = "다시 입력해주세요.";
		String url = "joinForm";
		if(result) {
			msg = "가입해주셔서 감사합니다.";
			url = "loginForm";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		System.out.println(member);
		return "/member/result";
	}

	@RequestMapping("/findidForm")
	public String showFindIdForm() {
		return "/member/findidForm";
	}

	@RequestMapping("/findId")
	public String showFindId(String member_name,String member_email,Model model) {
		MemberVO member = service.memberFindId(member_name);
		String url = "findidForm";
		String msg = "입력하신 정보로 가입 된 회원 아이디는 존재하지 않습니다.";
		if(member != null) {
			if(member_email.equals(member.getMember_email())) {
				model.addAttribute("member_id", member.getMember_id());
				return "redirect:/member/findidForm?findResult=success";
			}
		}
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		return "/member/result";			
	}
	@RequestMapping("/findpwForm")
	public String showFindpwForm() {
		return "/member/findpwForm";
	}
	
	@RequestMapping("/findPw")
	public String showFindpw(String member_id,String member_name,String member_email,Model model) throws Exception {
		MemberVO member = service.memberGetOne(member_id);
		String msg = "일치하는 정보가 없습니다.";
		String url = "findpwForm";
		if(member != null) {
			if(member_name.equals(member.getMember_name())) {
				if(member_email.equals(member.getMember_email())) {
					StringBuffer randomPw = new StringBuffer();
					Random random = new Random();
					for (int i = 0; i < 10; i++) {
					    int rIndex = random.nextInt(3);
					    switch (rIndex) {
					    case 0:
					        // a-z
					    	randomPw.append((char) ((int) (random.nextInt(26)) + 97));
					        break;
					    case 1:
					        // A-Z
					    	randomPw.append((char) ((int) (random.nextInt(26)) + 65));
					        break;
					    case 2:
					        // 0-9
					    	randomPw.append((random.nextInt(10)));
					        break;
					    }
					}
					String password = randomPw.toString();
					member.setMember_password(password);
					service.memberPwModify(member);
					email.setContent("임시 비밀번호는 "+ randomPw +" 입니다.");
					email.setReceiver(member.getMember_email());
					email.setSubject("화랑 임시 비밀번호를 안내해드립니다.");
					emailSender.SendEmail(email);
					msg = "가입 시 등록한 메일주소 "+member.getMember_email()+" 비밀번호가 발송되었습니다.";
					url = "loginForm";
				}
			}
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "/member/result";
	}
	@RequestMapping("/myPage")
	public String showMyPage(Principal principa,Model model) {
		String id = principa.getName();
		model.addAttribute("member", service.memberGetOne(id));
		model.addAttribute("points", pservice.pointGetOne(id));
		model.addAttribute("review", reviewservice.reviewboardGetIdAll(id));
		model.addAttribute("recommend", recommendservice.recommendboardGetAll_Id(id));
		model.addAttribute("free", freeservice.freeboardGetAllId(id));
		model.addAttribute("id", id);
		return "/member/myPage";
	}
	
	@RequestMapping("/modifyForm")
	public String showModifyForm(String id,Model model) {
		MemberVO member = service.memberGetOne(id);
		model.addAttribute("member", member);
		return "/member/modifyForm";
	}
	@RequestMapping("/modify")
	public String showModify(String id,String SNSid,String password,String name,String tel1,String tel2,String tel3,
			String email1,String email2,String zipNo,String roadAddrPart1,String addrDetail,Model model){
		if(id.equals("간편 로그인")) {
			MemberVO memberSnS = service.memberGetOne(SNSid);
			memberSnS.setMember_id(SNSid);
			memberSnS.setMember_password(password);
			memberSnS.setMember_phonenum(tel1+"-"+tel2+"-"+tel3);
			memberSnS.setMember_email(email1+"@"+email2);
			memberSnS.setMember_address("["+zipNo+"]"+roadAddrPart1+","+addrDetail);
			service.memberModify(memberSnS);
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("url", "myPage?id="+SNSid);
			return "/member/result";

		}else{
			MemberVO member = service.memberGetOne(id);
			if(!member.getMember_password().equals(password)) {
				model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
				model.addAttribute("url", "modifyForm?id="+id);
				return "/member/result";
			}
			member.setMember_id(id);			
			member.setMember_password(password);
			member.setMember_phonenum(tel1+"-"+tel2+"-"+tel3);
			member.setMember_email(email1+"@"+email2);
			member.setMember_address("["+zipNo+"]"+roadAddrPart1+","+addrDetail);
			service.memberModify(member);
			model.addAttribute("msg", "수정되었습니다.");
			model.addAttribute("url", "myPage?id="+id);
			return "/member/result";
		}
	}
	@RequestMapping("/deleteForm")
	public String showDeleteForm() {	
		return "/member/deleteForm";
	}
	@RequestMapping("/delete")
	public String showDelete(Model model,String member_id,String snsId,HttpSession session) {
		//네이버 회원
		if(member_id.equals("네이버 간편 로그인")) {
			service.memberRemove(snsId);
			model.addAttribute("url", "https://nid.naver.com/user2/help/externalAuth.nhn?lang=ko_KR");
			model.addAttribute("msg", "탈퇴되셨습니다. 네이버 정책상 계정 정보에서 간편 로그인 삭제를 진행해주셔야 완전한 탈퇴가 됩니다.");
			return "/member/result";
		//카카오톡 회원
		}else if(member_id.equals("카카오톡 간편 로그인")) {
			service.memberRemove(snsId);
			String access_token = (String) session.getAttribute("access_token");
			kservice.delete(access_token);
			//카카오톡 api로 탈퇴
			model.addAttribute("url", "/index");
			model.addAttribute("msg", "탈퇴되셨습니다.");
			//session 제거
			return "/member/result";
		//일반 회원
		}else { 
			service.memberRemove(member_id);			
			model.addAttribute("url", "/index");
			model.addAttribute("msg", "탈퇴되셨습니다.");
			return "/member/result";
		}

	}
}





