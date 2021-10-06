package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;
import product.model.*;

public class RecentViewProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 최근본상품을 보기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
		if( super.checkLogin(request) ) {
			// 로그인을 했으면
			
			String userid = request.getParameter("userid"); // 주소창에 넘어온 userid
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser.getUserid().equals(userid)) { // 로그인을 했으니 MemberVO는 null이 아님
				// 로그인한 사용자가 자신이 최근본상품을 보는 경우
				
				InterProductDAO pdao = new ProductDAO();
				
				Map<String,String> paraMap = new HashMap<>(); // paraMap에 where절 조건 담을꺼야(userid)
				
				paraMap.put("userid", userid);
				
				
				List<ProductVO> productList = pdao.selectRecentViewProduct(paraMap);
				
				request.setAttribute("productList", productList);
				
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/product/recentViewProduct.jsp");
				
			}
			else {
				// 로그인한 사용자가 다른 사용자의 최근본상품을 보려고 시도하는 경우 
	            String message = "다른 사용자의 최근본상품목록을 보는건 불가합니다.!!";
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
			String message = "최근본상품을 보기 위해서는 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			 
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			     
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}

}
