package bitcamp.travelmaker.reviewpage.controller;

import java.io.FileOutputStream;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.View;

import bitcamp.travelmaker.dto.MemberDTO;
import bitcamp.travelmaker.mypage.service.MypageMemberService;
import bitcamp.travelmaker.paging.PagingVo;
import bitcamp.travelmaker.reviewpage.dto.LikeDTO;
import bitcamp.travelmaker.reviewpage.dto.ReplyDTO;
import bitcamp.travelmaker.reviewpage.dto.TImageDTO;
import bitcamp.travelmaker.reviewpage.dto.TravelDTO;
import bitcamp.travelmaker.reviewpage.service.TravelService;

@Controller
public class TravelController {
	
	@Autowired
	private View jsonview;
	
	@Autowired
	private TravelService service;
	
	@Autowired
	private MypageMemberService tservice;
	
	@RequestMapping("/reviewlist.htm")
	public String reviewlist(HttpServletRequest request,Principal principal, PagingVo paging, Model model) {
		MemberDTO dto = new MemberDTO();
		if(principal!=null) {
		String m_Email = principal.getName();
		dto = tservice.mypageMember(m_Email);
		model.addAttribute("dto", dto);
//		model.addAttribute("social", "no");
		}
		List<TravelDTO> list = service.getReviewList(paging);
		int totalcount = service.allReview();
		paging.setTotal(totalcount);
		model.addAttribute("p", paging);
		model.addAttribute("total", totalcount);
		System.out.println(list.toString());
		//return "index.jsp";
		model.addAttribute("reviewlist",list);
		
		return "review.reviewlist";
	}
	
	@RequestMapping("/reviewlike.htm")
	public View reviewlike(HttpServletRequest request, PagingVo paging,Model model) {
//		MemberDTO dto = new MemberDTO();
//		String m_Email = (String)request.getSession().getAttribute("m_Email");
//		dto = tservice.mypageMember(m_Email);
		List<TravelDTO> list = service.getReviewLike(paging);
		int totalcount = service.allReview();
		paging.setTotal(totalcount);
		model.addAttribute("p", paging);
		model.addAttribute("total", totalcount);
//		model.addAttribute("dto", dto);
		System.out.println(list.toString());
		//return "index.jsp";
		model.addAttribute("reviewlist",list);
		
		return jsonview;
	}
	
	@RequestMapping("/reviewhit.htm")
	public View reviewhit(HttpServletRequest request, PagingVo paging,Model model) {
//		MemberDTO dto = new MemberDTO();
//		String m_Email = (String)request.getSession().getAttribute("m_Email");
//		dto = tservice.mypageMember(m_Email);
		List<TravelDTO> list = service.getReviewhit(paging);
		int totalcount = service.allReview();
		paging.setTotal(totalcount);
		model.addAttribute("p", paging);
		model.addAttribute("total", totalcount);
//		model.addAttribute("dto", dto);
		System.out.println(list.toString());
		//return "index.jsp";
		model.addAttribute("reviewlist",list);
		
		return jsonview;
	}
	
	@RequestMapping("/reviewsearch.htm")
	public View reviewsearch(String type,String search,Model model) {
//		MemberDTO dto = new MemberDTO();
//		String m_Email = (String)request.getSession().getAttribute("m_Email");
//		dto = tservice.mypageMember(m_Email);
		Map<String,String> map = new HashMap<String,String>();
		map.put("type",type);
		map.put("search",search);
		System.out.println(map);
		List<TravelDTO> list = service.reviewSearch(map);
//		model.addAttribute("dto", dto);
		System.out.println(list.toString());
		//return "index.jsp";
		model.addAttribute("reviewlist",list);
		
		return jsonview;
	}
	
	@RequestMapping("/reviewdetail.htm")
	public String reviewdetail(HttpServletRequest request,Principal principal,int t_Num,Model model) {
		MemberDTO dto = new MemberDTO();
		LikeDTO like = new LikeDTO();
		if(principal!=null) {
			String m_Email = principal.getName();
			dto = tservice.mypageMember(m_Email);
			model.addAttribute("dto", dto);
			like.setM_Email(m_Email);
			like.setT_Num(t_Num);
			int check = service.checklike(like);
			model.addAttribute("like", check);
//			model.addAttribute("social", "no");
		}
		System.out.println(t_Num);
		int likecount = service.likecount(t_Num);
		model.addAttribute("likecount", likecount);
		TravelDTO list = service.getReviewDetail(t_Num);
		List<TImageDTO> list1 = service.getReviewImage(t_Num);
		List<ReplyDTO> list2 = service.replylist(t_Num);
		model.addAttribute("dto", dto);
		model.addAttribute("list",list);
		model.addAttribute("image", list1);
		model.addAttribute("reply", list2);
		//return "index.jsp";
		return "review.reviewdetail";
	}
	
	
	@RequestMapping("/reviewUpdate.htm")
	public String reviewUpdate(HttpServletRequest request,Principal principal,int t_Num,Model model) {
		MemberDTO dto = new MemberDTO();
		if(principal!=null) {
			String m_Email = principal.getName();
			dto = tservice.mypageMember(m_Email);
			model.addAttribute("dto", dto);
//			model.addAttribute("social", "no");
		}
		TravelDTO list = service.getReviewDetail(t_Num);
		List<TImageDTO> list1 = service.getReviewImage(t_Num);
		model.addAttribute("list",list);
		model.addAttribute("image", list1);
		//return "index.jsp";
		return "review.reviewupdate";
	}
	
