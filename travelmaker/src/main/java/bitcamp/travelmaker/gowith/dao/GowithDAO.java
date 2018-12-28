package bitcamp.travelmaker.gowith.dao;

import java.util.HashMap;
import java.util.List;

import bitcamp.travelmaker.gowith.dto.GowithDTO;
import bitcamp.travelmaker.gowith.dto.go_ReplyDTO;
import bitcamp.travelmaker.paging.PagingVo;

public interface GowithDAO {

	
	public int insertGowith(GowithDTO gowithDTO);
	public int insertGimage(HashMap<String, Object> map);

	public List<GowithDTO> selectAllGowith(PagingVo pagingVo);//리스트
	public int totalSelect(PagingVo pagingVo);//전체글수
	public List<GowithDTO> joinList(PagingVo pagingVo);//참여가능 검색
	
	public GowithDTO selectGowith(int g_Num); //go게시물 하나 선택
	public void updateHit(int num); //조회수 증가
	public List<String> selectImg(int g_Num);//go 게시물 이미지 선택
	
	public int updateGowith(GowithDTO gowithDTO);//게시물 수정
	public void deleteGimage(int g_Num);
	
	public void deleteApp(int number);//지원자 테이블 먼저 삭제
	public void deleteGowith(int number);// 게시글 삭제
	
	public void application(HashMap<String, Object> map); //참여 버튼
	public List<HashMap<String, Object>> selectApp(int g_Num);//참여자 리스트 조회
	public void cancel(HashMap<String, Object> map);//참여 취소버튼
	public String genderCheck(String m_Email);//참여자 성별체크
	
	public int replyreg(go_ReplyDTO reply);
	public List<go_ReplyDTO> replylist(int g_Num);
	public int rerereg(go_ReplyDTO reply);
	public int replyupdate(go_ReplyDTO reply);
	public int replydelete(int r_Num);
	
	
	public List<GowithDTO> getWithListMypage(String m_Email);
	public List<GowithDTO> getWithListAdmin(String m_Email);
	public List<GowithDTO> getMainGo();

}
