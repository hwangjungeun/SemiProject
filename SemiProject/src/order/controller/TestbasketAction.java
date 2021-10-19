package order.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController_LCE;
import order.model.CartVO_LCE;
import product.model.InterProductDAO_LCE;
import product.model.ProductDAO_LCE;

public class TestbasketAction extends AbstractController_LCE {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String method = request.getMethod(); // "GET" 또는 "POST"

		//로그인 처리도 해줘야함 
		if("POST".equalsIgnoreCase(method)) {  // POST: 위시리스트에서 opseq받아온 경우로 insert해줘야함
		
		String cartseq = request.getParameter("cartseq");
		String userid = request.getParameter("userid");
		
		//boolean bool = cartseq.contains(","); // 여러개나 한개나 다 받아오기 위해서 

		//if(bool) {
		String[] cartseqArr = cartseq.split(",");
		
		int size = cartseqArr.length;
			
		for(int i=0;i<size;i++) {
			System.out.println("배열로 들어왔음"+cartseqArr[i]);
			//하나씩  dao로 넘겨서 insert해줘야함 
		}
			
		//}
		//else {
			System.out.println("하나만 들어왔음"+cartseq);
		//}
		//System.out.println("길이" + size);
		
		request.setAttribute("cartseq",cartseq);
		request.setAttribute("loginuserid",userid);
		
		super.setViewPage("/WEB-INF/order/testbasket.jsp");
			
		}
	
		
		
		
		
	}

}
