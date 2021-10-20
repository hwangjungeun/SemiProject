package mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO_OHJ;
import product.model.ProductDAO_OHJ;

public class DeleteAllWishListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			
			String fk_userid = request.getParameter("fk_userid");
			
			InterProductDAO_OHJ pdao = new ProductDAO_OHJ();
			
			boolean deleted = pdao.deleteAllWishList(fk_userid);
			
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("deleted", deleted);	   // {"deleted":true} 또는 {"deleted":false}
			
			String json = jsonObj.toString(); // 문자열 형태인 "{"deleted":true}" 또는 "{"deleted":false}" 으로 된다.
		//	System.out.println(">>> 확인용 json => " + json);
			// >>> 확인용 json => {"deleted":true} 또는 {"deleted":false}
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
	}

}
