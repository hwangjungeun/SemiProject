package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

import common.controller.AbstractController;
import product.model.*;

public class ViewColorOptionAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 여기에 나중에 POST방식만 받도록 if해줘야 함. -> 난 GET방식으로 해줄 수도 있음. 제품번호는 공개해도 괜찮으니까. => GET방식으로 하겠음.
		
		String pseq = request.getParameter("pseq");
	//	System.out.println(">>> 확인용 pseq => " + pseq);
		/*
			>>> 확인용 pseq => 2
			>>> 확인용 pseq => 1
		*/
		
		InterProductDAO_OHJ pdao = new ProductDAO_OHJ();

		List<Map<String,String>> colorList = pdao.viewColorOption(pseq);
		
		// *** DB에서 얻어온 결과물인 colorList 을 JSON 형식의 문자열로 바꾸는 작업을 한다. *** 
		// ==== org.json.* 을 사용한 것 ==== //
		JSONArray jsonArr = new JSONArray();
		// []
		
		for(Map<String,String> map : colorList) {
			
			JSONObject jsobj = new JSONObject();
			// {} {} {}
			
			jsobj.put("CNAME", map.get("CNAME"));
			// {"CNAME":"blue"}
			// {"CNAME":"pink"}
			jsobj.put("OPSEQ", map.get("OPSEQ"));
			
			jsonArr.put(jsobj);
			// [{"OPSEQ":"3","CNAME":"blue"},{"OPSEQ":"4","CNAME":"pink"}]
		}// end of for-------------------------------------
		
		String json = jsonArr.toString();
	//	System.out.println(">>> 확인용 json ==> " + json);
		// >>> 확인용 json ==> [{"OPSEQ":"3","CNAME":"blue"},{"OPSEQ":"4","CNAME":"pink"}]
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
