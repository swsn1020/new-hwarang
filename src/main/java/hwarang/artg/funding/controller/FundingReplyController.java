package hwarang.artg.funding.controller;

import java.util.List;

import javax.websocket.server.PathParam;

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
import hwarang.artg.funding.model.FundingReplyVO;
import hwarang.artg.funding.service.FundingReplyService;
import lombok.AllArgsConstructor;

@RequestMapping("/replies/")
@RestController
@AllArgsConstructor
public class FundingReplyController {

	private FundingReplyService service;
	
	@PostMapping(value = "/new",
				consumes = "application/json",
				produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String>create(@RequestBody FundingReplyVO vo){
		int insertCount = service.register(vo);
		
		return insertCount ==1
				? new ResponseEntity<>("success", HttpStatus.OK)
						:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pages/{funding_num}/{page}", 
				produces = {
						MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<FundingReplyVO>>getList(@PathVariable("page")int page, @PathVariable("funding_num")Long funding_num){
		CriteriaDTO cri = new CriteriaDTO(page,10);
		return new ResponseEntity<>(service.getList(cri, funding_num), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{rno}",
				produces = {
						MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<FundingReplyVO> get(@PathVariable("rno")Long rno){
		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{rno}",produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno")Long rno){
		return service.remove(rno)==1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PUT,RequestMethod.PATCH}, 
					value = "/{rno}",
					consumes = "application/json",
					produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody FundingReplyVO vo, @PathVariable("rno")Long rno){
		vo.setRno(rno);
		return service.modify(vo)==1
				?new ResponseEntity<>("success", HttpStatus.OK)
			    :new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	
}
