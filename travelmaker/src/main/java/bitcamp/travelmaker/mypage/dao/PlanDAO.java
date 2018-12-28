package bitcamp.travelmaker.mypage.dao;

import java.util.List;

import bitcamp.travelmaker.mypage.dto.PlanDTO;

public interface PlanDAO {

	int planreg(PlanDTO plan);

	List<PlanDTO> planlist(String m_Email);

	int plandel(int p_Num);

	int planupdate(PlanDTO plan);

	PlanDTO plansel(int p_Num);

	void plandelgo(int g_Num);

	void planupdatego(PlanDTO plandto);

}
