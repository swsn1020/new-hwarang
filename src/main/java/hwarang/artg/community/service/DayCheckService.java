package hwarang.artg.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.community.model.DayCheckVO;
import hwarang.artg.mapper.DayCheckMapper;

@Service
public class DayCheckService {

	@Autowired
	private DayCheckMapper daycheckMapper;
	
	public boolean daycheckRegister(DayCheckVO daycheck) {
		if(daycheckMapper.insertCheck(daycheck)>0) {
			return true;
		}
		return false;
	}
	public List<DayCheckVO> daycheckGetAll(){
		return daycheckMapper.selectAll();
	}
	public DayCheckVO daycheckGetOne(String userid) {
		return daycheckMapper.selectOne(userid);
	}
}
