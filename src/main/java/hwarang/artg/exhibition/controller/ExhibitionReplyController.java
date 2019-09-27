package hwarang.artg.exhibition.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import hwarang.artg.common.model.CriteriaDTO;
import hwarang.artg.exhibition.model.ExhibitionReplyVO;
import hwarang.artg.exhibition.service.ExhibitionReplyService;
import lombok.Setter;

@RestController
@RequestMapping("/exhReplies")
public class ExhibitionReplyController {

	@Setter(onMethod_= {@Autowired})
	private ExhibitionReplyService service;
	
	@PostMapping(value ="/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ExhibitionReplyVO vo){
		System.out.println("통신받음");
		System.out.println("vo : "+vo);
		return service.register(vo) == true ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	@GetMapping(value = "/view/{exh_seq}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ExhibitionReplyVO>> getList(@PathVariable("page") int page, @PathVariable("exh_seq") int exh_seq){
		CriteriaDTO cri = new CriteriaDTO(page, 20);
		return new ResponseEntity<>(service.getList(cri, exh_seq), HttpStatus.OK);	
	}
	
	@GetMapping(value = "/{reply_num}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ExhibitionReplyVO> get(@PathVariable("reply_num") int reply_num){
		return new ResponseEntity<>(service.get(reply_num), HttpStatus.OK);		
	}
	
	@DeleteMapping(value = "/{reply_num}", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("reply_num") int reply_num){
		return service.remove(reply_num)== true ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);		
	}
	
	@RequestMapping(value = "/{reply_num}", method = {RequestMethod.PUT, RequestMethod.PATCH},consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@PathVariable("reply_num") int reply_num, @RequestBody ExhibitionReplyVO vo){
		vo.setReply_num(reply_num);
		return service.modify(vo) == true ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
	}
}
