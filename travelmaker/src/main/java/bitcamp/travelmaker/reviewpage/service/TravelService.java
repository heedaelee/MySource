package bitcamp.travelmaker.reviewpage.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bitcamp.travelmaker.paging.PagingVo;
import bitcamp.travelmaker.reviewpage.dao.TravelDAO;
import bitcamp.travelmaker.reviewpage.dto.LikeDTO;
import bitcamp.travelmaker.reviewpage.dto.ReplyDTO;
import bitcamp.travelmaker.reviewpage.dto.TImageDTO;
import bitcamp.travelmaker.reviewpage.dto.TravelDTO;

@Service
public class TravelService {

	
	@Autowired
	private SqlSession sqlsession;
	
//	@Transactional(rollbackFor={Exception.class})
	public int reviewwritereg(TravelDTO traveldto) throws Exception{
		int result = 0;
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		dao.insertTravel(traveldto);
		result = traveldto.getT_Num();
		System.out.println(result);
		return result;
	}

	public int imagereg(TImageDTO tidto) {
		int result = 0;
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		result = dao.insertImage(tidto);
		
		return result;
	}


	public List<TravelDTO> getReviewList(PagingVo paging) {
		// TODO Auto-generated method stub
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<TravelDTO> list = dao.getReviewList(paging);
		return list;
	}

	public TravelDTO getReviewDetail(int t_Num) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		dao.updateHit(t_Num);
		TravelDTO list = dao.getReviewDetail(t_Num);	
		System.out.println(list.toString());
		return list;
	}

	public List<TImageDTO> getReviewImage(int t_Num) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<TImageDTO> list = dao.getReviewImage(t_Num);
		System.out.println(list.toString());
		return list;
	}

	public int reviewupdatereg(TravelDTO traveldto) {
		int result = 0;
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		result = dao.updateTravel(traveldto);
	
		return result;
	}

	
	public void reviewImgDel(int t_Num) {
	TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
	dao.reviewImgDel(t_Num);
		
	}
	@Transactional(rollbackFor={Exception.class})
	public int deletereview(int t_Num) throws Exception {
		int result = 0;
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		try{
			dao.deletereviewreple(t_Num);
			dao.deletegood(t_Num);
			dao.reviewImgDel(t_Num);	
			result = dao.deletereview(t_Num);
		}catch(Exception e) {
			System.out.println("Transaction 예외 발생" + e.getMessage());
			throw e; 
		}
		return result;
	}

	public int replyreg(ReplyDTO reply) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		int result = dao.replyreg(reply);
		
		return result;
		
	}

	public List<ReplyDTO> replylist(int t_Num) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<ReplyDTO> reple = dao.replylist(t_Num);
		System.out.println(reple.toString());
		
		return reple;
	}

	public int rerereg(ReplyDTO reply) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		int result = dao.rerereg(reply);
		
		return result;
	}

	public int replyupdate(ReplyDTO reply) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		int result = dao.replyupdate(reply);
		
		return result;
	}

	public int replydelete(int r_Num) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		int result = dao.replydelete(r_Num);
		
		return result;
	}
	
	public List<TravelDTO> getReviewAdmin(String m_Email) {
		
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<TravelDTO> dto = dao.getReviewAdmin(m_Email);
		
		return dto;
	}
	@Transactional(rollbackFor={Exception.class})
	public int likereg(LikeDTO like) throws Exception {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		int result = 0;
		try{
		result = dao.likereg(like);
		dao.updateLike(like.getT_Num());
		}catch(Exception e) {
			System.out.println("Transaction 예외 발생" + e.getMessage());
			throw e; 
		}
		return result;
	}
	@Transactional(rollbackFor={Exception.class})
	public int likedel(LikeDTO like) throws Exception {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		int result = 0;
		try{
		result = dao.likedel(like.getM_Email());
		dao.updateLi(like.getT_Num());
		}catch(Exception e) {
			System.out.println("Transaction 예외 발생" + e.getMessage());
			throw e; 
		}
		return result;
	}

	public int checklike(LikeDTO like) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		int result = dao.checklike(like);
		
		return result;
	}

	public int likecount(int t_Num) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		int result = dao.likecount(t_Num);
		System.out.println(result);
		return result;
	}

	public List<TravelDTO> getReviewLike(PagingVo paging) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<TravelDTO> list = dao.getReviewLike(paging);
		return list;
	}

	public List<TravelDTO> getReviewhit(PagingVo paging) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<TravelDTO> list = dao.getReviewhit(paging);
		return list;
	}

	public List<TravelDTO> reviewSearch(Map<String, String> map) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<TravelDTO> list = dao.reviewSearch(map);
		return list;
	}

	public int allReview() {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		int result = dao.allReview();
		
		return result;
	}
	
	public List<TravelDTO> getMapLatLng(String m_Email) {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<TravelDTO> trDto = dao.getMapLatLng(m_Email);	
		System.out.println(trDto.toString());
		return trDto;
	}
	
	public List<TravelDTO> getReviewMypage(String m_Email) {
		
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<TravelDTO> dto = dao.getReviewMypage(m_Email);
		
		return dto;
	}

	public List<TravelDTO> getMainReview() {
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<TravelDTO> dto = dao.getMainReview();
		
		return dto;
	}
	
	public List<TravelDTO> travelReport(){
		
		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
		List<TravelDTO> report = dao.travelReport();
//		System.out.println("service -----------> " + report);
		
		return report;
	}

//	public void deletereviewreple(int t_Num) {
//		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
//		dao.deletereviewreple(t_Num);
//
//	}

//	public void deletegood(int t_Num) {
//		TravelDAO dao = sqlsession.getMapper(TravelDAO.class);
//		dao.deletegood(t_Num);
//
//	}

}
