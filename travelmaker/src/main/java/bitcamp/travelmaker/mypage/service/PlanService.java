package bitcamp.travelmaker.mypage.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bitcamp.travelmaker.mypage.dao.PlanDAO;
import bitcamp.travelmaker.mypage.dto.PlanDTO;

@Service
public class PlanService {
	@Autowired
	private SqlSession sqlsession;

	public int planreg(PlanDTO plan) {
		PlanDAO dao = sqlsession.getMapper(PlanDAO.class);
		int result = dao.planreg(plan);
		result = plan.getP_Num();
		System.out.println(result);
		return result;
	}

	public List<PlanDTO> planlist(String m_Email) {
		PlanDAO dao = sqlsession.getMapper(PlanDAO.class);
		List<PlanDTO> result = dao.planlist(m_Email);
	
		
		return result;
	}

	public int plandel(int p_Num) {
		PlanDAO dao = sqlsession.getMapper(PlanDAO.class);
		int result = dao.plandel(p_Num);
	
		
		return result;
	}

	public int planupdate(PlanDTO plan) {
		PlanDAO dao = sqlsession.getMapper(PlanDAO.class);
		int result = dao.planupdate(plan);
	
		
		return result;
	}

	public PlanDTO plansel(int p_Num) {
		PlanDAO dao = sqlsession.getMapper(PlanDAO.class);
		PlanDTO result = dao.plansel(p_Num);
	
		
		return result;
	}
	
		
}

