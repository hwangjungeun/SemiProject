package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO_OHJ;
import member.model.MemberDAO_OHJ;
import member.model.MemberVO_OHJ;
import member.model.MemberVO_PJW;

public class OrderPaymentAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		// 아임포트 결제창을 사용하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
		if( super.checkLogin(request) ) {
			// 로그인을 했으면
		*/	
//			String userid = request.getParameter("userid"); // 주소창에 넘어온 userid
			
			HttpSession session = request.getSession();
			MemberVO_PJW loginuser = (MemberVO_PJW)session.getAttribute("loginuser");
			String userid = loginuser.getUserid();
		/*	if(loginuser.getUserid().equals(userid)) { // 로그인을 했으니 MemberVO는 null이 아님
				// 로그인한 사용자가 자신의 코인을 결제하는 경우
		*/		
				String coinmoney = request.getParameter("coinmoney");
				
				// 회원정보를 조회해서 뷰단에 보낸다.(getParameter로 넘어온 userid를 이용)
				InterMemberDAO_OHJ mdao = new MemberDAO_OHJ();
				MemberVO_OHJ member = mdao.showMemberInfo(userid); // ##################################뿌잉##################################
				
				request.setAttribute("coinmoney", coinmoney);
				request.setAttribute("email", member.getEmail()); // InterMemberDAO의 selectOneMember메소드를 보면, 이메일은 복호화해서 MemberVO에 넣었음
				request.setAttribute("name", member.getName());
				request.setAttribute("mobile", member.getMobile());
				request.setAttribute("userid", userid); // ##################################뿌잉##################################
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/order/paymentGateway.jsp");
/*			}
			else {
				// 로그인한 사용자가 다른 사용자의 코인을 충전하려고 시도하는 경우 
	            String message = "다른 사용자의 결제 시도는 불가합니다.!!";
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
			String message = "결제를 하기 위해서는 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			 
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			     
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
*/	
	}

}
