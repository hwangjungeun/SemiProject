package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController_LCE;
import product.model.InterProductDAO_LCE;
import product.model.ProductDAO_LCE;

public class DeleteThisAction extends AbstractController_LCE {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO_LCE pdao = new ProductDAO_LCE();
		String cartseq = request.getParameter("cartseq");
		boolean bool = cartseq.contains(","); // 여러개나 한개나 다 받아오기 위해서 

		if(bool) {
			String[] cartseqArr = cartseq.split(",");
			
			int size = cartseqArr.length;
			
			for(int i=0;i<size;i++) {
				System.out.println("배열로 들어왔음"+cartseqArr[i]);
				//하나씩  dao로 넘겨서 delete해줘야함 
				
				cartseq = cartseqArr[i];
				
				pdao.deleteBasket(cartseq);// 장바구니테이블에서 삭제하기 
				
			}// end of for
			
		}
		else {
			pdao.deleteBasket(cartseq); // 장바구니테이블에서 삭제하기
		}
		
		request.setAttribute("cartseq",cartseq); //이거는 왜 있는건지?
		//request.setAttribute("loginuserid",userid);
		//System.out.println("cartseq확인" + cartseq);
		
		// 들어온 값으로 delete해주면됨 
		
	}// end of execute(HttpServletRequest request, HttpServletResponse response)

}
