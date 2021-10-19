package mypage.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
 
import common.controller.AbstractController;
//import member.model.MemberVO_PJW;

public class OrderDetailListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		/*
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		}
		else {  */
		

//			HttpSession session = request.getSession();
			
//			MemberVO_PJW loginuser = (MemberVO_PJW) session.getAttribute("loginuser");
//			String userid = loginuser.getUserid();
//			String userid= request.getParameter("userid");
		
			String odrcode = request.getParameter("odrcode");
			request.setAttribute("odrcode", odrcode);
			
			
//		}

		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/orderDetailList.jsp");
		
	}

}
