package hwarang.artg.funding.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class FundingReplyDTO {
	private int replyCnt;
	private List<FundingReplyVO> list;
}
