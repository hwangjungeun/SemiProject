package order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController_LCE;
import member.model.MemberVO_LCE;
import order.model.CartVO_LCE;
import product.model.InterProductDAO_LCE;
import product.model.ProductDAO_LCE;

public class BasketAction extends AbstractController_LCE {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getBasketCnt(request);// 다른 페이지들도 다 넣어야지 장바구니 갯수 볼 수 있음 !!
		
		// 로그인한 회원정보(아이디) 받아오기
		//HttpSession session = request.getSession();
		//String loginuser = (String) session.getAttribute("loginuser");
		String loginuserid = "leess";  //테스트용 kimmk 0개 leess 6개
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		InterProductDAO_LCE pdao = new ProductDAO_LCE();

		if("POST".equalsIgnoreCase(method)) {  // POST: 위시리스트에서 온 경우 => insert & delete 

			String opseq = request.getParameter("opseq"); //옵션 번호 받아옴 
		
			int oqty = 1; // 위시리스트에서 수량을 정하지 않으므로 디폴트값을 1로 줌 
			
			String[] opseqArr = opseq.split(",");
			
			int size = opseqArr.length;
			int isSuccess = 0; // 성공여부 
			
			for(int i=0;i<size;i++) { // delete는 로그인아이디, 옵션번호 필요 insert는 옵션번호, 수량, 제품번호 필요함
				
				Map<String,String> paraMap = new HashMap<>();
				paraMap.put("opseq", opseqArr[i]);
				paraMap.put("loginuserid", loginuserid);
				paraMap.put("oqty", String.valueOf(oqty));
				
				isSuccess = pdao.insertDelete(paraMap);
				
				if( isSuccess != 1 ) {
					request.setAttribute("message", "장바구니에 담을 수 없습니다.");
                    request.setAttribute("loc", "javascript:history.back()"); 
                    super.setViewPage("/WEB-INF/msg.jsp");
                    
                    return;
				}// end of if
				
			}// end of for
		}
		// GET: index.go에서 장바구니버튼 클릭시 혹은 상세페이지에서 장바구니버튼 클릭시(ajax로 넣어주고 여기로 href사용) 단순 select만 해오면 됨 
		
		//회원아이디로 장바구니에서 상품들 조회해오기 
		List<CartVO_LCE> cartList = pdao.selectBasket(loginuserid);
		
		/* 확인용 => 넘어옴 
		if(cartList.size() != 0) {
			System.out.println("잘넘어옴 ");
		}
		*/
		request.setAttribute("cartList", cartList);
		//request.setAttribute("loginuserid", loginuserid); 굳이?
		
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/basket.jsp");
		
	}

}
