package order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController_LCE;
import product.model.InterProductDAO_LCE;
import product.model.ProductDAO_LCE;

public class UpdateThisAction extends AbstractController_LCE {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO_LCE pdao = new ProductDAO_LCE();
	
		String cartseq = request.getParameter("cartseq");
		String oqty = request.getParameter("oqty");
		
		System.out.println("cartseq =>"+cartseq+" & oqty =>" +oqty);
		
		// 들어온 값으로 update해주면됨 
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("cartseq", cartseq);
		paraMap.put("oqty", oqty);
		
		pdao.updateBasketcnt(paraMap); // 수량 변경해주기 
		
		
	}

}
