package bitcamp.travelmaker.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.View;

import bitcamp.travelmaker.dto.MemberDTO;
import bitcamp.travelmaker.service.JoinService;


@Controller
@RequestMapping("/joinus/")
public class JoinController {

/*	@Autowired
	private MemberDao memberdao;*/

	//비동기
	@Autowired
	private View jsonview;
//	
	@Autowired
	private JoinService service;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@RequestMapping(value="join.htm",method=RequestMethod.POST)
	public @ResponseBody String join(HttpServletRequest request, MemberDTO memberdto,Model model) throws ClassNotFoundException, SQLException, IOException {
		System.out.println(memberdto.toString());
		//		
		CommonsMultipartFile file = memberdto.getFile();
		if (file != null && file.getSize() > 0) { // 업로드한 파일이 하나라도 있다면
				String fname = file.getOriginalFilename(); // 파일명 얻기
				String path = request.getServletContext().getRealPath("/image/member");
				String fullpath = path + "\\" + fname;

				System.out.println(fname + " / " + path + " / " + fullpath);
				memberdto.setM_Image(fname);
				if (!fname.equals("")) {
					// 서버에 파일 쓰기 작업
					FileOutputStream fs = new FileOutputStream(fullpath);
					fs.write(file.getBytes());
					fs.close();
				}
				 // 실 DB Insert 작업시 .. 파일명
			}
		String r = "";
		int result = 0;
		memberdto.setM_Pwd(this.bCryptPasswordEncoder.encode(request.getParameter("m_Pwd")));
		try{
				result = service.insertMember(memberdto);
				
				if(result > 0) {
					System.out.println("가입성공");
					r="success";
				}else {
					System.out.println("가입실패");
					r="fail";
				}
		} catch (Exception e) {
			System.out.println("예외발생 : " +  e.getMessage());
			System.out.println("가입실패");
			r="fail";
		}
		
		return r; //주의 (website/index.htm
		
	}
	
	@RequestMapping(value="kakaojoin.htm",method=RequestMethod.POST)
	public View kakaojoin(HttpServletRequest request, MemberDTO memberdto,Model model) throws ClassNotFoundException, SQLException, IOException {
		System.out.println(memberdto.toString());
		int result = 0;
		model.addAttribute("m_Pwd", memberdto.getM_Pwd());
		String gender = request.getParameter("m_Gender");
		System.out.println(gender);
		if(gender==null) {
			gender="man";
		}
		if(gender.equals("female"))
		{
			gender="woman";
		}else {
			gender="man";		
			}
		System.out.println(gender);
		memberdto.setM_Gender(gender);
		
		memberdto.setM_Pwd(this.bCryptPasswordEncoder.encode(request.getParameter("m_Pwd")));
		
		try{
				result = service.socialinsertMember(memberdto);
				
				if(result > 0) {
					System.out.println("가입성공");
					model.addAttribute("m_Email", request.getParameter("m_Email"));
					
					
				}
				else {
					System.out.println("가입실패");
				}
		} catch (Exception e) {
			System.out.println("예외발생 : " +  e.getMessage());
			System.out.println("가입실패");
		}
		
		return jsonview; //주의 (website/index.htm
		
	}
//	
//	//비동기 JSONVIEW
	@RequestMapping(value = "idcheck.htm")
	public View idCheck(@RequestParam("m_Email") String m_Email, Model model) {
		int result = service.idCheck(m_Email);
		if (result > 0) {
			System.out.println("아이디 중복");
			model.addAttribute("result", "fail");
		} else {
			System.out.println("아이디 사용가능");
			model.addAttribute("result", "success");
		}
		return jsonview; //{"result":"fail"}
	}
	@RequestMapping(value = "naverjoin.htm")
	public View naverjoin(HttpServletRequest request,MemberDTO memberdto, Model model) {
		System.out.println(memberdto.toString());
		int result = 0;
		model.addAttribute("m_Pwd", memberdto.getM_Pwd());
		memberdto.setM_Pwd(this.bCryptPasswordEncoder.encode(request.getParameter("m_Pwd")));
		String gender = request.getParameter("m_Gender");
		System.out.println(gender);
		if(gender.equals("F"))
		{
			gender="woman";
		}else {
			gender="man";		
			}
		memberdto.setM_Gender(gender);
		try{
				result = service.socialinsertMember(memberdto);
				
				if(result > 0) {
					System.out.println("가입성공");
					model.addAttribute("m_Email", request.getParameter("m_Email"));
					
					
				}
				else {
					System.out.println("가입실패");
				}
		} catch (Exception e) {
			System.out.println("예외발생 : " +  e.getMessage());
			System.out.println("가입실패");
		}
		
		return jsonview; //주의 (website/index.htm
		
	}
	
