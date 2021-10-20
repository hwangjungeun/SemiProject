package mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.*;

public class DeleteWishListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			
			String wishseq = request.getParameter("wishseq"); // wishseq => "4,1,3"이렇게 올 수도 있음.
			String[] wishseqArr = wishseq.split(",");
			
			InterProductDAO_OHJ pdao = new ProductDAO_OHJ();
			
			boolean deleted = false;
			
			for(int i=0; i<wishseqArr.length; i++) {
				deleted = pdao.deleteWishList(wishseqArr[i]);
				
			//	System.out.println("확인용 wishseq의 값 => " + wishseqArr[i]);
			//	System.out.println("확인용 deleted 결과 => " + deleted);
				
				if(!deleted) {// 삭제실패가 있음
					break; // 반복문종료. 이 경우에는 deleted가 false이다.
				}
				// deleted가 true는 삭제성공인 경우다.
			}
			
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
