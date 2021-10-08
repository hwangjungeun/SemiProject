package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class BestListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			
			
		}
		else { // index.go의 메뉴에서 Best카테고리 클릭시(get방식)
			super.setViewPage("/WEB-INF/product/bestList.jsp");
		}
		

		
		
		
	}

}
