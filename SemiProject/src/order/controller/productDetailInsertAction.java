package order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController_LCE;
import product.model.InterProductDAO_LCE;
import product.model.ProductDAO_LCE;

public class productDetailInsertAction extends AbstractController_LCE {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		//super.goBackURL(request);

		// 1.먼저 로그인 유무 확인 
		// abstarct에 로그인유무 확인하는 메서드 사용해서 bool값 가져오기
		
		// 1-1 로그인하지 않은 상태
		
		//	request.setAttribute("message","로그인 후 이용하실 수 있습니다");
		//  request.setAttribute("loc","javascript:history.back()"); 
		//  이부분 할려면은 abstract에 페이지 찾아오는 메서드 만들어야함 + url찾는 클래스도 생성해야함 my.util참고
		
		// super.setRedirect(false);
		// super.setViewPage("/WEB-INF/msg.jsp");
			
		//	return;
		
	    /*
		boolean bool = checkLogin(request);
		
		if(!bool) {
			
			request.setAttribute("message","로그인 후 이용하실 수 있습니다");
			request.setAttribute("loc","javascript:history.back()"); 
			//  이부분 할려면은 abstract에 페이지 찾아오는 메서드 만들어야함 + url찾는 클래스도 생성해야함 my.util참고
			
			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		*/
		//else {
		//1-2 로그인을 한 상태 장바구니 테이블에 존재하면 update 아니면 insert
		
		JSONObject jsonObj = new JSONObject(); // json으로 결과값 넘겨줄 것
		
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		String loginuserid = "leess";  //테스트용 
		
		if("POST".equalsIgnoreCase(method)) {  // POST: 상품상세에서 특정제품의 옵션번호 opseq(무조건 배열 형식)를 확인 후 insert 또는 update		

			//로그인 한 유저아이디 가져오기
			//HttpSession session = request.getSession();
			//MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			InterProductDAO_LCE pdao = new ProductDAO_LCE();

			String opseq = request.getParameter("opseq"); //옵션 번호
			String oqty = request.getParameter("oqty");	  //옵션 수량
			
			String[] opseqArr = opseq.split(",");
			String[] oqtyArr = oqty.split(",");
			int size = opseqArr.length;					  //옵션 번호 갯수 + 1

			String num = opseqArr[0];					  //해당 제품번호 가져오기 

			int fk_pseq = pdao.selectPseq(num); 		  // 제품번호 한번만 가져오면 됨 어차피 같은 제품번호인 상세페이지에서 시작했으므로 
			
			boolean bools = true;						  // 장바구니 입력 성공여부
			for(int i=0;i<size;i++) {
				
				Map<String,String> paraMap = new HashMap<>();
				paraMap.put("opseq", opseqArr[i]);
				paraMap.put("oqty", oqtyArr[i]);
				paraMap.put("loginuserid", loginuserid);
				paraMap.put("fk_pseq", String.valueOf(fk_pseq));
				
				int n = pdao.insertBasket(paraMap); //가져온 값들로 장바구니 테이블에 insert해줌 
				
				if(n == 1) {
					jsonObj.put("message", "장바구니에 추가하였습니다.");
					jsonObj.put("check","1"); // 정상접근 정상추가(n=1) : view단에서 location href: basket.go로 잡아주기
				}
				else {
					jsonObj.put("message", "장바구니에 추가할 수 없습니다.");
					jsonObj.put("check","0"); // 정상 접근 비정상 추가(n=0) : view단에서 location href: javascript:history.back()으로 잡아주기??? 
				}
			}
		}
		else { //GET방식 (비정상적인 접근)
			
			jsonObj.put("message", "비정상적인 경로로 들어왔습니다.");
			jsonObj.put("check","0");  // 비정상접근 (n=2) : view단에서 location href: javascript:history.back()으로 잡아주기 
			
		}
		
		request.setAttribute("json", jsonObj);
		
		super.setViewPage("/WEB-INF/jsonview_LCE.jsp");
		
		
		//}
	}// end of public void execute(HttpServletRequest request, HttpServletResponse response)

}
