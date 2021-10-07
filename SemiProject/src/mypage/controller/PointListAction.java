package mypage.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import mypage.model.*;

public class PointListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String userid = request.getParameter("userid");
		
		InterPointDAO mdao = new PointDAO();
		
		
		int point_sum = mdao.getPointInfo(userid);
		
		request.setAttribute("point_sum", point_sum);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/pointList.jsp");
			
				
	}

}
