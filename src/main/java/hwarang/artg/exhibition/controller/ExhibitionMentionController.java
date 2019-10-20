package hwarang.artg.exhibition.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.ExhibitionMentionPageDTO;
import hwarang.artg.exhibition.model.ExhibitionMentionVO;
import hwarang.artg.exhibition.service.ExhibitionMentionService;
import lombok.Setter;

@RestController
@RequestMapping("/exhMention")
public class ExhibitionMentionController {

	@Setter(onMethod_= {@Autowired})
	private ExhibitionMentionService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value ="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ExhibitionMentionVO vo){
		System.out.println("통신받음");
		System.out.println("vo : "+vo);
		return service.insert(vo) == true ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@GetMapping(value = "/view/{exh_seq}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ExhibitionMentionPageDTO> getList(@PathVariable("page") int page, @PathVariable("exh_seq") int exh_seq){
		CriteriaDTO cri = new CriteriaDTO(page, 10);
		return new ResponseEntity<>(service.selectListBySeq(cri, exh_seq), HttpStatus.OK);	
	}
	
	@GetMapping(value = "/{mention_no}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ExhibitionMentionVO> get(@PathVariable("mention_no") int mention_no){
		return new ResponseEntity<>(service.select(mention_no), HttpStatus.OK);		
	}
	
	@PreAuthorize("isAuthenticated()")
	@DeleteMapping(value = "/{mention_no}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("mention_no") int mention_no){
		return service.delete(mention_no)== true ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);		
	}
	
	@PreAuthorize("principal.username == #vo.member_id")
	@RequestMapping(value = "/{mention_no}", method = {RequestMethod.PUT, RequestMethod.PATCH},consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@PathVariable("mention_no") int mention_no, @RequestBody ExhibitionMentionVO vo){
		vo.setMention_no(mention_no);
		return service.update(vo) == true ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping(value = "/isEntered/{exh_seq}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public int isEntered(@PathVariable("exh_seq") int exh_seq, Principal principal){
		System.out.println("isEntered"+exh_seq);
		String member_id = principal.getName();
		return service.getMentionStatus(member_id, exh_seq);	
	}
}
