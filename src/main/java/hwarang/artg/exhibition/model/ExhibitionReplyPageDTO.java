package hwarang.artg.exhibition.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ExhibitionReplyPageDTO {

  private int replyCnt;
  private List<ExhibitionReplyVO> list;
}
