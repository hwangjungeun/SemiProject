package member.controller;

import java.util.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class PwdUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		
		String method = request.getMethod();
		// GET or POST
		
		if("POST".equalsIgnoreCase(method)) {
			
			String pwd = request.getParameter("pwd"); // pwdUpdateEnd 에서 받아오는 data
			
			Map<String,String > paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			
			InterMemberDAO_PJW mdao = new MemberDAO_PJW();
			int n = mdao.pwdUpdate(paraMap);
			// 업데이트 성공시 n = 1 이 나오는데 이걸 뷰단에 넘길 계획
			
			request.setAttribute("n", n);
			
		}
		
		request.setAttribute("userid", userid); // pwdUpdateEnd로 보내는 data
		request.setAttribute("method", method); // pwdUpdateEnd로 보내는 data
		
		
		super.setViewPage("/WEB-INF/login/pwdUpdateEnd.jsp");

	}

}
