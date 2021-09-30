package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class BasketAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			
			
		}
		else { // index.go에서 장바구니버튼 클릭시(get방식)
			super.setViewPage("/WEB-INF/basket.jsp");
		}
		
		
	}

}
