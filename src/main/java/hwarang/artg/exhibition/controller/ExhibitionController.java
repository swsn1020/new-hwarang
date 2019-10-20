package hwarang.artg.exhibition.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.common.model.PageDTO;
import hwarang.artg.exhibition.model.ExhLikeVO;
import hwarang.artg.exhibition.model.ExhibitionVO;
import hwarang.artg.exhibition.model.FavoriteMarkVO;
import hwarang.artg.exhibition.model.NaverBlogDTO;
import hwarang.artg.exhibition.model.RecentlyViewVO;
import hwarang.artg.exhibition.service.ExhibitionLikeService;
import hwarang.artg.exhibition.service.ExhibitionListService;
import hwarang.artg.exhibition.service.FavoriteMarkService;
import hwarang.artg.exhibition.service.NaverBlogService;
import hwarang.artg.exhibition.service.RecentlyViewService;
import hwarang.artg.rrboard.model.ReviewBoardVO;
import hwarang.artg.rrboard.service.ReviewBoardService;

@Controller
@RequestMapping("/exhibition")
public class ExhibitionController {
	@Autowired
	ExhibitionListService service;
	@Autowired
	FavoriteMarkService fService;
	@Autowired
	RecentlyViewService rService;
	@Autowired
	NaverBlogService blogservice;
	@Autowired
	ExhibitionLikeService lService;
	@Autowired
	ReviewBoardService reviewService;
	//공연리스트 불러오기
	@GetMapping("")
	public String exhibitionShow(Model model, CriteriaDTO cri, ExhibitionVO exh) throws Exception {
		if(cri.getAmount()==10 || cri.getAmount()==0) {
			cri.setAmount(12);
		}
		if(exh.getExh_endDate()=="") {
			exh.setExh_endDate(null);
		}
		if(exh.getExh_startDate() == "") {
			exh.setExh_startDate(null);
		}
		PageDTO page = new PageDTO(cri, service.getTotal(cri,exh));
		model.addAttribute("realmname",service.getExhRealmName());
		model.addAttribute("area",service.getExhArea());
		model.addAttribute("pageMaker", page);
		//Principal을 받지 않은 상태에서 스프링 시큐리티에서 유저아이디 값 구하는법
		String id = SecurityContextHolder.getContext().getAuthentication().getName();
		if(!id.equals("anonymousUser")) {
			model.addAttribute("group",fService.getGroup( id));			
		}
		model.addAttribute("eList", service.pagingList(cri, exh, id));
		return "/exhibition/exhibition";
	}
	//단일공연정보 불러오기
	@GetMapping("/view")
	public void exhibitionDetail(Model model, int seq, Principal principal) throws Exception {
		String id = principal.getName();
		RecentlyViewVO rec = new RecentlyViewVO(seq, id);
		if(rService.getIsViewd(rec)) {
			rService.removeRecentlyView(rec);
		}
		rService.addRecentlyView(new RecentlyViewVO(seq, id));
		model.addAttribute("group",fService.getGroup(id));
		ExhibitionVO exh = service.getOneView(seq,id);
		model.addAttribute("exh", exh);
		List<NaverBlogDTO> blogReview = blogservice.naverurlapi(exh.getExh_title());
		model.addAttribute("blogReview", blogReview);
	}
	//지도리스트불러오기
	@GetMapping("/mapList")
	public void exhibitionMapShow(Model model, String area) {
		if(area==null || area=="") {
			area = "서울";
		}
		List<ExhibitionVO> list = service.showPlaceList(area);
		List<String> yList = new ArrayList<String>();
		List<String> xList = new ArrayList<String>();
		List<String> pList = new ArrayList<String>();
		List<String> pcList = new ArrayList<String>();
		for(int i =0;i<list.size();i++) {
			String x = list.get(i).getExh_gpsx();				
			String y = list.get(i).getExh_gpsy();
			String p = list.get(i).getExh_placeseq();
			String pc = list.get(i).getExh_place();
			if(!x.equals("정보없음")) {
				if(!y.equals("정보없음")) {
					xList.add(x);
					yList.add(y);
					pList.add(p);
				}
			}
		}
		model.addAttribute("area",service.getExhArea());
		model.addAttribute("xList", xList);
		model.addAttribute("yList", yList);
		model.addAttribute("pList", pList);
	}

	//공연장시퀀스로 공연장정보 얻어오기
	@GetMapping(value = "/getPlaceInfo/{placeseq}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<ExhibitionVO> getPlace(@PathVariable("placeseq") String placeseq) {
		return new ResponseEntity<>(service.showPlaceListByPseq(placeseq), HttpStatus.OK);
	}
	
	//해당공연장의 공연리스트 얻어오기
	@GetMapping(value = "/placeList/{placeseq}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<List<ExhibitionVO>> getExhibitionListByPlace(@PathVariable("placeseq") String placeseq) {
		return new ResponseEntity<>(service.showListByPlace(placeseq), HttpStatus.OK); 
	}
	
