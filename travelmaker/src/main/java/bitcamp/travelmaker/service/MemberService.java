package bitcamp.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bitcamp.travelmaker.dao.MemberDAO;
import bitcamp.travelmaker.dto.BlacklistDTO;
import bitcamp.travelmaker.dto.MemberDTO;

@Service
public class MemberService {
	
	@Autowired
	private SqlSession sqlsession;
	
		public MemberDTO getMember(String m_Email){
		MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
		MemberDTO result = dao.getMember(m_Email);
		return result;
	}

		// 회원목록 전체조회 	
		public List<MemberDTO> getMemberList(){
			
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			List<MemberDTO> member = dao.getMemberList();
			return member;
			
		}	
		
//		회원목록 수정 가져오기 
		public List<MemberDTO> getMemberUpdate(String m_Email) {
			
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
//			System.out.println(dao.getMemberUpdate(m_Email));
			return dao.getMemberUpdate(m_Email);
		}
		
//		회원검색 
		public List<MemberDTO> searchMember(Map<String, String> map){
			
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			List<MemberDTO> search = dao.searchMember(map);
			System.out.println("search service : " + search);
			
			return search;
		}
		

		public List<BlacklistDTO> getBlackList(){
			
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			List<BlacklistDTO> black = dao.getBlackList();
			
			return black;
		}	
		
		public int blackinsert(BlacklistDTO dto) {

			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			int result = dao.blackinsert(dto);
			
			return result;
		}
		
		public int deleteblack(int b_Num) {
			
			int result = 0;
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			result = dao.deleteblack(b_Num);
			
			return result;
		}
		@Transactional(rollbackFor={Exception.class})
		public int adminDeleteMember(String m_Email) throws Exception {
			
			int result = 0;
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			try{
				
			dao.addeleteRoll(m_Email);
			result = dao.adminDeleteMember(m_Email);
			
			}catch(Exception e) {
				System.out.println("Transaction 예외 발생" + e.getMessage());
				throw e; 
			}
			return result;
		}
		
		
		public List<MemberDTO> memberReport(){
			
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			List<MemberDTO> report = dao.memberReport();
//			System.out.println("service -----------> " + report);
			
			return report;
		}

		public int blackcheck(String m_Email) {
			int result = 0;
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			result = dao.blackcheck(m_Email);
			
			return result;
		}	
		
		public int countMember(){
			
			int count = 0;
			MemberDAO dao = sqlsession.getMapper(MemberDAO.class);
			count = dao.countMember();
			System.out.println("service -----------> " + count);
			
			return count;
		}
			
}
