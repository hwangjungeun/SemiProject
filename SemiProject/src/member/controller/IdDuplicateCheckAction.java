package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.InterMemberDAO_HJE;
import member.model.MemberDAO_HJE;

public class IdDuplicateCheckAction extends AbstractController {

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("post".equalsIgnoreCase(method)) {
			String userid = request.getParameter("userid");
			
//			System.out.println(userid);
			
			InterMemberDAO_HJE mdao = new MemberDAO_HJE();
			boolean isExists = mdao.idDuplicateCheck(userid);
			
			JSONObject jsonObj = new JSONObject();	// {}
			
			jsonObj.put("isExists", isExists);		// {"isExists":true} 또는 {"isExists":false}
			
			String json = jsonObj.toString();	// 문자열형태인 "{"isExists":true}" 또는 "{"isExists":false}"
			
			request.setAttribute("json", json);
			
//			System.out.println(">>확인용 json ==> "+json);
			
//			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		
	}

}