	@RequestMapping("/reviewupdatereg.htm")
	public @ResponseBody String reviewupdatereg(HttpServletRequest request,Principal principal,TImageDTO tidto,TravelDTO traveldto, Model model) throws Exception {
		MemberDTO dto = new MemberDTO();
		if(principal!=null) {
			String m_Email = principal.getName();
			dto = tservice.mypageMember(m_Email);
			traveldto.setM_Email(m_Email);
			model.addAttribute("dto", dto);
//			model.addAttribute("social", "no");
		}
		CommonsMultipartFile file = traveldto.getFile();
		if (file != null && file.getSize() > 0) { // 업로드한 파일이 하나라도 있다면
				String fname = file.getOriginalFilename(); // 파일명 얻기
				String path = request.getServletContext().getRealPath("/image/review/main");
				String fullpath = path + "\\" + fname;
				
				System.out.println(fname + " / " + path + " / " + fullpath);
				traveldto.setT_Image(fname);
				if (!fname.equals("")) {
					// 서버에 파일 쓰기 작업
					FileOutputStream fs = new FileOutputStream(fullpath);
					fs.write(file.getBytes());
					fs.close();
				}
				 // 실 DB Insert 작업시 .. 파일명
			}
		
		int r= service.reviewupdatereg(traveldto);
		service.reviewImgDel(Integer.parseInt(request.getParameter("t_Num")));
		List<CommonsMultipartFile> files = tidto.getFiles();
		List<String> filenames = new ArrayList<String>(); // 파일명만 추출
		if (files.get(0).getOriginalFilename().trim() != "" && files.size() > 0) { // 업로드한 파일이 하나라도 있다면

			for (CommonsMultipartFile multipartfile : files) {

				String fname = multipartfile.getOriginalFilename(); // 파일명 얻기
				String path = request.getServletContext().getRealPath("/image/review");
				String fullpath = path + "\\" + fname;

				System.out.println(fname + " / " + path + " / " + fullpath);
				tidto.setTi_Image(fname);
				service.imagereg(tidto);
				if (!fname.equals("")) {
					// 서버에 파일 쓰기 작업
					FileOutputStream fs = new FileOutputStream(fullpath);
					fs.write(multipartfile.getBytes());
					fs.close();
				}
				filenames.add(fname); // 실 DB Insert 작업시 .. 파일명
			}

		}else {
			String str = request.getParameter("oriImage");
			String [] words = str.split(",");
			for(String wo : words) {
				tidto.setTi_Image(wo);
				service.imagereg(tidto);
			}
		}
		
		String result="";
		if(r>0) {
			result="success";
		}else {
			result="fail";
		}
		//return "index.jsp";
		return result;
	}
	
	
	
	@RequestMapping("/reviewwritereg.htm")
	public @ResponseBody String reviewwritereg(HttpServletRequest request,Principal principal,TImageDTO tidto,TravelDTO traveldto, Model model) throws Exception {
		MemberDTO dto = new MemberDTO();
		if(principal!=null) {
			String m_Email = principal.getName();
			traveldto.setM_Email(m_Email);
			dto = tservice.mypageMember(m_Email);
			model.addAttribute("dto", dto);
//			model.addAttribute("social", "no");
			}
		System.out.println(tidto.toString());
		int t_Num= 0;
		System.out.println(traveldto.toString());
		CommonsMultipartFile file = traveldto.getFile();
		if (file != null && file.getSize() > 0) { // 업로드한 파일이 하나라도 있다면
				String fname = file.getOriginalFilename(); // 파일명 얻기
				String path = request.getServletContext().getRealPath("/image/review/main");
				String fullpath = path + "\\" + fname;
				
				System.out.println(fname + " / " + path + " / " + fullpath);
				traveldto.setT_Image(fname);
				if (!fname.equals("")) {
					// 서버에 파일 쓰기 작업
					FileOutputStream fs = new FileOutputStream(fullpath);
					fs.write(file.getBytes());
					fs.close();
				}
				 // 실 DB Insert 작업시 .. 파일명
			}
		
		t_Num = service.reviewwritereg(traveldto);
		tidto.setT_Num(t_Num);
		List<CommonsMultipartFile> files = tidto.getFiles();
		List<String> filenames = new ArrayList<String>(); // 파일명만 추출
		
		if (files != null && files.size() > 0) { // 업로드한 파일이 하나라도 있다면

			for (CommonsMultipartFile multipartfile : files) {

				String fname = multipartfile.getOriginalFilename(); // 파일명 얻기
				String path = request.getServletContext().getRealPath("/image/review");
				String fullpath = path + "\\" + fname;

				System.out.println(fname + " / " + path + " / " + fullpath);
				tidto.setTi_Image(fname);
				service.imagereg(tidto);
				if (!fname.equals("")) {
					// 서버에 파일 쓰기 작업
					FileOutputStream fs = new FileOutputStream(fullpath);
					fs.write(multipartfile.getBytes());
					fs.close();
				}
				filenames.add(fname); // 실 DB Insert 작업시 .. 파일명
			}

		}
		
		
		String r="";
		if(t_Num>0) {
			r="success";
		}else {
			r="fail";
		}
		//return "index.jsp";
		return r;
	}
	
