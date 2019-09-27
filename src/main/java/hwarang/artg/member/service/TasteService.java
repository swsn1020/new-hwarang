package hwarang.artg.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.mapper.TasteMapper;
import hwarang.artg.member.model.TasteVO;
@Service
public class TasteService {
	@Autowired
	private TasteMapper tastemapper;
	
	public boolean tasteRegister(String id,String name) {
		TasteVO t = new TasteVO();
		t.setMember_id(id);
		t.setTaste_name(name);
		int count = tastemapper.insertTaste(t);
		if(count > 0) {
			return true;
		}
		return false;
	}
	public boolean tasteModify(TasteVO t) {
		if(tastemapper.updateTaste(t) > 0) {
			return true;
		}
		return false;
	}
	public boolean tasteRemove(String name) {
		if(tastemapper.deleteTaste(name) > 0) {
			return true;
		}
		return false;
	}
	public TasteVO tasteGetOne(String name) {
		return tastemapper.selectTaste(name);
	}
	public List<TasteVO> tasteGetAll(){
		return tastemapper.selectAllTaste();
	}
}
