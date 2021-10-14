package mypage.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import mypage.model.*;

public class PointListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		/*
		if(!"post".equalsIgnoreCase(method)) {
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc ="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return; // execute(HttpServletRequest request, HttpServletResponse response) 메소드 종료함
		}
		*/
		
		String userid = request.getParameter("userid");
		
		InterPointDAO pdao = new PointDAO();
		
		// 총 적립금
		
		Map<String,Integer> point_map = pdao.getPointInfo(userid);
		
		int point_sum = point_map.get("point_sum");
		request.setAttribute("point_sum", point_sum);
		
		int point_canuse = point_map.get("point_canuse");
		request.setAttribute("point_canuse", point_canuse);
		
		int point_used = point_map.get("point_used");
		request.setAttribute("point_used", point_used);
		
		int point_unuse = point_map.get("point_unuse");
		request.setAttribute("point_unuse", point_unuse);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/pointList.jsp");
			
				
	}

}
