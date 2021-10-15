package mypage.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO_PJW;
import order.model.InterOrderDAO_HJE;
import order.model.OrderDAO_HJE;

public class OrderListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		/*
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		}
		else {  */
		

			HttpSession session = request.getSession();
			
			MemberVO_PJW loginuser = (MemberVO_PJW) session.getAttribute("loginuser");
			String userid = loginuser.getUserid();
//			String userid= request.getParameter("userid");
			InterOrderDAO_HJE odao = new OrderDAO_HJE();
			
			String date1 = request.getParameter("datepicker1");
			String date2 = request.getParameter("datepicker2");
			String date3 = request.getParameter("datepicker3");
			String date4 = request.getParameter("datepicker4");
			
			request.setAttribute("date1", date1);
			request.setAttribute("date2", date2);
			
			// 사용자가 보고싶어하는 페이지 숫자
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			try {
				
				Integer.parseInt(currentShowPageNo);
				
			} catch (NumberFormatException e) {
				currentShowPageNo = "1";
			}
			
			String pageBar = "";
			
			int blockSize = 3;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
			
			int loop = 1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
			
			// !! 아래는 pageNo를 구하는 공식이다.
			int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.

//			System.out.println(currentShowPageNo);
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("userid", userid );
			paraMap.put("date1", date1);
			paraMap.put("date2", date2);
			
			// 페이징 처리를 위한 주문에 대한 총 페이지 알아오기
			int totalPage = odao.getTotalPage(paraMap);

			// *** [맨처음][이전] 만들기 *** //
			if(pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link' href='orderList.go?userid="+userid+"&currentShowPageNo=1'>&laquo;&laquo;</a></li>";
				pageBar += "<li class='page-item'><a class='page-link' href='orderList.go?userid="+userid+"&currentShowPageNo="+(pageNo-1)+"'>&laquo;</a></li>";
			}
			
			
			// *** pagenation 만들기 *** //
			while( !(loop > blockSize || pageNo > totalPage) ) {
				// 한 블럭(3)당 보여지는 페이지 번호의 개수보다 작을때,
				// 메소드 getTotalPage을 통해 알아온 총 페이지 수보다 현재보여지는 페이지 수가 작을 떄
				
				if(pageNo == Integer.parseInt(currentShowPageNo)) { // 
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='orderList.go?userid="+userid+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}
				
				loop++;	// 1 2 3
				
				pageNo ++; //  1  2  3  
						   //  4  5  6 
						   //  7  8  9 
				
			} // end of while
			
			
			// *** [다음][마지막] 만들기 *** //
			if( pageNo <= totalPage ) {
				pageBar += "<li class='page-item'><a class='page-link' href='orderList.go?userid="+userid+"&currentShowPageNo="+pageNo+"'>&raquo;</a></li>";
				pageBar += "<li class='page-item'><a class='page-link' href='orderList.go?userid="+userid+"&currentShowPageNo="+totalPage+"'>&raquo;&raquo;</a></li>";
			}
			
			
			request.setAttribute("pageBar", pageBar);
			request.setAttribute("userid", userid);
			
			request.setAttribute("currentShowPageNo", currentShowPageNo);
			
			/// *** === 페이지바 만들기 끝 === *** ///
			
			// 총 주문 개수 구하기 시작 //
			int allorder = odao.getCountAllOrder(paraMap);
			
			request.setAttribute("allorder", allorder);
			
			
			
			
//		}

	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/mypage/orderList_HJE.jsp");
		
	}

}
