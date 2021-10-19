package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController_LCE;
import product.model.InterProductDAO_LCE;
import product.model.ProductDAO_LCE;

public class BestListAction extends AbstractController_LCE {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.getBasketCnt(request);// 다른 페이지들도 다 넣어야지 장바구니 갯수 볼 수 있음 !!
		
		InterProductDAO_LCE pdao = new ProductDAO_LCE();
		
		int allsum = 10;
		int totalBestCount = pdao.totalBestCount(allsum);// 베스트상품갯수 조회해오기 
		
		request.setAttribute("totalBestCount", totalBestCount);
		//request.setAttribute("sortType",sortType);
		super.setViewPage("/WEB-INF/product/bestList.jsp");
		
	}

}
