package bitcamp.travelmaker.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bitcamp.travelmaker.dao.MemberDAO;
import bitcamp.travelmaker.dto.MemberDTO;

@Service
public class JoinService {

	@Autowired
	private SqlSession sqlsession;
	
	@Transactional(rollbackFor={Exception.class})
	public int insertMember(MemberDTO memberdto) throws Exception{
		int result = 0;
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		try{
			result = dao.insertMember(memberdto);
			dao.insertRoll(memberdto.getM_Email());
		}catch(Exception e) {
			System.out.println("Transaction 예외 발생" + e.getMessage());
			throw e; 
		}
		return result;
	}
	
	@Transactional(rollbackFor={Exception.class})
	public int socialinsertMember(MemberDTO memberdto) throws Exception{
		int result = 0;
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		try{
			result = dao.socialinsertMember(memberdto);
			dao.insertRoll(memberdto.getM_Email());
		}catch(Exception e) {
			System.out.println("Transaction 예외 발생" + e.getMessage());
			throw e; 
		}
		return result;
	}
//	
	public int idCheck(String m_Email){
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		int result = dao.idCheck(m_Email);
		return result;
	}
//	
//	public int loginCheck(String member_id, String member_pwd){
//		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
//		int result = dao.loginCheck(member_id, member_pwd);
//		return result;
//	}
	public int passChange(MemberDTO memberdto) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		int result = dao.passChange(memberdto);
		// TODO Auto-generated method stub
		return result;
	}
	public String getPassword(String m_Email) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		String result = dao.getPassword(m_Email);
		// TODO Auto-generated method stub
		return result;
		
	}

	public int blacklistcheck(String m_Email) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		int result = dao.blacklistcheck(m_Email);
		// TODO Auto-generated method stub
		return result;
	}

	public MemberDTO friendsearch(String m_Nickname) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		MemberDTO result = dao.friendsearch(m_Nickname);
		// TODO Auto-generated method stub
		return result;
	}

	public int friendinsert(MemberDTO memberdto) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		int result = dao.friendinsert(memberdto);
		// TODO Auto-generated method stub
		return result;
	}

	public List<MemberDTO> friendlist(String m_Email) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		List<MemberDTO> result = dao.friendlist(m_Email);
		return result;
	}

	public int friendcancel(MemberDTO memberdto) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		int result = dao.friendcancel(memberdto);
		// TODO Auto-generated method stub
		return result;
	}

	public List<MemberDTO> friendlistr(String m_Email) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		List<MemberDTO> result = dao.friendlistr(m_Email);
		return result;
	}

	public int friendcancel1(MemberDTO memberdto) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		int result = dao.friendcancel1(memberdto);
		// TODO Auto-generated method stub
		return result;
	}

	public int friendaccept(MemberDTO memberdto) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		int result = dao.friendaccept(memberdto);
		// TODO Auto-generated method stub
		return result;
	}

	public void friendinsert1(MemberDTO memberdto) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		dao.friendinsert1(memberdto);
		// TODO Auto-generated method stub
	}

//	public void friendcanceldel(MemberDTO memberdto) {
//		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
//		dao.friendcanceldel(memberdto);
//	
//	}

	public void frindaccept1(MemberDTO memberdto) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		dao.friendaccept(memberdto);
		// TODO Auto-generated method stub
	}

	public MemberDTO friendsearch1(MemberDTO dto) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		MemberDTO result = dao.friendsearch1(dto);
		// TODO Auto-generated method stub
		return result;
	}
	
	public int frienddelete(MemberDTO memberdto) {
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		int result = dao.frienddelete(memberdto);
		return result;
	}
}
