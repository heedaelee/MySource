
package bitcamp.travelmaker.adminpage.controller;

import java.io.IOException;
import java.security.Principal;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.View;

import bitcamp.travelmaker.dto.BlacklistDTO;
import bitcamp.travelmaker.dto.MemberDTO;
import bitcamp.travelmaker.gowith.dto.GowithDTO;
import bitcamp.travelmaker.gowith.dto.go_ReplyDTO;
import bitcamp.travelmaker.gowith.service.GowithService;
import bitcamp.travelmaker.mypage.service.MypageMemberService;
import bitcamp.travelmaker.reviewpage.dto.LikeDTO;
import bitcamp.travelmaker.reviewpage.dto.ReplyDTO;
import bitcamp.travelmaker.reviewpage.dto.TImageDTO;
import bitcamp.travelmaker.reviewpage.dto.TravelDTO;
import bitcamp.travelmaker.reviewpage.service.TravelService;
import bitcamp.travelmaker.service.MemberService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AdminpageController {
	
	@Autowired
	private View jsonview;
	@Autowired
	private MemberService memberService;
	@Autowired
	private MypageMemberService mypageservice;
	@Autowired
	private GowithService gowithservice;
	@Autowired
	private TravelService travelService;
	
	
	@RequestMapping("/adminpage.htm")
	public String getMemberList(HttpServletRequest request,Principal principal,Model model) throws SQLException {
		MemberDTO dto = new MemberDTO();
		System.out.println(principal.getName());
		String m_Email = principal.getName();
		dto = mypageservice.mypageMember(m_Email);
		List<MemberDTO> member = memberService.getMemberList();
//		System.out.println("controller -----------> " + member);
		model.addAttribute("dto", dto);
		model.addAttribute("member", member);
		request.getSession().setAttribute("tile", "tile");
		
		return "adminpage.adminpage";
	}
	
	@RequestMapping("/deleteMember.htm")
	public @ResponseBody String adminDeleteMember(HttpServletRequest request,MemberDTO memberdto) throws IOException {
		
		String r = "";
		int result = 0;
		try {	result = mypageservice.deleteMember(memberdto);
			if(result > 0) {
				System.out.println("회원삭제 성공");
					
				r="success";
			}else {
				System.out.println("회원삭제 실패");
				r="fail";
			}
	} catch (Exception e) {
		System.out.println("예외발생 : " +  e.getMessage());
		System.out.println("회원탈퇴 실패");
		r="fail";
	}
	
	return r; //주의 (website/index.htm
	
	}
	
	@RequestMapping("/memberfeed.htm")
	public String memberfeed(HttpServletRequest request,Principal principal, Model model) throws SQLException {
		//관리자 자신의 데이터를 가져오는 부분
		model.addAttribute("tile","tile");
		String m_Email = principal.getName();
		MemberDTO dto = new MemberDTO();
		dto = mypageservice.mypageMember(m_Email);
		model.addAttribute("dto",dto);
		
		//클릭한 회원의 정보를 가져오는 부분
		String m_Email2 = request.getParameter("m_Email");
		MemberDTO dto2 = new MemberDTO();
		dto2 = mypageservice.mypageMember(m_Email2);
		System.out.println(m_Email2);
		model.addAttribute("dto2",dto2);
		
		//함께가기 데이터를 가져오는 부분
		List<GowithDTO> go = gowithservice.getWithListAdmin(m_Email2);
		model.addAttribute("go", go);

		return "adminpage.memberfeed";
}
	
	@RequestMapping("/memberfeeddetail.htm")
	public String mygowithdetail(int g_Num, Principal principal, HttpSession session, Model model) {
		
		//return "myreviewdetail.jsp"
		String m_Email = principal.getName();
				
		//get myinfo 
		MemberDTO dto = mypageservice.mypageMember(m_Email);
		
		GowithDTO gowithDTO = gowithservice.selectGowith(g_Num);
		List<go_ReplyDTO> reply = gowithservice.replylist(g_Num);
		model.addAttribute("dto",dto);
		model.addAttribute("dto1", gowithDTO);
		model.addAttribute("reply", reply);
		return "adminpage.memberfeeddetail";
	}
	
	@RequestMapping("/memberreview.htm")
	public String memberreview(HttpServletRequest request,Principal principal, Model model) throws SQLException {
		//관리자 자신의 데이터를 가져오는 부분
		model.addAttribute("tile","tile");
		String m_Email = principal.getName();
		MemberDTO dto = new MemberDTO();
		dto = mypageservice.mypageMember(m_Email);
		model.addAttribute("dto",dto);
				
		//클릭한 회원의 정보를 가져오는 부분
		String m_Email2 = request.getParameter("m_Email");
		MemberDTO dto2 = new MemberDTO();
		dto2 = mypageservice.mypageMember(m_Email2);
		System.out.println(m_Email2);
		model.addAttribute("dto2",dto2);
				
		//리뷰 데이터를 가져오는 부분
		List<TravelDTO> review = travelService.getReviewAdmin(m_Email2);
		model.addAttribute("review", review);
				
		return "adminpage.memberreview";
	}
	
	@RequestMapping("/memberreviewdetail.htm")
	public String myreviewdetail(int t_Num,Principal principal, Model model, HttpSession session) {
		//return "myreviewdetail.jsp"
		String m_Email = principal.getName();
		
		//get myinfo 
		MemberDTO dto = mypageservice.mypageMember(m_Email);

		//내가 이 글을 좋아하는지 여부
		LikeDTO like = new LikeDTO();
		like.setM_Email(m_Email);
		like.setT_Num(t_Num);
		int myLikeCnt = travelService.checklike(like);

		//리뷰데이터 가져오기
		TravelDTO trDto = travelService.getReviewDetail(t_Num);
		
		//좋아요 토탈 카운트
		int totalLikeCnt = travelService.likecount(t_Num);
		
		//댓글 데이터 가져오기
		List<ReplyDTO> reDto = travelService.replylist(t_Num);
		
		//이미지 데이터 가져오기
		List<TImageDTO> list1 = travelService.getReviewImage(t_Num);
		
		model.addAttribute("dto", dto);
		
		model.addAttribute("list", trDto);
		
		model.addAttribute("likecount", totalLikeCnt);
		
		model.addAttribute("reply", reDto);
		
		model.addAttribute("like", myLikeCnt);
		
		model.addAttribute("image",list1);
		
		return "adminpage.memberreviewdetail";
	}
	
// 회원 검색 ajax
	@RequestMapping(value="/search.htm")
	public View searchMember(String selectbox, String keyword, Model model){
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("selectbox", selectbox);
		map.put("keyword", keyword);
		System.out.println(map);
		
		List<MemberDTO> search = memberService.searchMember(map);
		model.addAttribute("search", search);
		
		return jsonview;
		
	}
	
	@RequestMapping("/blacklist.htm")
	public String blacklist(HttpServletRequest request, Principal principal, Model model) throws SQLException {
		
		MemberDTO dto = new MemberDTO();
		String m_Email = principal.getName();
		dto = mypageservice.mypageMember(m_Email);
		List<BlacklistDTO> black = memberService.getBlackList();
		model.addAttribute("dto", dto);
		model.addAttribute("black", black);
		
		return "adminpage.blacklist";
	}
	
	@RequestMapping(value="/blackinsert.htm", method=RequestMethod.POST)
	public @ResponseBody String blackinsert(HttpServletRequest request, BlacklistDTO dto) throws SQLException {
		
		String r = "";
		int result = 0;
		try{
			result = memberService.blackinsert(dto);
			System.out.println("-----controller------ " + dto.toString());
		
			if(result > 0) {
				System.out.println("닉네임 변경 성공");
					r="success";
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
	
	@RequestMapping("/deleteblack.htm")
	public View deleteblack(HttpServletRequest request,int b_Num,Model model) {

		int re = 0;
		re = memberService.deleteblack(b_Num);
		if(re > 0) {
			List<BlacklistDTO> black = memberService.getBlackList();
			model.addAttribute("black", black);
		}
		else {
			model.addAttribute("fail", "fail");
		}
		//return "index.jsp";
		return jsonview;
	}
	
	@RequestMapping("/adminDeleteMember.htm")
	public View adminDeleteMember(HttpServletRequest request, String m_Email, Model model) throws Exception {
		
		int re = 0;
		re = memberService.adminDeleteMember(m_Email);
		if(re > 0) {
			List<MemberDTO> member = memberService.getMemberList();
			model.addAttribute("member", member);
		}
		else {
			model.addAttribute("fail", "fail");
		}
		//return "index.jsp";
		return jsonview;
	}
	
	@RequestMapping("/memberreport.htm")
	public String memberReport(HttpServletRequest request, Principal principal, Model model) throws SQLException {
		request.getSession().setAttribute("tile", "tile");
		
		System.out.println("memberreport hello~~");
		MemberDTO dto = new MemberDTO();
		String m_Email = principal.getName();
		dto = mypageservice.mypageMember(m_Email);
		
		List<MemberDTO> report = memberService.memberReport();
		int count = memberService.countMember();
		System.out.println("controller -----------> " + report);
		
		model.addAttribute("dto", dto);
		model.addAttribute("report", report);
		model.addAttribute("count", count);
		
		return "adminpage.memberreport";
	}
	
	@RequestMapping("/travelreport.htm")
	public String travelReport(HttpServletRequest request, Principal principal, Model model) throws SQLException {
		request.getSession().setAttribute("tile", "tile");

		MemberDTO dto = new MemberDTO();
		String m_Email = principal.getName();
		dto = mypageservice.mypageMember(m_Email);
		List<TravelDTO> report = travelService.travelReport();
		System.out.println("controller -----------> " + report);
		
		model.addAttribute("dto", dto);
		model.addAttribute("report", report);
		
		return "adminpage.travelreport";
	}
	
	@RequestMapping("/blackcheck.htm")
	public @ResponseBody String blackcheck(HttpServletRequest request,String m_Email,Model model) throws SQLException {
		String re="";
		int result = memberService.blackcheck(m_Email);
		if(result>0) {
			re="success";
		}else {
			re="fail";
		}
		return re;
	}
	
	
}
