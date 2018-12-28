package bitcamp.travelmaker.gowith.controller;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import bitcamp.travelmaker.dto.MemberDTO;
import bitcamp.travelmaker.gowith.dto.GowithDTO;
import bitcamp.travelmaker.gowith.dto.go_ReplyDTO;
import bitcamp.travelmaker.gowith.service.GowithService;
import bitcamp.travelmaker.mypage.service.MypageMemberService;
import bitcamp.travelmaker.paging.PagingVo;

@Controller
public class GowithController {

	@Autowired
	private View jsonview;

	@Autowired
	private GowithService gowithService;
	
	@Autowired
	private MypageMemberService tservice;
	
	

	@RequestMapping(value = "/gowith_list.htm", method = { RequestMethod.POST, RequestMethod.GET })
	public String gowith_list(Model model,Principal principal, PagingVo paging) {
		System.out.println("뷰->컨트롤러  : " + paging.toString());
		MemberDTO dto = new MemberDTO();
		if(principal!=null) {
			String m_Email = principal.getName();
			dto = tservice.mypageMember(m_Email);
			model.addAttribute("dto", dto);
		}
		List<GowithDTO> list = gowithService.selectAllGowith(paging);// 모든 게시물 조회
		int totalCount = gowithService.totalSelect(paging);
		System.out.println("서비스 다음 총갯수" + totalCount);
		paging.setTotal(totalCount);// 조회한 전체 총 게시물 개수를 페이징 bean에 넣어주고 계산

		model.addAttribute("list", list);
		model.addAttribute("p", paging);
		model.addAttribute("total", totalCount);

		System.out.println("리스트 : " + list.toString());
		System.out.println("페이징 : " + paging.toString());
		System.out.println("게시글 총갯수 : " + totalCount);

		return "gowith.gowith_list";
	}
	
	//참여 가능만 select list
	@RequestMapping(value = "/joinlist.htm", method = { RequestMethod.POST })
	public View joinList(Model model, PagingVo paging) {
		
		List<GowithDTO> list = gowithService.selectAllGowith(paging);
		int totalCount = gowithService.totalSelect(paging);
		System.out.println("서비스 다음 총갯수" + totalCount);
		System.out.println("서비스 다음 총갯수" + totalCount);
		paging.setTotal(totalCount);// 조회한 전체 총 게시물 개수를 페이징 bean에 넣어주고 계산

		model.addAttribute("list", list);
		model.addAttribute("p", paging);
		model.addAttribute("total", totalCount);

		System.out.println("리스트 : " + list.toString());
		System.out.println("페이징 : " + paging.toString());
		System.out.println("게시글 총갯수 : " + totalCount);

		return jsonview;
	}
	

	@RequestMapping(value = "/gowith_update.htm", method = { RequestMethod.GET })
	public String gowith_update(int g_Num, Model model) {

		// 조회증가&상세조회
		GowithDTO gowithDTO = gowithService.selectGowith(g_Num);

		System.out.println("업데이트 출력images : " + gowithDTO.getGi_Images().toString());
		System.out.println("업데이트 출력값" + gowithDTO.toString());
		model.addAttribute("dto1", gowithDTO);

		return "gowith.gowith_update";
	}

	@RequestMapping(value = "/gowith_update.htm", method = { RequestMethod.POST })
	public String updateGowith(MultipartHttpServletRequest request, GowithDTO gowithDTO, Model model) throws Exception {
		System.out.println("수정 컨트롤러 던지기 전: " + gowithDTO.toString());
		int r = gowithService.updateGowith(request, gowithDTO);
		int g_Num = gowithDTO.getG_Num();
		String result = "";
		if (r > 0) {
			result = "success";
		} else {
			result = "fail";
		}
		model.addAttribute(result);

		return "redirect:gowith_detail.htm?g_Num=" + g_Num;
	}

	@RequestMapping(value = "/deleteGo.htm", method = { RequestMethod.POST })
	public @ResponseBody String deleteGo(@RequestParam("g_Num") int g_Num) throws Exception {
		String result = "";
		gowithService.deleteGowith(g_Num);
		result = "success";

		return result;
	}

	@RequestMapping("/gowith_detail.htm")
	public String gowith_detail(int g_Num,Principal principal, Model model) {
		
		model.addAttribute("tile","tile");
		String m_Email = principal.getName();
		MemberDTO dto = new MemberDTO();
		dto = tservice.mypageMember(m_Email);
		model.addAttribute("dto",dto);
		
		// 조회증가&상세조회
		GowithDTO gowithDTO = gowithService.selectGowith(g_Num);
		List<go_ReplyDTO> reply = gowithService.replylist(g_Num);
		System.out.println("images : " + gowithDTO.getGi_Images().toString());
		System.out.println("디테일 " + gowithDTO.toString());
		model.addAttribute("dto1", gowithDTO);
		model.addAttribute("reply", reply);

		return "gowith.gowith_detail";
	}

	@RequestMapping("/gowith_write.htm")
	public String gowith_write() {
		return "gowith.gowith_write";
	}

	@RequestMapping(value = "/application.htm", method = { RequestMethod.POST })
	public View applicaition(String num, String m_Email, Model model) {
		/* System.out.println("어플 컨" +num + m_Email); */
		int g_Num = Integer.parseInt(num);

		List<HashMap<String, Object>> appList = gowithService.application(g_Num, m_Email);
		model.addAttribute("appList", appList);
		System.out.println("앱리스트" + appList.toString());

		return jsonview;
	}

