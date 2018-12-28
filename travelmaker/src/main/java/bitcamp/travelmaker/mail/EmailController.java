package bitcamp.travelmaker.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import bitcamp.travelmaker.dto.MemberDTO;

@Controller
public class EmailController {

	@Autowired
	public MailService mailer;
	
	
	@RequestMapping(value = "/mail.htm",  method = RequestMethod.POST)
	public @ResponseBody String join(String mailto,MemberDTO memberdto) {
		
		String randomNum = mailer.sendMail(mailto, "mail.htm",memberdto);// 회원가입 메일발송
		System.out.println("randomNum>>"+randomNum);
		return randomNum;
	}

	@RequestMapping(value = "/pwd.htm")
	public @ResponseBody String pwd(String mailto,MemberDTO memberdto) {
		mailer.sendMail(mailto,"loginfail",memberdto);// 로그인 실패 비밀번호 찾기 메일발송
		return "/WEB-INF/views/home.jsp";
	}
}
