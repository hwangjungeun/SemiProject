package mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO_PJW;
import order.model.InterOrderDAO_HJE;
import order.model.OrderDAO_HJE;
import order.model.OrderdetailVO_HJE;

public class CancelOrderListJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		
		MemberVO_PJW loginuser = (MemberVO_PJW) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
//		String userid= request.getParameter("userid");
		
		InterOrderDAO_HJE odao = new OrderDAO_HJE();
		
		String date3 = request.getParameter("date3");
		String date4 = request.getParameter("date4");

		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid );
		paraMap.put("date3", date3);
		paraMap.put("date4", date4);
		
		List<OrderdetailVO_HJE> orderList =  odao.showCancelOrder(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(orderList.size() > 0) {
			
			for(OrderdetailVO_HJE odvo : orderList) {
				
				JSONObject jsonObj = new JSONObject(); // {} {}
				
				jsonObj.put("fk_odrcode", odvo.getFk_odrcode());    
				jsonObj.put("pimage", odvo.getPvo().getPimage());
				jsonObj.put("pname", odvo.getPvo().getPname());    
				jsonObj.put("oqty", odvo.getOqty());    
				jsonObj.put("odrprice", odvo.getOdrprice());    

				String cancelstatus = "";
				if (odvo.getCancelstatus() == 0) {
				}
				else if (odvo.getCancelstatus() == 1) {
					cancelstatus = "취소";
				}
				else if ( odvo.getCancelstatus() == 2 ) {
					cancelstatus = "교환";
				}
				else if ( odvo.getCancelstatus() == 3 ) {
					cancelstatus = "반품";
				}
				jsonObj.put("cancelstatus", cancelstatus);    
	            
			
	            jsonArr.put(jsonObj);
			} 
			String json = jsonArr.toString();	// 문자열로 변환
			
//			System.out.println("~~ 확인용  json : " + json);
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		} // end of if
		else {
			// DB에서 조회된 것이 없다라면 
			
			String json = jsonArr.toString();	// 문자열로 변환
			// System.out.println("~~ 확인용  json : " + json);
			// ~~ 확인용  json : []
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		
	}

}
