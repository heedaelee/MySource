package bitcamp.travelmaker.dao;

import java.util.List;
import java.util.Map;

import bitcamp.travelmaker.dto.BlacklistDTO;
import bitcamp.travelmaker.dto.MemberDTO;

public interface MemberDAO {

	
	public int insertMember(MemberDTO member);
	
	public int socialinsertMember(MemberDTO member);
	
	public int idCheck(String m_Email);
	
	public int insertRoll(String m_Email);
	
	public MemberDTO getMember(String m_Email);
	
	public MemberDTO mypageMember(String m_Email);
	
	public int passChange(MemberDTO member);

	public int profileChange(MemberDTO memberdto);

	public int nickChange(MemberDTO memberdto);

	public String getPass(MemberDTO memberdto);

	public int deleteMember(MemberDTO memberdto);

	public int deleteRoll(MemberDTO memberdto);
//	회원목록 
	public List<MemberDTO> getMemberList();
	
	public List<MemberDTO> getMemberUpdate(String m_Email);
	
	public int update(MemberDTO dto);

	public String getPassword(String m_Email);
	
	public List<MemberDTO> searchMember(Map<String, String> map);
	
	public List<BlacklistDTO> getBlackList();
	
	public int blackinsert(BlacklistDTO dto); 
	
	public int deleteblack(int b_Num);
	
//	회원통계 
	public List<MemberDTO> memberReport();

	public int blacklistcheck(String m_Email);

	public MemberDTO friendsearch(String m_Nickname);

	public int friendinsert(MemberDTO memberdto);

	public List<MemberDTO> friendlist(String m_Email);

	public int friendcancel(MemberDTO memberdto);

	public List<MemberDTO> friendlistr(String m_Email);

	public int friendcancel1(MemberDTO memberdto);

	public int friendaccept(MemberDTO memberdto);

	public void friendinsert1(MemberDTO memberdto);

//	public void friendcanceldel(MemberDTO memberdto);

	public MemberDTO friendsearch1(MemberDTO dto);

	public List<MemberDTO> getFriendlist(String m_Email);

	public MemberDTO mypageMemberNick(String m_Nickname);

	public int blackcheck(String m_Email);

	public List<MemberDTO> getMemberlist();

	public int adminDeleteMember(String m_Email);

	public void addeleteRoll(String m_Email);

	public int countMember();

	public int frienddelete(MemberDTO memberdto);
	
}
