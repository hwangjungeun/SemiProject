package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class OrderEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// orderForm으로부터 post방식으로 가져온거(form태그의 name)
		
		// destination,receiverName,postcode,address,detailAddress,extraAddress,hp1,hp2,hp3,email,deliveryMsg 아니고,
		// 회원아이디, 주문총액 / 제품번호, 주문량, 주문가격 / 옵션번호
		
		String userid = request.getParameter("userid");
		String odrtotalprice = request.getParameter("odrtotalprice");
		String fk_pseqjoin = request.getParameter("fk_pseqjoin");
		String oqtyjoin = request.getParameter("oqtyjoin");
		String odrpricejoin = request.getParameter("odrpricejoin");
		String fk_opseqjoin = request.getParameter("fk_opseqjoin");
		
		// 결제성공했으니, 주문내역테이블에 넣어주고, 
		// 주문번호와 주문일자를 채번으로 가져와서 orderEnd.jsp에 넘겨줄꺼야~~
		
		// 1) tbl_order와 tbl_orderdetail 주문내역insert
		// 2) tbl_orderProgress 주문대기중목록delete
		// 3) tbl_member/tbl_point 포인트update?delete?
		// 4) tbl_cart 해당목록delete
		// 5) tbl_wishlist 해당목록delete
		// 이거 해야해~~~~~~~~~~~~~~~~~~~~~~~~~~~########################################
		
		
		
		
		
//		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/orderEnd.jsp");
		
	}

}
