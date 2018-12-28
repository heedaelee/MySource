package bitcamp.travelmaker.mypage.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.View;

import bitcamp.travelmaker.dto.MemberDTO;
import bitcamp.travelmaker.gowith.dto.GowithDTO;
import bitcamp.travelmaker.gowith.dto.go_ReplyDTO;
import bitcamp.travelmaker.gowith.service.GowithService;
import bitcamp.travelmaker.mypage.dto.PlanDTO;
import bitcamp.travelmaker.mypage.service.MypageMemberService;
import bitcamp.travelmaker.mypage.service.PlanService;
import bitcamp.travelmaker.reviewpage.dto.LikeDTO;
import bitcamp.travelmaker.reviewpage.dto.ReplyDTO;
import bitcamp.travelmaker.reviewpage.dto.TImageDTO;
import bitcamp.travelmaker.reviewpage.dto.TravelDTO;
import bitcamp.travelmaker.reviewpage.service.TravelService;
import bitcamp.travelmaker.service.JoinService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MypageController {
	
	@Autowired
	private MypageMemberService service;
	
	@Autowired
	private View jsonview;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private GowithService withservice;
	
	@Autowired
	private PlanService pservice;
	
	@Autowired
	private TravelService travelservice;
	
	@Autowired
	private JoinService joinservice;
	
	
	@RequestMapping("/mypage.htm")
	public String mypage(HttpServletRequest request,Principal principal,Model model) {
		//return "index.jsp";
		MemberDTO dto = new MemberDTO();
			if(principal.getName().equals("admin@admin")) {
				String m_Email1 = request.getParameter("m_Email");
				System.out.println(m_Email1);
				dto = service.mypageMember(m_Email1);
				System.out.println(" <!---- 어드민 접속----->" + dto);
				
			}
			else {
				
				System.out.println(principal.getName());
				String m_Email = principal.getName();
				dto = service.mypageMember(m_Email);
			}
			
//		System.out.println(dto.toString());
		model.addAttribute("tile", "tile");
		model.addAttribute("dto", dto);
		return "mypage.mypage";
	}
	
	@RequestMapping("/profilech.htm")
	public @ResponseBody String profileChange(HttpServletRequest request,MemberDTO memberdto) throws IOException {
		System.out.println(memberdto.toString());
		CommonsMultipartFile file = memberdto.getFile();
		if (file != null && file.getSize() > 0) { // 업로드한 파일이 하나라도 있다면
				String fname = file.getOriginalFilename(); // 파일명 얻기
				String path = request.getServletContext().getRealPath("/image/member");
				String fullpath = path + "\\" + fname;

				System.out.println(fname + " / " + path + " / " + fullpath);
				memberdto.setM_Image(fname);
//				request.getSession().removeAttribute("M_Image");
//				request.getSession().setAttribute("M_Image", fname);
//				System.out.println(request.getSession().getAttribute("M_Image"));
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
		try{
			result = service.profileChange(memberdto);
		
			if(result > 0) {
				System.out.println("프로필사진 변경 성공");
				
				r="success";
			}else {
				System.out.println("프로필사진 변경 실패");
				r="fail";
			}
	} catch (Exception e) {
		System.out.println("예외발생 : " +  e.getMessage());
		System.out.println("프로필사진 변경 실패");
		r="fail";
	}
	
	return r; //주의 (website/index.htm
	
}
	
	@RequestMapping("/nickch.htm")
	public @ResponseBody String nickChange(HttpServletRequest request,MemberDTO memberdto) throws IOException {
		String r = "";
		int result = 0;
		try{
			result = service.nickChange(memberdto);
		
			if(result > 0) {
				System.out.println("닉네임 변경 성공");
				if(request.getSession().getAttribute("m_Email").equals("admin@admin")) {
					r="admin";
				}else {
				r="success";
				}
			}else {
				System.out.println("닉네임 변경 실패");
				r="fail";
			}
	} catch (Exception e) {
		System.out.println("예외발생 : " +  e.getMessage());
		System.out.println("닉네임사진 변경 실패");
		r="fail";
	}
	
	return r; //주의 (website/index.htm
	
}
	
	@RequestMapping("/getpass.htm")
	public @ResponseBody String getpass(HttpServletRequest request,MemberDTO memberdto){
		String result = "";
		result = service.getPass(memberdto);
		boolean re = bCryptPasswordEncoder.matches(memberdto.getM_Pwd(), result);
		if(re) {
			result="success";
		}else {
			result="fail";
		}
	return result; //주의 (website/index.htm
	
}
	@RequestMapping("/delete.htm")
	public @ResponseBody String deleteMember(HttpServletRequest request,MemberDTO memberdto) throws IOException {
		String r = "";
		int result = 0;
		try {	result = service.deleteMember(memberdto);
			if(result > 0) {
				System.out.println("회원탈퇴성공");
					
				r="success";
			}else {
				System.out.println("회원탈퇴 실패");
				r="fail";
			}
	} catch (Exception e) {
		System.out.println("예외발생 : " +  e.getMessage());
		System.out.println("회원탈퇴 실패");
		r="fail";
	}
	
	return r; //주의 (website/index.htm
	
}
	
		
	@RequestMapping("/visited.htm")
	public String visited(HttpServletRequest request,Principal principal, Model model) {
		//return "visited.jsp"
		MemberDTO dto = new MemberDTO();
		request.getSession().setAttribute("tile", "tile");
		dto = service.mypageMember(principal.getName());
		
		//여행지 정보 가져오기
		List<TravelDTO> trDto = travelservice.getMapLatLng(principal.getName());
		System.out.println("List<TravelDTO> : " + trDto);
		model.addAttribute("dto", dto);
		model.addAttribute("trDto", trDto);
		return "mypage.visited";
	}
	
	
	@RequestMapping("/myfeedgowith.htm")
	public String myfeedgowith(HttpServletRequest request,Principal principal, Model model) throws SQLException {
		//return "myfeed.jsp"
		model.addAttribute("tile", "tile");
		String m_Email = principal.getName();
		List<GowithDTO> go = withservice.getWithListMypage(m_Email);
		System.out.println("---------->" + go);
		MemberDTO dto = new MemberDTO();
		dto = service.mypageMember(m_Email);
		System.out.println(dto.toString());
		model.addAttribute("dto", dto);
		model.addAttribute("go", go);
		return "mypage.myfeedgowith";
	}
	
	@RequestMapping("/myfeedreview.htm")
	public String myfeedreview(HttpServletRequest request,Principal principal, Model model) throws SQLException {
		//return "myfeed.jsp"
				request.getSession().setAttribute("tile", "tile");
				String m_Email = principal.getName();
				List<TravelDTO> go = travelservice.getReviewMypage(m_Email);
				MemberDTO dto = new MemberDTO();
				dto = service.mypageMember(m_Email);
				System.out.println(dto.toString());
				model.addAttribute("review", go);
				model.addAttribute("dto", dto);
				return "mypage.myfeedreview";
			}
	
	@RequestMapping("/schedule.htm")
	public String schedule(HttpServletRequest request,Principal principal, Model model) {
		//return "schedule.jsp"
		request.getSession().setAttribute("tile", "tile");
		MemberDTO dto = new MemberDTO();
		dto = service.mypageMember(principal.getName());
		model.addAttribute("dto", dto);
		return "mypage.schedule1";
	}
	
	@RequestMapping("/planreg.htm")
	public View planreg(HttpServletRequest request,Principal principal,PlanDTO plan, Model model) {
		//return "schedule.jsp"
		String m_Email = principal.getName();
		System.out.println(m_Email);
		System.out.println(plan.getP_Edate());
		plan.setM_Email(m_Email);
		int r = pservice.planreg(plan);
//		request.getSession().setAttribute("tile", "tile");
		String re="";
		model.addAttribute("p_Num", r);
		if(r>0)
		{
		 re="success";
		 System.out.println("잘됨");
		}
		else {
			re="fail";
		}
		
		return jsonview;
	}
	
	@RequestMapping("/planupdate.htm")
	public View planupdate(HttpServletRequest request,Principal principal,PlanDTO plan, Model model) {
		//return "schedule.jsp"
		String m_Email = principal.getName();
		System.out.println(m_Email);
		System.out.println(plan.getP_Edate());
		plan.setM_Email(m_Email);
		int r = pservice.planupdate(plan);
//		request.getSession().setAttribute("tile", "tile");
		String re="";
		model.addAttribute("p_Num", r);
		if(r>0)
		{
		 re="success";
		 PlanDTO sel =pservice.plansel(plan.getP_Num());
		 System.out.println("잘됨");
		 model.addAttribute("sel", sel);
		}
		else {
			re="fail";
		}
		
		return jsonview;
	}
	
	@RequestMapping("/plandel.htm")
	public @ResponseBody String plandel(HttpServletRequest request,int p_Num) {
		//return "schedule.jsp"
		int r = pservice.plandel(p_Num);
//		request.getSession().setAttribute("tile", "tile");
		String re="";
		if(r>0)
		{
		 re="success";
		 System.out.println("잘됨");
		}
		else {
			re="fail";
		}
		
		return re;
	}
	
	@RequestMapping("/planlist.htm")
	public View planlist(HttpServletRequest request,Principal principal, Model model) {
		String m_Email = principal.getName();
		List<PlanDTO> list = pservice.planlist(m_Email);
		
		model.addAttribute("list", list);
		return jsonview;
	}
	
	@RequestMapping("/friendlist.htm")
	public String friendlist(HttpServletRequest request,Principal principal, Model model) {
		//return "friendlist.jsp"
		MemberDTO dto = new MemberDTO();
		dto = service.mypageMember(principal.getName());
		model.addAttribute("dto", dto);
		request.getSession().setAttribute("tile", "tile");
		List<MemberDTO> md = joinservice.friendlist(principal.getName());
		model.addAttribute("member", md);
		model.addAttribute("dto", dto);
		return "mypage.friendlist";
	}
	
	
	@RequestMapping("/myreviewdetail.htm")
	public String myreviewdetail(int t_Num,Principal principal, Model model, HttpSession session) {
		//return "myreviewdetail.jsp"
		String m_Email = principal.getName();
		
		//get myinfo 
		MemberDTO dto = service.mypageMember(m_Email);

		//내가 이 글을 좋아하는지 여부
		LikeDTO like = new LikeDTO();
		like.setM_Email(m_Email);
		like.setT_Num(t_Num);
		int myLikeCnt = travelservice.checklike(like);

		//리뷰데이터 가져오기
		TravelDTO trDto = travelservice.getReviewDetail(t_Num);
		
		//좋아요 토탈 카운트
		int totalLikeCnt = travelservice.likecount(t_Num);
		List<TImageDTO> list1 = travelservice.getReviewImage(t_Num);
		//댓글데이터 가져오기
		List<ReplyDTO> reDto = travelservice.replylist(t_Num);
		
		model.addAttribute("dto", dto);
		
		model.addAttribute("list", trDto);
		
		model.addAttribute("image", list1);
		
		model.addAttribute("likecount", totalLikeCnt);
		
		model.addAttribute("reply", reDto);
		
		model.addAttribute("like", myLikeCnt);
		
		return "mypage.myreviewdetail";
	}
	
	@RequestMapping("/mygowithdetail.htm")
	public String mygowithdetail(int g_Num, Principal principal, HttpSession session, Model model) {
		
		//return "myreviewdetail.jsp"
		String m_Email = principal.getName();
				
		//get myinfo 
		MemberDTO dto = service.mypageMember(m_Email);
		
		GowithDTO gowithDTO = withservice.selectGowith(g_Num);
		List<go_ReplyDTO> reply = withservice.replylist(g_Num);
		model.addAttribute("dto",dto);
		model.addAttribute("dto1", gowithDTO);
		model.addAttribute("reply", reply);
		return "mypage.mygowithdetail";
	}
}