	@RequestMapping(value = "/appselect.htm", method = { RequestMethod.POST })
	public View appselect(String num, Model model) {
		/* System.out.println("어플 컨" +num + m_Email); */
		int g_Num = Integer.parseInt(num);

		List<HashMap<String, Object>> appList = gowithService.appselect(g_Num);
		model.addAttribute("appList", appList);

		return jsonview;
	}

	// 참여하기 -성별체크
	@RequestMapping(value = "/genderCheck.htm", method = { RequestMethod.POST })
	public View genderCheck(String m_Email, Model model) {
		/* System.out.println("어플 컨" +num + m_Email); */
		String m_Gender = "";
		m_Gender = gowithService.genderCheck(m_Email);
		model.addAttribute("m_Gender", m_Gender);

		return jsonview;
	}
	


	// list<Hashmap(string,object> list 기능
	@RequestMapping(value = "/cancel.htm", method = { RequestMethod.POST })
	public View cancel(String num, String m_Email, Model model) {
		System.out.println("참여 취소 컨트롤러(num/email) : " + num + m_Email);
		int g_Num = Integer.parseInt(num);

		gowithService.cancel(g_Num, m_Email);
		return jsonview;
	}
	
	@RequestMapping("/go_replyreg.htm")
	public View replyreg(HttpServletRequest request,go_ReplyDTO reply,Model model){
		MemberDTO dto = new MemberDTO();
		String m_Email = (String)request.getSession().getAttribute("m_Email");
		System.out.println(m_Email);
		dto = tservice.mypageMember(m_Email);
//		model.addAttribute("dto", dto);
		reply.setM_Email(m_Email);
		System.out.println(reply.toString());
		int result = gowithService.replyreg(reply);
		List<go_ReplyDTO> reple = new ArrayList<go_ReplyDTO>();;
		if(result>0) {
			 reple = gowithService.replylist(reply.getG_Num());
			 model.addAttribute("reply", reple);
		}
		
		return jsonview;
	}
	
	@RequestMapping("/go_rerereg.htm")
	public View rerereg(HttpServletRequest request,go_ReplyDTO reply,Model model){
		MemberDTO dto = new MemberDTO();
		String m_Email = (String)request.getSession().getAttribute("m_Email");
		System.out.println(m_Email);
		dto = tservice.mypageMember(m_Email);
//		model.addAttribute("dto", dto);
		reply.setM_Email(m_Email);
		System.out.println(reply.getJ_Order());
		System.out.println(reply.toString());
		int result = gowithService.rerereg(reply);
		List<go_ReplyDTO> reple = new ArrayList<go_ReplyDTO>();;
		if(result>0) {
			 reple = gowithService.replylist(reply.getG_Num());
			 model.addAttribute("reply", reple);
		}
		
		return jsonview;
	}
	
	@RequestMapping("/go_replylist.htm")
	public View replylist(HttpServletRequest request,go_ReplyDTO reply,Model model){
		MemberDTO dto = new MemberDTO();
		String m_Email = (String)request.getSession().getAttribute("m_Email");
		System.out.println(m_Email);
		dto = tservice.mypageMember(m_Email);
//		model.addAttribute("dto", dto);
		reply.setM_Email(m_Email);
		System.out.println(reply.getJ_Order());
		System.out.println(reply.toString());
		List<go_ReplyDTO> reple = new ArrayList<go_ReplyDTO>();;
		 reple = gowithService.replylist(reply.getG_Num());
		 model.addAttribute("reply", reple);
		
		
		return jsonview;
	}
	
	@RequestMapping("/go_replyupdate.htm")
	public View replyupdate(HttpServletRequest request,go_ReplyDTO reply,Model model){
		MemberDTO dto = new MemberDTO();
		String m_Email = (String)request.getSession().getAttribute("m_Email");
		System.out.println(m_Email);
		dto = tservice.mypageMember(m_Email);
//		model.addAttribute("dto", dto);
		reply.setM_Email(m_Email);
		System.out.println(reply.toString());
		int result = gowithService.replyupdate(reply);
		List<go_ReplyDTO> reple = new ArrayList<go_ReplyDTO>();;
		if(result>0) {
			 reple = gowithService.replylist(reply.getG_Num());
			 model.addAttribute("reply", reple);
		}
		
		return jsonview;
	}
	
	@RequestMapping("/go_replydelete.htm")
	public View replydelete(HttpServletRequest request,go_ReplyDTO reply,Model model){
		MemberDTO dto = new MemberDTO();
		String m_Email = (String)request.getSession().getAttribute("m_Email");
		System.out.println(m_Email);
		dto = tservice.mypageMember(m_Email);
//		model.addAttribute("dto", dto);
		reply.setM_Email(m_Email);
		System.out.println(reply.toString());
		int result = gowithService.replydelete(reply.getJ_Num());
		List<go_ReplyDTO> reple = new ArrayList<go_ReplyDTO>();;
		if(result>0) {
			 reple = gowithService.replylist(reply.getG_Num());
			 model.addAttribute("reply", reple);
		}
		
		return jsonview;
	}

}
