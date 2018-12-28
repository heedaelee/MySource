package bitcamp.travelmaker.security;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import bitcamp.travelmaker.dto.MemberDTO;
import bitcamp.travelmaker.service.MemberService;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	@Autowired
	private MemberService service;
	
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response, Authentication auth)
            throws IOException, ServletException {
        // TODO Auto-generated method stub
        System.out.println(auth.getAuthorities().getClass().getName());
        System.out.println("로그인성공");
        System.out.println(request.getParameter("m_Email"));
        request.getSession().setAttribute("m_Email",request.getParameter("m_Email") );
        MemberDTO list = service.getMember(request.getParameter("m_Email"));
        request.getSession().setAttribute("m_Nickname", list.getM_Nickname());
        request.getSession().setAttribute("m_Image", list.getM_Image());
        request.getSession().setAttribute("m_Gender", list.getM_Gender());
        request.getSession().setAttribute("social", "false");
        System.out.println(list.getM_Gender());
        System.out.println(list.getM_Image());
        System.out.println(list.getM_Nickname());
        List<GrantedAuthority> authorities = (List<GrantedAuthority>) auth.getAuthorities();
        String strAuth = authorities.get(0).getAuthority();
        
        Cookie cookie = new Cookie("auth", strAuth);
        cookie.setPath("/");
        // ���߿� ������Ƽ�� ����
//        cookie.setDomain("test.com");
        response.addCookie(cookie);
        response.sendRedirect(request.getContextPath() +  "/index.htm");
        
        
    }
 
}
