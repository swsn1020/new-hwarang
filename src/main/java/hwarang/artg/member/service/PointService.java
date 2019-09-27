package hwarang.artg.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hwarang.artg.mapper.MemberMapper;
import hwarang.artg.mapper.PointMapper;
import hwarang.artg.member.model.MemberVO;
import hwarang.artg.member.model.PointVO;
@Service
public class PointService {
	@Autowired
	private PointMapper pointmapper;
	@Autowired
	private MemberService memberservice;
	
	public boolean pointGetRegister(int num,int get,String memo,String id) {
		PointVO p = new PointVO();
		p.setPoint_num(num);
		p.setMember_id(id);
		p.setPoint_memo(memo);
		p.setPoint_get_amount(get);
		int count = pointmapper.insertGetPoint(p);
		MemberVO member = memberservice.memberGetOne(id);
		int point = member.getMember_point();
		member.setMember_point(get+point);
		memberservice.memberModify(member);
		if(count > 0) {
			return true;
		}
		return false;
	}
	public boolean pointUseRegister(int num,int use,String memo,String id) {
		PointVO p = new PointVO();
		p.setPoint_num(num);
		p.setMember_id(id);
		p.setPoint_memo(memo);
		p.setPoint_use_amount(use);
		int count = pointmapper.insertUsePoint(p);
		MemberVO member =memberservice.memberGetOne(id);
		int point = member.getMember_point();
		member.setMember_point(point-use);
		memberservice.memberModify(member);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public boolean pointModify(PointVO p) {
		if(pointmapper.updatePoint(p) > 0) {
			return true;
		}
		return false;
	}
	public boolean pointRemove(int num) {
		if(pointmapper.deletePoint(num) > 0) {
			return true;
		}
		return false;
	}
	public List<PointVO> pointGetOne(String member_id) {
		return pointmapper.selectPoint(member_id);
	}
	public List<PointVO> pointGetAll(){
		return pointmapper.selectAllPoint();
	}
	
}
