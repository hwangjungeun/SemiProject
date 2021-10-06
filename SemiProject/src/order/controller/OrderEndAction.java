package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class OrderEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// orderForm으로부터 get방식으로 가져온거(form태그의 name)
		// destination,receiverName,postcode,address,detailAddress,extraAddress,hp1,hp2,hp3,email,deliveryMsg
		
		// 결제성공하면, 주문내역테이블에 넣어주고, 
		// 주문번호와 주문일자를 채번으로 가져와서 orderEnd.jsp에 넘겨줄꺼야~~
		
//		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/orderEnd.jsp");
		
	}

}
