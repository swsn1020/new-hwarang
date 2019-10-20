package hwarang.artg.exhibition.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ExhibitionMentionPageDTO {

  private int mentionCnt;
  private List<ExhibitionMentionVO> list;
}
