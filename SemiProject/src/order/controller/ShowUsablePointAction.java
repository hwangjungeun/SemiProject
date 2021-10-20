package order.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class ShowUsablePointAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		
		// 원래는 로그인한 사용자가 맞는지 확인하는 과정을 거쳐야하는데, 포인트조회일뿐 사용은 아니니까 시간관계상 그냥 넘어가자.##########
		
		// 사용가능한 적립금 목록을 select하는 메소드
		InterMemberDAO_OHJ mdao = new MemberDAO_OHJ();
		List<PointVO_OHJ> pointList = mdao.showUsablePoint(userid);
		
		request.setAttribute("pointList", pointList);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/showUsablePoint.jsp");
		
	}

}
