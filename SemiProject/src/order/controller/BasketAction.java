package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class BasketAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			
			
		}
		else { // index.go에서 장바구니버튼 클릭시(get방식)
			
			//로그인시 장바구니페이지에서 회원정보 보여주기 확인용(원래 memberVO 확인차 String으로 바꿈)
			//HttpSession session = request.getSession();
			//String loginuser = (String) session.getAttribute("loginuser");
			
			super.setViewPage("/WEB-INF/order/basket.jsp");
		}
		
		
	}

}