	@RequestMapping("/reviewwrite.htm")
	public String reviewwrite(Principal principal, Model model){
		MemberDTO dto = new MemberDTO();
		if(principal!=null) {
			String m_Email = principal.getName();
			dto = tservice.mypageMember(m_Email);
			model.addAttribute("dto", dto);
//			model.addAttribute("social", "no");
		}
		return "review.reviewwrite";
	}
	
	@RequestMapping("/replyreg.htm")
	public View replyreg(Principal principal,ReplyDTO reply,Model model){	
		String m_Email = principal.getName();
		reply.setM_Email(m_Email);
		System.out.println(reply.toString());
		int result = service.replyreg(reply);
		List<ReplyDTO> reple = new ArrayList<ReplyDTO>();;
		if(result>0) {
			 reple = service.replylist(reply.getT_Num());
			 model.addAttribute("reply", reple);
		}
		
		return jsonview;
	}
	
	@RequestMapping("/rerereg.htm")
	public View rerereg(Principal principal,ReplyDTO reply,Model model){
		String m_Email = principal.getName();
		reply.setM_Email(m_Email);
		int result = service.rerereg(reply);
		List<ReplyDTO> reple = new ArrayList<ReplyDTO>();;
		if(result>0) {
			 reple = service.replylist(reply.getT_Num());
			 model.addAttribute("reply", reple);
		}
		
		return jsonview;
	}
	
	@RequestMapping("/replylist.htm")
	public View replylist(Principal principal,ReplyDTO reply,Model model){
		String m_Email = principal.getName();
		reply.setM_Email(m_Email);
		List<ReplyDTO> reple = new ArrayList<ReplyDTO>();;
		 reple = service.replylist(reply.getT_Num());
		 model.addAttribute("reply", reple);
		
		
		return jsonview;
	}
	
	@RequestMapping("/replyupdate.htm")
	public View replyupdate(Principal principal,ReplyDTO reply,Model model){
		String m_Email = principal.getName();
		reply.setM_Email(m_Email);
		int result = service.replyupdate(reply);
		List<ReplyDTO> reple = new ArrayList<ReplyDTO>();;
		if(result>0) {
			 reple = service.replylist(reply.getT_Num());
			 model.addAttribute("reply", reple);
		}
		
		return jsonview;
	}
	
	@RequestMapping("/replydelete.htm")
	public View replydelete(Principal principal,ReplyDTO reply,Model model){
		String m_Email =  principal.getName();
		reply.setM_Email(m_Email);
		int result = service.replydelete(reply.getR_Num());
		List<ReplyDTO> reple = new ArrayList<ReplyDTO>();;
		if(result>0) {
			 reple = service.replylist(reply.getT_Num());
			 model.addAttribute("reply", reple);
		}
		
		return jsonview;
	}
	
	@RequestMapping("/deletereview.htm")
	public @ResponseBody String deletereview(HttpServletRequest request,int t_Num,Model model) throws Exception {
		System.out.println(t_Num);
//		System.out.println(m_Email);
		int re= 0;
		String r = "";
//		service.deletegood(t_Num);
//		service.deletereviewreple(t_Num);
//		service.reviewImgDel(t_Num);
		re = service.deletereview(t_Num);
		if(re>0) {
			r="success";
		}else {
			r="fail";
		}
		//return "index.jsp";
		return r;
	}
	
	@RequestMapping("/like.htm")
	public View like(Principal principal,LikeDTO like, Model model){
//		MemberDTO dto = new MemberDTO();
		String m_Email = principal.getName();
		like.setM_Email(m_Email);
		int result =0;
		int re=0;
		try {
			result = service.likereg(like);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(result>0) {
			re = service.likecount(like.getT_Num());
			System.out.println(re); 
			model.addAttribute("likecount", re);
		}else {
			re = 0;
		}
		return jsonview;
	}
	
	@RequestMapping("/unlike.htm")
	public View unlike(Principal principal,LikeDTO like, Model model){
		String m_Email =  principal.getName();
		like.setM_Email(m_Email);
		int re=0;
		int result=0;
		try {
			result = service.likedel(like);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(result>0) {
			re = service.likecount(like.getT_Num());
			System.out.println(re); 
			model.addAttribute("likecount", re);
		}else {
			re = 0;
		}
		return jsonview;
	}
	
	
}
