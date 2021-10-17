package mypage.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO_OHJ;
import product.model.*;

public class WishListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 위시리스트를 보기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
/*		if( super.checkLogin(request) ) {
			// 로그인을 했으면
			
			String userid = request.getParameter("userid"); // 주소창에 넘어온 userid
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser.getUserid().equals(userid)) { // 로그인을 했으니 MemberVO는 null이 아님
				// 로그인한 사용자가 자신의 위시리스트를 보는 경우
*/				
				String currentShowPageNo = request.getParameter("currentShowPageNo");
				// currentShowPageNo 은 사용자가 보고자하는 페이지바의 페이지번호 이다.
		        // 최근본상품 목록을 처음볼때에는 currentShowPageNo 은 null 이 된다.
		        // currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
				
				if( currentShowPageNo == null ) {
					currentShowPageNo = "1";
				}
				
				// 한 페이지당 화면상에 보여줄 제품의 개수는 3 으로 한다. sizePerPage 는 ProductDAO 에서 상수로 설정해 두었음.(넘겨줄 필요 없음.)
				
				// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
		        //     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
				try {
					Integer.parseInt(currentShowPageNo);
				} catch (NumberFormatException e) {
					currentShowPageNo = "1";
				}
				
				
				InterProductDAO_OHJ pdao = new ProductDAO_OHJ();
				
				Map<String,String> paraMap = new HashMap<>(); // paraMap에 where절 조건 담을꺼야(userid,currentShowPageNo)
				paraMap.put("userid", "eomjh"); // ##################( 로그인merge된거 받기전까지 코드 돌리는용으로, "eomjh"대신 userid다. )##################
				paraMap.put("currentShowPageNo", currentShowPageNo);
				
				// 위시리스트 목록들을 페이지바를 이용한 페이징 처리하여 조회(select)해오기
				List<WishListVO_OHJ> wishList = pdao.selectWishList(paraMap);
		//		System.out.println("확인용 wishList => " + wishList);
			
				request.setAttribute("wishList", wishList);
			
				// **** ========== 페이지바 만들기 시작 ========== **** //
				
				// MallByCategoryAction.java 참조하기
				
				String pageBar = ""; // 뷰단에 들어갈 <li>태그
				
				int blockSize = 1; // 10 => 1 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
				// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
				
				int loop = 1;
				// loop는 "1부터 증가"하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개@@@@@@@@@@@@@@@@=> 1개@@@@@@@@@@@@@@@@@@@@)까지만 증가하는 용도이다. 
				
				// !!! 아래는 pageNo 를 구하는 공식이다. !! //
				int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
				// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
				
				// 페이지바를 만들기 위해서 해당userid의 최근본상품 목록에 대한 총페이지수 알아오기(select) 
				int totalPage = pdao.getWishTotalPage("eomjh"); // 특정 userid를 넘김. // cnum => userid => "eomjh"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
			//	System.out.println("~~~ 확인용 totalPage : " + totalPage);
				
				
				// **** [맨처음][이전] 만들기 **** //
				if(pageNo != 1) {
					pageBar += "<li class='page-item'><a class='page-link' href='wishList.go?currentShowPageNo=1&userid=eomjh'><span class='text-dark' aria-hidden='true'>&lt;&lt;</span></a></li>"; // eomjh=>userid@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
					pageBar += "<li class='page-item'><a class='page-link' href='wishList.go?currentShowPageNo="+(pageNo-1)+"&userid=eomjh'><span class='text-dark' aria-hidden='true'>&lt;</span></a></li></a></li>"; // eomjh=>userid@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
				}
				
				
				while( !(loop > blockSize || pageNo > totalPage) ) { // loop가 11이 되어지면 탈출. // 전체페이지수보다 많으면 탈출.
					
					if( pageNo == Integer.parseInt(currentShowPageNo) ) {
						pageBar += "<li class='page-item active'><a class='page-link' href='#' style='background-color: #ffe6e6; border-color: #ffe6e6;' ><span class='text-dark' style='background-color: #ffe6e6; border-color: #ffe6e6;' >"+pageNo+"</span></a></li>"; // 페이지바에서, 현재 내가 클릭한 페이지수 표시(부트스트랩의 active)
					}
					else {
						pageBar += "<li class='page-item'><a class='page-link' href='wishList.go?currentShowPageNo="+pageNo+"&userid=eomjh'><span class='text-dark'>"+pageNo+"</span></a></li>"; // eomjh=>userid@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
					}
					
					loop++; // 1 2 3 4 5 6 7 8 9 10 (총 10번 반복)
					
					pageNo++; //  1  2  3  4  5  6  7  8  9 10 (currentShowPageNo에 따라 이거일수도 있고,)
							  // 11 12 13 14 15 16 17 18 19 20 (currentShowPageNo에 따라 이거일수도 있다.)
							  // 21 22 23 24 25 26 27 28 29 30
							  // 31 32 33 34 35 36 37 38 39 40
					 		  // 41 42 (totalPage가 42)
					
				}// end of while-------------------------------------
				
				
				// **** [다음][마지막] 만들기 **** //
				// while문을 빠져나올때, pageNo ==> 11
				if( pageNo <= totalPage ) { // while문의 탈출조건인 pageNo > totalPage가 아닌 경우
					pageBar += "<li class='page-item'><a class='page-link' href='wishList.go?currentShowPageNo="+pageNo+"&userid=eomjh'><span class='text-dark' aria-hidden='true'>&gt;</span></a></li>"; // eomjh=>userid@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
					pageBar += "<li class='page-item'><a class='page-link' href='wishList.go?currentShowPageNo="+totalPage+"&userid=eomjh'><span class='text-dark' aria-hidden='true'>&gt&gt;</span></a></li>"; // eomjh=>userid@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
				}
				
				
				request.setAttribute("pageBar", pageBar);
				
				// **** ========== 페이지바 만들기 끝 ========== **** //
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/mypage/wishList.jsp");
/*			
			}
			else {
				// 로그인한 사용자가 다른 사용자의 위시리스트를 보려고 시도하는 경우 
	            String message = "다른 사용자의 위시리스트를 보는건 불가합니다.!!";
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
			String message = "위시리스트를 보기 위해서는 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			 
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			     
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
*/	
		
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response)--------------------------------------

}
