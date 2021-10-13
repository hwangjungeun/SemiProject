package mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class OrderListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		/*
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		}
		else {  */
			String datepicker1 = request.getParameter("datepicker1");
			String datepicker2 = request.getParameter("datepicker2");
			String datepicker3 = request.getParameter("datepicker3");
			String datepicker4 = request.getParameter("datepicker4");
			
			
			
			
//		}

	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/orderList.jsp");
		
	}

}
