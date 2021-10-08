package product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.InterProductDAO_OHJ;
import product.model.ProductDAO_OHJ;

public class ViewColorOptionAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 여기에 나중에 login한 사람만 색상옵션 볼 수 있도록 POST방식만 받도록 if해줘야 함.
		
		InterProductDAO_OHJ pdao = new ProductDAO_OHJ();
		// pdao.viewColorOption();
		
	}

}
