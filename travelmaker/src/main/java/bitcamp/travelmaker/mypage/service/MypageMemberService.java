package bitcamp.travelmaker.mypage.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bitcamp.travelmaker.dao.MemberDAO;
import bitcamp.travelmaker.dto.MemberDTO;

@Service
public class MypageMemberService {
	
	@Autowired
	private SqlSession sqlsession;
	
		public MemberDTO mypageMember(String m_Email){
			MemberDTO dto;
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			dto = dao.mypageMember(m_Email);
		
			
		return dto;
	}
		
		public int profileChange(MemberDTO memberdto){
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			int result = dao.profileChange(memberdto);
		
			
		return result;
	}

		public int nickChange(MemberDTO memberdto) {
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			int result = dao.nickChange(memberdto);
		
			
		return result;
		}

		public String getPass(MemberDTO memberdto) {
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			String result = dao.getPass(memberdto);
			
			
		return result;
		}
		@Transactional(rollbackFor={Exception.class})
		public int deleteMember(MemberDTO memberdto) throws Exception {
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			int result=0;
			try{
				dao.deleteRoll(memberdto);
				result = dao.deleteMember(memberdto);	
			}catch(Exception e) {
				System.out.println("Transaction 예외 발생" + e.getMessage());
				throw e; 
			}
			
		return result;
		}

		public List<MemberDTO> getFriendlist(String m_Email) {
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			List<MemberDTO> dto = dao.getFriendlist(m_Email);
			System.out.println(m_Email);
			return dto;
		}
//		public int deleteRoll(MemberDTO memberdto) {
//			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
//			int result =dao.deleteRoll(memberdto);
//		
//			return result;
//		}

		public MemberDTO mypageMemberNick(String m_Nickname) {
			MemberDTO dto;
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			dto = dao.mypageMemberNick(m_Nickname);
		
			
		return dto;
		}

		public List<MemberDTO> getMemberlist() {
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			List<MemberDTO> dto = dao.getMemberlist();
			return dto;
		}
		
}
