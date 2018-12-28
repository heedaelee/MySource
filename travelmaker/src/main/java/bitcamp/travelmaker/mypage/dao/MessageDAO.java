package bitcamp.travelmaker.mypage.dao;

import java.util.HashMap;
import java.util.List;


public interface MessageDAO {

	public int insertMessage(HashMap<String, Object> map);
	public List<HashMap<String, Object>> listMessage(String m_Semail);
	public List<HashMap<String, Object>> SlistMessage(String m_Semail);
	public int deleteMessage(HashMap<String, Object> n_Num);
	public String findRemail(String m_Nickname);
	public int count_receive_note(String m_Email);
	
	
	/*public List<HashMap<String, Object>> frinedsList(String m_Email);*/

}
