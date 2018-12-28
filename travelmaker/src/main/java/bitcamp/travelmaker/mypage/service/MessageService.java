package bitcamp.travelmaker.mypage.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bitcamp.travelmaker.mypage.dao.MessageDAO;


@Service
public class MessageService {
	@Autowired
	private SqlSession sqlsession;

	public int insertMessage(HashMap<String, Object> map) {
		MessageDAO dao = sqlsession.getMapper(MessageDAO.class);
		
		String m_Nickname = (String) map.get("m_Nickname");
		System.out.println("서비스에서 닉네임 : "+m_Nickname);
		String m_Remail=dao.findRemail(m_Nickname);
		
		map.put("m_Remail", m_Remail);
		
		System.out.println("서비스에서"+map.toString());
		int result = dao.insertMessage(map);
		return result;
	}

	
	public List<HashMap<String, Object>> listMessage(String m_Email){
		MessageDAO dao = sqlsession.getMapper(MessageDAO.class);
		
		List<HashMap<String, Object>> list = dao.listMessage(m_Email);
		
		return list;
	}
	
	public List<HashMap<String, Object>> SlistMessage(String m_Email){
		MessageDAO dao = sqlsession.getMapper(MessageDAO.class);
		
		List<HashMap<String, Object>> list = dao.SlistMessage(m_Email);
		
		return list;
	}
	
	
	public int deleteMessage(List<Integer> num) {
		int result=0;
		MessageDAO dao = sqlsession.getMapper(MessageDAO.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", num);
		result = dao.deleteMessage(map);
		
		return result;
	}
	
	public String count_receive_note(String m_Email) {
		MessageDAO dao = sqlsession.getMapper(MessageDAO.class);
		int count= dao.count_receive_note(m_Email);
		String cnt= String.valueOf(count);
		return cnt;
	}
	
	
	
}

