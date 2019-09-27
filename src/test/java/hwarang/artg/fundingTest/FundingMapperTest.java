package hwarang.artg.fundingTest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import hwarang.artg.funding.model.CrowdfundingVO;
import hwarang.artg.mapper.CrowdfundingMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FundingMapperTest {
	@Setter(onMethod_ = @Autowired)
	private CrowdfundingMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(CrowdfundingVO -> log.info(CrowdfundingVO));
	}
}
