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

public class BestPageJSONAction extends AbstractController_LCE {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		
		String cnt = request.getParameter("cnt");
		String allsum = request.getParameter("allsum");
		String start = request.getParameter("start");
		
		InterProductDAO_LCE pdao = new ProductDAO_LCE();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("start", start);
		paraMap.put("allsum", allsum); // 베스트상품 조건갯수 지금은 갯수가 작아서 무시, 갯수 많아지면 dao도 수정해야함 
		//paraMap.put("sortType", sortType);
		
		String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(cnt) - 1);
		
		paraMap.put("end", end);
		
		List<ProductVO_LCE> prodList = pdao.selectBestitems(paraMap);//베스트아이템 조회해오기 
		
		JSONArray jsonArr = new JSONArray();
		
		if ( prodList.size() > 0 ) {
			
			for(ProductVO_LCE pvo : prodList) {
			
				System.out.println("price"+pvo.getPname());
					
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("pseq",pvo.getPseq());
				jsonObj.put("pimage",pvo.getPimage());
				jsonObj.put("price",pvo.getPrice());
				jsonObj.put("pname",pvo.getPname());
				
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
