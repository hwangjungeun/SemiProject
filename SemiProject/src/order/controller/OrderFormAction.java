package order.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model.*;

public class OrderFormAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 주문을 하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
/*		if( super.checkLogin(request) ) {
			// 로그인을 했으면
			
			String userid = request.getParameter("userid"); // 주소창에 넘어온 userid
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser.getUserid().equals(userid)) { // 로그인을 했으니 MemberVO는 null이 아님
				// 로그인한 사용자가 자신의 주문을 하는 경우
*/				
				// ######################주문하기로 넘어올때, 제품번호/옵션번호/주문수량을 넘겨줘야함######################
				String pseq = request.getParameter("pseq"); // 제품번호
				String opseq = request.getParameter("opseq"); // 옵션번호
				String oqty = request.getParameter("oqty"); // 주문수량
				
				if(oqty == null) {
					oqty = "1"; // 위시리스트/최근본상품에서는 수량을 선택못하므로, 주소창에 넘기지 않으면 1개만 주문한다.
				}
				
				InterProductDAO_OHJ pdao = new ProductDAO_OHJ();
				
				Map<String,String> paraMap = new HashMap<>(); // paraMap에 where절 조건 담을꺼야(제품번호,옵션번호)
				paraMap.put("pseq", pseq);
				paraMap.put("opseq", opseq);
				
				List<POptionVO_OHJ> orderList = pdao.selectOrderList(paraMap);
			//	System.out.println("확인용 orderList => " + orderList);
				
				request.setAttribute("orderList", orderList);
		
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/order/orderForm.jsp");
/*				
			}
			else {
				// 로그인한 사용자가 다른 사용자의 주문을 하려고 시도하는 경우 
	            String message = "다른 사용자의 주문을 하는건 불가합니다.!!";
	            String loc = "javascript:history.back()";
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	        //    super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
	            return;
			}
		}
		else {
			// 로그인을 안 했으면
			String message = "주문을 하기 위해서는 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			 
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			     
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
*/
				
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response)-----------------------------------------------------------

}