	//간단한 단일공연정보 주기
	@GetMapping(value = "/{seq}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public ResponseEntity<ExhibitionVO> getExhibition(@PathVariable("seq") int seq) {
		return new ResponseEntity<>(service.getOne(seq), HttpStatus.OK);
	}
	
	
	//최근본공연 부분
	@GetMapping("/recentlyView")
	public void recentlyView(Model model, CriteriaDTO cri, Principal principal) {
		String id = principal.getName();
		cri.setAmount(5);
		PageDTO page = new PageDTO(cri, rService.getTotalCount(id));
		model.addAttribute("rList", rService.getList(cri, id));
		model.addAttribute("pageMaker", page);
	}

	@PostMapping("/removeRecentlyView")
	public String removerecentlyView(@RequestParam("seq") String[] seq, Principal principal) {
		String id = principal.getName();
		for(int i=0; i<seq.length; i++) {
			rService.removeRecentlyView(new RecentlyViewVO(Integer.parseInt(seq[i]), id));
		}
		return "redirect:/exhibition/recentlyView";
	}
	
	@DeleteMapping(value ="/removeRecentlyView", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> removeRec(@RequestBody RecentlyViewVO rec) {
		rec.setMember_id(SecurityContextHolder.getContext().getAuthentication().getName());
		return rService.removeRecentlyView(rec) == true ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//즐겨찾기 부분
	@RequestMapping("/favoriteList")
	public void exhibitionFavorite(Model model, String group, CriteriaDTO cri, Principal principal) {
		String id = principal.getName();
		FavoriteMarkVO fav = new FavoriteMarkVO();
		fav.setMember_id(id);
		if(group==null) {
			fav.setFavorite_group("찜 목록");
			model.addAttribute("pGroup","찜 목록");
		}else{
			fav.setFavorite_group(group);
			model.addAttribute("pGroup",group);
		}
		cri.setAmount(5);
		PageDTO page = new PageDTO(cri, fService.getTotalCount(fav.getFavorite_group()));
		model.addAttribute("pageMaker", page);
		model.addAttribute("group",fService.getGroup(id));
		model.addAttribute("fList",fService.paigingFavoriteList(fav, cri));
	}
	
	@PostMapping(value ="/addFavorite", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> addFavoriteMark(@RequestBody FavoriteMarkVO vo) {
		vo.setMember_id(SecurityContextHolder.getContext().getAuthentication().getName());
		return fService.addFavorite(vo) == true ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	

	@PostMapping("/removeFavorite")
	public String removeFavoriteMark(@RequestParam("seq") String[] seq, Principal principal) {
		String id = principal.getName();
		for(int i=0; i<seq.length; i++) {
			FavoriteMarkVO fav = new FavoriteMarkVO();
			fav.setExh_seq(Integer.parseInt(seq[i]));
			fav.setMember_id(id);
			fService.removeFavorite(fav);
		}
		return "redirect:/exhibition/favoriteList";
	}
	
	@DeleteMapping(value ="/removeFavorite", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	@ResponseBody
	public ResponseEntity<String> removeFav(@RequestBody FavoriteMarkVO vo) {
		vo.setMember_id(SecurityContextHolder.getContext().getAuthentication().getName());
		return fService.removeFavorite(vo) == true ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	//추천 부분
	@RequestMapping("/like/add")
	public String likeAdd(Principal principal, int seq) {
		ExhLikeVO like = new ExhLikeVO(principal.getName(), seq, 1);
		lService.addLikeStatus(like);
		service.updateLike(seq);
		return "redirect:/exhibition/view?seq="+seq;
	}
	
	@RequestMapping("/like/modify")
	public String likeModi(Principal principal, int seq, int status) {
		System.out.println(seq+"번 추천 수정요청!");
		ExhLikeVO like = new ExhLikeVO(principal.getName(), seq, status);
		lService.modifyLikeStatus(like);
		service.updateLike(seq);
		return "redirect:/exhibition/view?seq="+seq;
	}
	
	@RequestMapping("/unlike/add")
	public String unLikeAdd(Principal principal, int seq) {
		ExhLikeVO like = new ExhLikeVO(principal.getName(), seq, 2);
		lService.addLikeStatus(like);
		service.updateLike(seq);
		return "redirect:/exhibition/view?seq="+seq;
	}
	
	@RequestMapping("/unlike/modify")
	public String unLikeModi(Principal principal,int seq, int status) {
		System.out.println(seq+"번 비추천 수정요청!");
		ExhLikeVO like = new ExhLikeVO(principal.getName(), seq, status);
		lService.modifyLikeStatus(like);
		service.updateLike(seq);
		return "redirect:/exhibition/view?seq="+seq;
	}
	
	
}
