
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
import order.model.InterOrderDAO_HJE;
import order.model.OrderDAO_HJE;
import member.model.MemberVO_PJW;
import order.model.OrderdetailVO_HJE;

public class OrderListJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		MemberVO_PJW loginuser = (MemberVO_PJW) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
//		String userid= request.getParameter("userid");
		
		InterOrderDAO_HJE odao = new OrderDAO_HJE();
		
		// 사용자가 보고싶어하는 페이지 숫자
		String currentShowPageNo = request.getParameter("currentShowPageNo");
//		String currentShowPageNo = (String) session.getAttribute("currentShowPageNo");
		
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");

		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		try {
			Integer.parseInt(currentShowPageNo);
			
		} catch (NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid );
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("date1", date1);
		paraMap.put("date2", date2);
		
		List<OrderdetailVO_HJE> orderList =  odao.selectPagingOrder(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(orderList.size() > 0) {
			
			for(OrderdetailVO_HJE odvo : orderList) {
				
				JSONObject jsonObj = new JSONObject(); // {} {}
				
				jsonObj.put("fk_odrcode", odvo.getFk_odrcode());    
				jsonObj.put("pimage", odvo.getPvo().getPimage());
				jsonObj.put("pname", odvo.getPvo().getPname());    
				jsonObj.put("totalquantity", odvo.getOvo().getTotalquantity());    
				jsonObj.put("odrtotalprice", odvo.getOvo().getOdrtotalprice());    
				jsonObj.put("totalproduct", odvo.getOvo().getTotalproduct());    
			
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
