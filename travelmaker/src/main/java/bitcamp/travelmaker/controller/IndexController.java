
package bitcamp.travelmaker.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;

import bitcamp.travelmaker.dto.MemberDTO;
import bitcamp.travelmaker.gowith.dto.GowithDTO;
import bitcamp.travelmaker.gowith.service.GowithService;
import bitcamp.travelmaker.mypage.service.MypageMemberService;
import bitcamp.travelmaker.reviewpage.dto.TravelDTO;
import bitcamp.travelmaker.reviewpage.service.TravelService;

@Controller
public class IndexController {
	
	@Autowired
	private View jsonview;
	
	@Autowired
	private MypageMemberService service;
	
	@Autowired
	private TravelService tservice;
	
	@Autowired
	private GowithService gservice;
		
	@RequestMapping("/index.htm")
		public String index(HttpServletRequest request,Principal principal, Model model) {
//		System.out.println(principal.getName());
//		model.addAttribute("tile", "index");
		List<TravelDTO> list = tservice.getMainReview();
		model.addAttribute("list", list);
		List<GowithDTO> list1 = gservice.getMainGo();
		model.addAttribute("glist", list1);
			if(principal!=null) {
				request.getSession().setAttribute("m_Email",principal.getName());				
				MemberDTO dto = new MemberDTO();
				System.out.println(request.getSession().getAttribute("m_Email"));
				dto = service.mypageMember(principal.getName());
				model.addAttribute("dto", dto);
//				model.addAttribute("social", "no");
				
			return "home.home";
		}
			else {
				return "home.home";
			}
}
	@RequestMapping("/delpage.htm")
	public String delpage(HttpServletRequest request) {
		 	
		return "home.delpage";
	}
	
	@RequestMapping("/friendsearch.htm")
	public String friend(HttpServletRequest request) {
		return "friend.friend";
	}
	
	@RequestMapping("/memberlist.htm")
	public View memberlist(HttpServletRequest request,Model model) {
		
		List<MemberDTO> list = service.getMemberlist();
		model.addAttribute("list", list);
		return jsonview;
	}
	
	@RequestMapping("/logout.htm")
	public String logout(HttpServletRequest request) {
			request.getSession().setAttribute("social", "no");
		return "home.logout";
	}
	
	@RequestMapping("/chat.htm")
	public String chat(Model model,String select,Principal principal,String roomname, HttpServletRequest request) {
		MemberDTO dto = new MemberDTO();
		System.out.println(roomname);
		System.out.println(select);
		
		HttpSession session = request.getSession();
		
		model.addAttribute("select", select);
		model.addAttribute("id", session.getAttribute("nickname"));
		dto = service.mypageMemberNick(roomname);
		model.addAttribute("friend", dto);
		System.out.println(dto.toString());
		System.out.println("dd");
//		System.out.println(request.getSession().getAttribute("m_Email"));
		dto = service.mypageMember(principal.getName());
		session.setAttribute("nickname", dto.getM_Nickname());
		System.out.println(dto.toString());
		model.addAttribute("dto", dto);
		return "chat.chat";
	}
}
