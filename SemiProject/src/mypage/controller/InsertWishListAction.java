package mypage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model.InterProductDAO_OHJ;
import product.model.ProductDAO_OHJ;

public class InsertWishListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			
			String fk_opseq = request.getParameter("fk_opseq"); // fk_opseq => "20,21"이렇게 올 수도 있음.
			String[] fk_opseqArr = fk_opseq.split(",");
			String fk_userid = request.getParameter("fk_userid");
			
			InterProductDAO_OHJ pdao = new ProductDAO_OHJ();
			
			boolean success = false;
			
			for(int i=0; i<fk_opseqArr.length; i++) { 
				// 위시리스트 테이블에 존재하는 제품은 등록일자 enrollmentday를 update해주고,
				// 				존재하지 않으면 insert를 한다.
				success = pdao.insertWishList(fk_userid, fk_opseqArr[i]);
				
				System.out.println("확인용 fk_opseq의 값 => " + fk_opseqArr[i]);
				System.out.println("확인용 success 결과 => " + success);
				
				if(!success) {// insert실패가 있음
					break; // 반복문종료. 이 경우에는 success가 false이다.
				}
				// success가 true는 등록성공인 경우다.
			}
			
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("success", success);	   // {"success":true} 또는 {"success":false}
			
			String json = jsonObj.toString(); // 문자열 형태인 "{"success":true}" 또는 "{"success":false}" 으로 된다.
			System.out.println(">>> 확인용 json => " + json);
			// >>> 확인용 json => {"success":true} 또는 {"success":false}
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
	}

}
