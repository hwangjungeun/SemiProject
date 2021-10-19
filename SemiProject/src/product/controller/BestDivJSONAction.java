package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController_LCE;
import product.model.InterProductDAO_LCE;
import product.model.ProductDAO_LCE;
import product.model.ProductVO_LCE;

public class BestDivJSONAction extends AbstractController_LCE {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		String cuseq = request.getParameter("cuseq");//상위카테고리 받아옴
		String cnt = request.getParameter("cnt");    //가져올 갯수 받아옴
		
		InterProductDAO_LCE pdao = new ProductDAO_LCE();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("cuseq", cuseq); // 상위카테고리
		paraMap.put("cnt", "8"); // 갯수
		
		List<ProductVO_LCE> prodList = pdao.selectBest(paraMap); // 베스트아이템 조회해오기 
		
		JSONArray jsonArr = new JSONArray();
		
		if ( prodList.size() > 0 ) {
			
			for(ProductVO_LCE pvo : prodList) {
			
			System.out.println("pvo.getPseq()" + pvo.getPseq() );
				
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("pseq",pvo.getPseq());
			jsonObj.put("pimage",pvo.getPimage());
			jsonObj.put("pname",pvo.getPname());
			//jsonObj.put("price",pvo.getPrice());
			//jsonObj.put("fk_clseq",pvo.getFk_clseq());
			
			
			jsonArr.put(jsonObj);
			
			}// end of for
			
			String json = jsonArr.toString();
			
			request.setAttribute("json", json);
			
			super.setViewPage("/WEB-INF/jsonview_LCE.jsp");
			
		}
		else {
			
			String json = jsonArr.toString();
			
			request.setAttribute("json", json);
			
			super.setViewPage("/WEB-INF/jsonview_LCE.jsp");
			
		}
		
	}

}
