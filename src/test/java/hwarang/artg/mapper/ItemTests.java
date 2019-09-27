package hwarang.artg.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import hwarang.artg.exhibition.model.ExhibitionVO;
import hwarang.artg.exhibition.model.FavoriteMarkVO;
import hwarang.artg.exhibition.service.ExhibitionListService;
import hwarang.artg.exhibition.service.FavoriteMarkService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
@Log4j
public class ItemTests {

	@Setter(onMethod_ = { @Autowired })
	ExhibitionMapper mapper;

	@Setter(onMethod_ = { @Autowired })
	ExhibitionListService service;
	
	@Setter(onMethod_ = { @Autowired })
	FavoriteMarkService fService;

//	@Test
//	public void testInsert() {
//		try {
//			service.apiParserSearch();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}


//	@Test
//	public void testSelectAll() {
//		System.out.println(mapper.selectAll());
//	}

//	@Test
//	public void testSelectItem() {
//		System.out.println(mapper.select(132851));
//	}
//	@Test
//	public void testFavorite() {
//		System.out.println(fService.getFavoriteList("id"));
//	}
//	@Test
//	public void testInsert() {
//		FavoriteMarkVO fav = new FavoriteMarkVO();
//		fav.setExh_seq(152825);
//		fav.setMember_id("id");
//		fav.setFavorite_group("찜 목록");
//		fService.addFavorite(fav);
//		System.out.println(fService.getOne(fav));
//	}
//	@Test
//	public void testSeq() {
//		FavoriteMarkVO fav = new FavoriteMarkVO();
//		fav.setMember_id("id");
//		fav.setExh_seq(152825);
//		System.out.println(fService.getSeq(fav));
//	}
}
