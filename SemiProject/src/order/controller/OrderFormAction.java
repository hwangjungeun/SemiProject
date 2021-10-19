package order.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO_OHJ;
import member.model.MemberDAO_OHJ;
import member.model.MemberVO_OHJ;
import member.model.MemberVO_PJW;
import product.model.*;

public class OrderFormAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		// 주문을 하기 위한 전제조건은 먼저 로그인을 해야 하는 것이다.
		if( super.checkLogin(request) ) {
			// 로그인을 했으면
		*/	
	//		String userid = request.getParameter("userid"); // 주소창에 넘어온 userid
			
			HttpSession session = request.getSession();
			MemberVO_PJW loginuser = (MemberVO_PJW)session.getAttribute("loginuser");
			String userid = loginuser.getUserid();
		/*	if(loginuser.getUserid().equals(userid)) { // 로그인을 했으니 MemberVO는 null이 아님
				// 로그인한 사용자가 자신의 주문을 하는 경우
		*/	
				Map<String,String> map = null;
				
				
				// 주문하기로 넘어올때, userid/문자열opseq/문자열수량/문자열cartseq를 넘겨줌.
				String opseq = request.getParameter("opseq"); // 옵션번호
				String cnt = request.getParameter("cnt"); // 구매하고자하는 제품색상의 수량
				String cartseq = request.getParameter("cartseq"); // 장바구니번호
			/*	
				System.out.println("확인용 opseq => " + opseq); 
				System.out.println("확인용 cnt => " + cnt); 
				System.out.println("확인용 cartseq => " + cartseq); 
			*/	
				
				InterProductDAO_OHJ pdao = new ProductDAO_OHJ();
				
				if(cartseq == null) { // 상세페이지,최근본상품,위시리스트
					
					map = new HashMap<>();
					
					String[] opseqArr = opseq.split(","); // 예를 들어 제품이 여러개라 "4,1,3"이렇게 넘긴다면 split해줘야함.
					
					if(cnt != null) { // 상세페이지
						String[] cntArr = cnt.split(",");
						
						// opseqArr과 cntArr이 똑같은 인덱스로 짝을 이루는데, 반복문을 돌린다.
						// 주문원하는테이블에 insert한다.
						for(int i=0; i<cntArr.length; i++) { // opseqArr과 cntArr는 길이 같으므로 아무거나 반복돌림.
							map.put("fk_opseq", opseqArr[i]);
							map.put("oqty", cntArr[i]);
							map.put("userid", userid); // ##################################뿌잉##################################
							
							pdao.insertOdrProg(map); // 주문진행중 테이블에 insert
						}// end of for--------------------------------------------
						
					}
					else { // 위시리스트,최근본상품에서는 수량을 선택못하므로, 주소창에 넘기지 않으면 1개만 주문한다.
						cnt = "1";
						
						// opseqArr와 1을 주문원하는테이블에 insert한다.
						for(int i=0; i<opseqArr.length; i++) {
							map.put("fk_opseq", opseqArr[i]);
							map.put("oqty", "1");
							map.put("userid", userid); // ##################################뿌잉##################################
							
							pdao.insertOdrProg(map); // 주문진행중 테이블에 insert
						}// end of for--------------------------------------------
						
					}
					
				}
				else { // 장바구니 -> 주문하기 
					
					String[] cartseqArr = cartseq.split(",");
					
					// 배열의 길이만큼 for문을 돌려서 cartseq로 opseq와 수량을 select한다음, 주문원하는테이블에 insert한다.
					for(int i=0; i<cartseqArr.length; i++) {
						
						map = pdao.selectFromCart(cartseqArr[i]); // fk_opseq와 oqty알아오기
						
					//	System.out.println("확인용 fk_opseq => " + map.get("fk_opseq"));
					//	System.out.println("확인용 userid => " + map.get("userid"));
					//	System.out.println("확인용 oqty => " + map.get("oqty"));
						
						// map이 pdao를 통해서 new HashMap으로 바꼈으므로 키값인 userid를 다시 넣어줘야함.
						map.put("userid", userid); // ##################################뿌잉##################################
						
						pdao.insertOdrProg(map); // 주문진행중 테이블에 insert
						
					}// end of for---------------------------------------
					
				}
				
				
				// 주문원하는테이블인 tbl_orderProgress을 이용해, 주문서폼이 원하는 정보(이미지,제품명,옵션컬러명,가격,수량,적립금)와 주문완료가 원하는 정보(제품번호,옵션번호)인 orderProgList를 보내준다.
				List<OrderProgressVO_OHJ> orderProgList = pdao.showOdrProg();
			//	System.out.println("확인용 orderProgList => " + orderProgList);
				
				
				// 회원정보를 조회해서 뷰단에 보낸다.(getParameter로 넘어온 userid를 이용)
				InterMemberDAO_OHJ mdao = new MemberDAO_OHJ();
				
				MemberVO_OHJ member = mdao.showMemberInfo(userid); // ##################################뿌잉##################################
				
				// 해당user의 포인트에 대한 총합을 구해서 뷰단에 보낸다.
				int totalPoint = mdao.showTotalPoint(userid); // ##################################뿌잉##################################
				
				
				request.setAttribute("member", member);
				request.setAttribute("totalPoint", totalPoint);
				request.setAttribute("orderProgList", orderProgList);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/order/orderForm.jsp");
		
/*			}
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
