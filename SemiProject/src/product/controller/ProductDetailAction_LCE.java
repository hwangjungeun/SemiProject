package product.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController_LCE;
import product.model.InterProductDAO_LCE;
import product.model.OptionVO_LCE;
import product.model.ProductDAO_LCE;
import product.model.ProductVO_LCE;

public class ProductDetailAction_LCE extends AbstractController_LCE {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getBasketCnt(request);// 다른 페이지들도 다 넣어야지 장바구니 갯수 볼 수 있음 !!
		
		// super.goBackURL(request); // 로그인 또는 로그아웃시 그전의 페이지(즉 이페이지)로 다시 돌아오기 위해서 
		// abstract에서 메소드 만들어야함 이부분
		
		String pseq = request.getParameter("pseq"); // 제품번호 
		request.setAttribute("pseq", pseq); 
		
		InterProductDAO_LCE pdao = new ProductDAO_LCE();
		try {
			ProductVO_LCE pvo = pdao.selectProduct(pseq); // 해당 상품의 정보 가져오기 (기본정보)
			
			List<OptionVO_LCE> optionList = pdao.selectProductOption(pseq); // 옵션 선택을 위한 해당 상품의 옵션 정보가져오기 (색상명, 옵션수량--> 이건 잘 모르겠음)
			
			if( pvo == null ) {
				// 비정상접근 유저가 주소창에 장난침 
				
				String message = "검색하신 상품은 존재하지 않습니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
			    request.setAttribute("loc", loc);
			        
			     //   super.setRedirect(false);
			     super.setViewPage("/WEB-INF/msg_LCE.jsp");
			        
			     return;
			}
			else { 
				// 정상적인 접근
				
				///////현지님////////

				// 최근본상품 리스트에 해당 제품을 insert/update해야함.
	//			HttpSession session = request.getSession();
	//			MemberVO_OHJ loginuser = (MemberVO_OHJ)session.getAttribute("loginuser");
	//			String userid = loginuser.getUserid();
				String userid = "eomjh"; // ##이 부분 나중에 지워줘야함.#########################################################################
				
				pdao.insertRecentViewProd(userid,pseq);
				
				request.setAttribute("fk_userid", userid); // 뷰단에서 주문 및 위시리스트에 insert할 때 필요함.
				
				
				request.setAttribute("pvo",pvo); // 상품정보가져오기
				request.setAttribute("optionList",optionList); // 옵션가져오기
				super.setViewPage("/WEB-INF/product/productDetail_LCE.jsp");
				
			}
			
		}catch(Exception e) {
				e.printStackTrace();
				System.out.println("exception 오류남");
		}
		
		
		//확인용 
		//System.out.println("optionList사이즈" + optionList.size() );
	}

}
