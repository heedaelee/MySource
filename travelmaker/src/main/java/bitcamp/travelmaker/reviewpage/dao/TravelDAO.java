package bitcamp.travelmaker.reviewpage.dao;

import java.util.List;
import java.util.Map;

import bitcamp.travelmaker.paging.PagingVo;
import bitcamp.travelmaker.reviewpage.dto.LikeDTO;
import bitcamp.travelmaker.reviewpage.dto.ReplyDTO;
import bitcamp.travelmaker.reviewpage.dto.TImageDTO;
import bitcamp.travelmaker.reviewpage.dto.TravelDTO;

public interface TravelDAO {

	public int insertTravel(TravelDTO traveldto);
	
	public int insertImage(TImageDTO tidto);

	public List<TravelDTO> getReviewList(PagingVo paging);

	public TravelDTO getReviewDetail(int t_Num);

	public List<TImageDTO> getReviewImage(int t_Num);

	public void updateHit(int t_Num);

	public int updateTravel(TravelDTO traveldto);

	public int updateImage(TImageDTO tidto);

	public void reviewImgDel(int t_Num);

	public int deletereview(int t_Num);

	public int replyreg(ReplyDTO reply);

	public List<ReplyDTO> replylist(int t_Num);

	public int rerereg(ReplyDTO reply);

	public int replyupdate(ReplyDTO reply);

	public int replydelete(int r_Num);
	
	public List<TravelDTO> getReviewAdmin(String m_Email);

	public int likereg(LikeDTO like);

	public int likedel(String m_Email);

	public int checklike(LikeDTO like);

	public void updateLike(int t_Num);

	public void updateLi(int t_Num);

	public int likecount(int t_Num);

	public List<TravelDTO> getReviewLike(PagingVo paging);

	public List<TravelDTO> getReviewhit(PagingVo paging);

	public List<TravelDTO> reviewSearch(Map<String, String> map);

	public int allReview();

	public List<TravelDTO> getMapLatLng(String m_Email);

	public List<TravelDTO> getReviewMypage(String m_Email);

	public List<TravelDTO> getMainReview();

	public List<TravelDTO> travelReport();

	public void deletereviewreple(int t_Num);

	public void deletegood(int t_Num);

}
