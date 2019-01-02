package bitcamp.travelmaker.mail;

import java.io.StringWriter;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import bitcamp.travelmaker.dto.MemberDTO;
import bitcamp.travelmaker.service.JoinService;

@Service
public class MailService {
	@Autowired
	private JavaMailSenderImpl mailSender;
	@Autowired
	private VelocityEngine velocityEngine;
	@Autowired
	private JoinService service;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	HttpServletRequest request;

	public void setMailSender(JavaMailSenderImpl mailSender) {
		this.mailSender = mailSender;
	}

	public void setVelocityEngine(VelocityEngine velocityEngine) {
		this.velocityEngine = velocityEngine;
	}

	public String sendMail(String mailto,String command,MemberDTO memberdto) {
		Mail mail = new Mail();
		mail.setCompany("travelmaker");// 회사명
		mail.setMailFrom("Travelmaker");// 송신메일
		mail.setMailTo(mailto);// 수신메일
		String randomNum = this.randomNum();
		
		if (command == "mail.htm") {
			mail.setMailSubject("트레블메이커-회원가입 이메일");// 메일제목
			mail.setTemplateName("jointemplate.vm");// 메일내용
		} else {
			mail.setMailSubject("트레블메이커-임시비밀번호 이메일");// 메일제목
			mail.setTemplateName("logintemplate.vm");// 메일내용
		}

		// SimpleMailMessage message = new SimpleMailMessage();
		MimeMessage message = mailSender.createMimeMessage();
		
		MimeMessageHelper helper;
		try {
			// 멀티파트 메시지가 필요하다는 의미로 true 플래그를 사용한다
			helper = new MimeMessageHelper(message, true, "utf-8");
			helper.getEncoding();
			helper.setFrom(mail.getMailFrom());
			helper.setTo(mail.getMailTo());
			helper.setSubject(mail.getMailSubject());
		

			String pwd = this.randomPwd();
			VelocityContext velocityContext = new VelocityContext();
			velocityContext.put("firstName", mailto);
			velocityContext.put("id", "bit1004");
			velocityContext.put("company", mail.getCompany());
			velocityContext.put("mailFrom", mail.getMailFrom());
			velocityContext.put("randomNum", randomNum);
			velocityContext.put("randomPwd", pwd);
			memberdto.setM_Email(mailto); 
			System.out.println(mailto);
			System.out.println(pwd);
			System.out.println(pwd);
			memberdto.setM_Pwd(this.bCryptPasswordEncoder.encode(pwd));
			service.passChange(memberdto);
		
		//"./src/main/resources/templates/"
			Template template = velocityEngine.getTemplate(mail.getTemplateName());

			StringWriter stringWriter = new StringWriter();
			template.merge(velocityContext, stringWriter);
			
			helper.setText(stringWriter.toString(), true);
			
			
		/*	String text =VelocityEngineUtils.mergeTemplateIntoString(
					velocityEngine, "resources/templates/"+ mail.getTemplateName(), (Map) velocityContext);
					message.setContent(text, "text/html;charset=utf-8;");*/
		} catch (MessagingException e) {

		}

		mailSender.send(message);
		
		return randomNum;
		
	}

	public  String randomNum() {
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i <= 5; i++) {
			int n = (int) (Math.random() * 10);
			buffer.append(n);
		}
		return buffer.toString();
	}

	
	public  String randomPwd() { 
		char[] charSet = new char[] { 
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C',
				'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
				'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
				'!','@','#','$','%','^','&','*','(',')'};
		
		int idx = 0; 
		StringBuffer buffer = new StringBuffer(); 		
		for (int i = 0; i < 10; i++) { 
		idx = (int) (charSet.length * Math.random());
		// 36 * 생성된 난수를 Int로 추출 (소숫점제거) 
		buffer.append(charSet[idx]); 
		
		} 
		return buffer.toString(); 
	}
	


	
}