	@RequestMapping(value = "passchange.htm") 
	public View passChange(HttpSession session,HttpServletRequest request,MemberDTO memberdto, Model model) {
		memberdto.setM_Pwd(this.bCryptPasswordEncoder.encode(memberdto.getM_Pwd()));
		int result = service.passChange(memberdto);
		if (result > 0) {
			System.out.println("비밀번호변경성공");
			model.addAttribute("result", "fail");
		} else {
			System.out.println("비밀번호 변경실패");
			model.addAttribute("result", "success");
		}
		return jsonview; //{"result":"fail"}
	}
	
	@RequestMapping(value="kakaocheck.htm")
	public View kakaocheck(HttpSession session,String m_Email,Model model){
		int result = service.idCheck(m_Email);
		String data="";
//		session.setAttribute("social", "yes");
		if(result>0){
			data ="success";
//			String pass = service.getPassword(m_Email);
			model.addAttribute("data",data);
		}else{
			data = "fail";
		}
		return jsonview;
	}
	
	@RequestMapping(value="navercheck.htm")
	public View navercheck(HttpSession session,String m_Email,Model model){
		int result = service.idCheck(m_Email);
		String data="";
//		session.setAttribute("social", "yes");
		if(result>0){
			data ="success";
//			String pass = service.getPassword(m_Email);
			model.addAttribute("data",data);
		}else{
			data = "fail";
		}
		return jsonview;
	}
	
	@RequestMapping(value = "blacklistcheck.htm")
	public View blacklistcheck(String m_Email, Model model) {
		System.out.println(m_Email);
		int result = service.blacklistcheck(m_Email);
		if (result > 0) {
			System.out.println("블랙리스트");
			model.addAttribute("result", "fail");
		} else {
			System.out.println("블랙리스트 x");
			model.addAttribute("result", "success");
		}
		return jsonview; //{"result":"fail"}
	}
	
	@RequestMapping(value = "friendsearch.htm")
	public View friendsearch(String m_Nickname,Principal principal, Model model) {
		System.out.println(m_Nickname);
		MemberDTO dto = new MemberDTO();
		if(principal!=null) {
		dto.setM_Email(principal.getName());
		dto.setM_Nickname(m_Nickname);
		System.out.println(dto.toString());
		dto = service.friendsearch1(dto);
		String fail = "";
		if(dto==null) {
			System.out.println("되나");
			dto = service.friendsearch(m_Nickname);
			if(dto == null) {
				fail = "fail";
			}
				
		}
		model.addAttribute("friend", dto);
		model.addAttribute("fail", fail);
		}
		else {
			model.addAttribute("login","fail");
		}
		return jsonview; //{"result":"fail"}
	}
	
//	@RequestMapping(value = "friendsearch1.htm")
//	public View friendsearch1(String m_Nickname, Model model) {
//		System.out.println(m_Nickname);
//		MemberDTO result = service.friendsearch1(m_Nickname);
//		model.addAttribute("friend", result);
//		
//		return jsonview; //{"result":"fail"}
//	}
	
