package member.controller;

import java.sql.SQLException;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import common.controller.AbstractController;
import member.model.InterMemberDAO_HJE;
import member.model.MemberDAO_HJE;
import member.model.MemberVO_HJE;


public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
//			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		}
		
		else {
			String name = request.getParameter("name");
			String userid = request.getParameter("userid"); 
			String pwd = request.getParameter("pwd"); 
			String email = request.getParameter("email"); 
			String hp1 = request.getParameter("hp1"); 
			String hp2 = request.getParameter("hp2"); 
			String hp3 = request.getParameter("hp3"); 
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address"); 
			String detailAddress = request.getParameter("detailAddress"); 
			String extraAddress = request.getParameter("extraAddress"); 
			String birthyyyy = request.getParameter("birthyyyy"); 
			String birthmm = request.getParameter("birthmm"); 
			String birthdd = request.getParameter("birthdd");
			String height = request.getParameter("height");
			String weight = request.getParameter("weight");
			String topsize = request.getParameter("topsize");
			String bottomsize = request.getParameter("bottomsize");
			
			String mobile = hp1 + hp2 + hp3;
			String birthday = birthyyyy+"-"+birthmm+"-"+birthdd;
			
			MemberVO_HJE member = new MemberVO_HJE(userid, pwd, name, email, mobile, postcode, address, detailAddress, extraAddress, birthday, height, weight, topsize, bottomsize);

			/*
			try {
				InterMemberDAO mdao = new MemberDAO();
				int n = mdao.registerMember(member);
				System.out.println(n);
				
				if(n==1) {
					message = "???????????? ??????";
					loc = request.getContextPath()+"/index.go";	// ?????????????????? ????????????
				}
				else {
					
				}
			} catch (SQLException e) {
				e.printStackTrace();
				message = "SQL?????? ????????????11";
				loc = ":javascript:history.back()";	// ????????????????????? ????????? ?????????????????? ???????????? ???
			}

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			*/
			
			// ### ??????????????? ???????????? ???????????? ????????? ????????? ?????????
						
			try {
				InterMemberDAO_HJE mdao = new MemberDAO_HJE();
				int n = mdao.registerMember(member);
				
				if(n==1) {
					request.setAttribute("userid", userid);
					request.setAttribute("pwd", pwd);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/login/registerAfterAutoLogin.jsp");
				}
				else {
					
				}
			} catch (SQLException e) {
				e.printStackTrace();
				String message = "SQL?????? ????????????22";
				String loc = ":javascript:history.back()";	// ????????????????????? ????????? ?????????????????? ???????????? ???
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			} 

			
		}

	}

}
