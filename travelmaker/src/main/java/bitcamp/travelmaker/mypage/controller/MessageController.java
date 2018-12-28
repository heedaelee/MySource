package bitcamp.travelmaker.mypage.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import bitcamp.travelmaker.dto.MemberDTO;
import bitcamp.travelmaker.mypage.service.MessageService;
import bitcamp.travelmaker.mypage.service.MypageMemberService;



@Controller
public class MessageController {

	@Autowired
	private View jsonview;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private MypageMemberService service;

	@RequestMapping("/message_list.htm")
	public String gowith_connect(Principal principal,Model model) {
		String m_Email=principal.getName();
		model.addAttribute("m_Email",m_Email);
/*		List<HashMap<String, Object>> list = messageService.listMessage(m_Email);
		List<HashMap<String, Object>> Slist = messageService.SlistMessage(m_Email);
		model.addAttribute("list", list);
		model.addAttribute("Slist", Slist);*/
		
		return "message.message";
	}
	
	@RequestMapping("/ms_list.htm")
	public View ms_list(Principal principal,Model model) {
		System.out.println("메시지컨트"+principal.getName());
		String m_Email=principal.getName();
		
		List<HashMap<String, Object>> list = messageService.listMessage(m_Email);
		model.addAttribute("data", list);
		System.out.println("뿌리기 전"+list.toString());
		return jsonview;
	}
	
	@RequestMapping("/ms_Slist.htm")
	public View ms_Slist(Principal principal,Model model) {
		System.out.println("메시지컨트"+principal.getName());
		String m_Email=principal.getName();
		
		List<HashMap<String, Object>> list = messageService.SlistMessage(m_Email);
		model.addAttribute("data", list);
		System.out.println("뿌리기 전2"+list.toString());
		return jsonview;
	}
	
	@RequestMapping(value = "/message_insert.htm", method = { RequestMethod.POST })
	public View gowith_insert(Principal principal,Model model,String m_Nickname, String n_Content, HashMap<String, Object> map) {
		System.out.println("메시지컨트"+principal.getName());
		String m_Semail = principal.getName();
		
		map.put("m_Nickname", m_Nickname);
		map.put("m_Semail", m_Semail);
		map.put("n_Content", n_Content);
		
		System.out.println("인서트 컨트롤러 : "+map.toString());
		int result = messageService.insertMessage(map);
		
		return jsonview;
	
	}
	
	@RequestMapping("/ms_Flist.htm")
	public View friendlist(HttpServletRequest request,Principal principal, Model model) {
		/*model.addAttribute("dto", dto);
		request.getSession().setAttribute("tile", "tile");*/
		List<MemberDTO> md = service.getFriendlist(principal.getName());
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		for(int i = 0; i<md.size();i++) {
			map.put("m_Nickname", md.get(i).getM_Nickname());
			map.put("m_Image", md.get(i).getM_Image());
			list.add(map);
		}
		
		model.addAttribute("data", list);
		return jsonview;
	}

	
	@RequestMapping(value = "/message_delete.htm", method = { RequestMethod.POST })
	
	public @ResponseBody String gowith_delete(@RequestParam(value="num[]") List<String> num) {
		List<Integer> n_Num = new ArrayList<Integer>(); 
		for(String snum : num) {
			 
			n_Num.add(Integer.parseInt(snum));
			System.out.println(n_Num.toString());
		}
		
		int result = messageService.deleteMessage(n_Num);
		System.out.println("결과값"+result);
		String r="success";
			return r;
		
		
	}
	
	
	
}