	@RequestMapping(value = "friendinsert.htm")
	public View friendinsert(MemberDTO memberdto,Principal principal, Model model) {
		memberdto.setM_Email(principal.getName());
		int result = service.friendinsert(memberdto);
		if (result > 0) {
			memberdto.setM_Email(memberdto.getM_Email2());
			memberdto.setM_Email2(principal.getName());
			service.friendinsert1(memberdto);
			System.out.println("친구추가성공");
			model.addAttribute("result", "fail");
		} else {
			System.out.println("친구실패");
			model.addAttribute("result", "success");
		}
		
		return jsonview; //{"result":"fail"}
	}
	
	@RequestMapping(value = "friendlist.htm")
	public View friendlist(Principal principal, Model model) {
		String re = ""; 
		if(principal==null) {
			re="fail";
			System.out.println(re);
			model.addAttribute("friendlist", re);
			
		}else {
		String m_Email = principal.getName();
		List<MemberDTO> result = service.friendlist(m_Email);
		System.out.println(result);
		System.out.println("하하");
		model.addAttribute("friendlist", result);
		}
		return jsonview; //{"result":"fail"}
	}
	
//	@RequestMapping(value = "friendlistr.htm")
//	public View friendlistr(Principal principal, Model model) {
//		String m_Email = principal.getName();
//		List<MemberDTO> result = service.friendlistr(m_Email);
//		System.out.println(result);
//		model.addAttribute("friendlist", result);
//		
//		return jsonview; //{"result":"fail"}
//	}
	
	@RequestMapping(value = "friendcancel.htm")
	public View friendcancel(String m_Email2, Principal principal, Model model) {
		MemberDTO memberdto = new MemberDTO();
		memberdto.setM_Email(principal.getName());
		memberdto.setM_Email2(m_Email2);
		System.out.println(memberdto.toString());
		int result = service.friendcancel(memberdto);
		if (result > 0) {
			System.out.println("친구취소성공");
			memberdto.setM_Email(m_Email2);
			memberdto.setM_Email2(principal.getName());
			service.friendcancel(memberdto);
			model.addAttribute("result", "fail");
		} else {
			System.out.println("친구취소실패");
			model.addAttribute("result", "success");
		}
		
		return jsonview; //{"result":"fail"}
	}
	
	@RequestMapping(value = "friendcancel1.htm")
	public View friendcancel1(String m_Email, Principal principal, Model model) {
		MemberDTO memberdto = new MemberDTO();
		memberdto.setM_Email(principal.getName());
		memberdto.setM_Email2(m_Email);
		int result = service.friendcancel(memberdto);
		if (result > 0) {
			System.out.println("친구삭제성공");
			memberdto.setM_Email(m_Email);
			memberdto.setM_Email2(principal.getName());
			service.friendcancel(memberdto);
			model.addAttribute("result", "fail");
		} else {
			System.out.println("친구삭제실패");
			model.addAttribute("result", "success");
		}
		
		return jsonview; //{"result":"fail"}
	}
	
	@RequestMapping(value = "friendaccept.htm")
	public View friendaccept(String m_Email, Principal principal, Model model) {
		MemberDTO memberdto = new MemberDTO();
		memberdto.setM_Email2(principal.getName());
		memberdto.setM_Email(m_Email);
		int result = service.friendaccept(memberdto);
		if (result > 0) {
			System.out.println("친구성공");
			memberdto.setM_Email(principal.getName());
			memberdto.setM_Email2(m_Email);
			service.frindaccept1(memberdto);
			model.addAttribute("result", "fail");
		} else {
			System.out.println("친구실패");
			model.addAttribute("result", "success");
		}
		
		return jsonview; //{"result":"fail"}
	}
	
	@RequestMapping(value = "frienddelete.htm")
	public View frienddelete(String m_Email2, Principal principal, Model model) {
		MemberDTO memberdto = new MemberDTO();
		memberdto.setM_Email(principal.getName());
		memberdto.setM_Email2(m_Email2);
		int result = service.frienddelete(memberdto);
		if(result>0) {
			System.out.println("친구삭제 성공");
			model.addAttribute("result","fail");
		} else {
			System.out.println("친구삭제 실패");
			model.addAttribute("result","success");
		}
		return jsonview;
	}

}
