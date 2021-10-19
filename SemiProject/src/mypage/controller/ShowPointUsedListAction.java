package mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import mypage.model.InterPointDAO_HJE;
import mypage.model.PointDAO_HJE;
import mypage.model.PointVO_HJE;

public class ShowPointUsedListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		
		InterPointDAO_HJE pdao = new PointDAO_HJE();
		
		/*
		// *** 페이지바 만들기 시작 *** //
		// 사용자가 보고싶어하는 페이지 숫자
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		try {
			
			Integer.parseInt(currentShowPageNo);
			
		} catch (NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		String pageBar = "";
		
		int blockSize = 3;
		// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		
		int loop = 1;
		// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
		
		// !! 아래는 pageNo를 구하는 공식이다.
		int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.

//		System.out.println(currentShowPageNo);
		
		// 페이징 처리를 위한 포인트에 대한 총 페이지 알아오기
		int totalPage = pdao.getUsedTotalPage(userid);

		// *** [맨처음][이전] 만들기 *** //
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='showPointUnuseList.go?userid="+userid+"&currentShowPageNo=1'>&laquo;&laquo;</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='showPointUnuseList.go?userid="+userid+"&currentShowPageNo="+(pageNo-1)+"'>&laquo;</a></li>";
		}
		
		
		// *** pagenation 만들기 *** //
		while( !(loop > blockSize || pageNo > totalPage) ) {
			// 한 블럭(3)당 보여지는 페이지 번호의 개수보다 작을때,
			// 메소드 getTotalPage을 통해 알아온 총 페이지 수보다 현재보여지는 페이지 수가 작을 떄
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) { // 
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='showPointUnuseList.go?userid="+userid+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;	// 1 2 3
			
			pageNo ++; //  1  2  3  
					   //  4  5  6 
					   //  7  8  9 
			
		} // end of while
		
		
		// *** [다음][마지막] 만들기 *** //
		if( pageNo <= totalPage ) {
			pageBar += "<li class='page-item'><a class='page-link' href='showPointUnuseList.go?userid="+userid+"&currentShowPageNo="+pageNo+"'>&raquo;</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='showPointUnuseList.go?userid="+userid+"&currentShowPageNo="+totalPage+"'>&raquo;&raquo;</a></li>";
		}
		
		
		request.setAttribute("pageBarUsed", pageBar);
		
		/// *** === 페이지바 만들기 끝 === *** ///
		*/
		
		/// *** value가 PointVO인 리스트 만들기 시작 *** //
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid );
//		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<PointVO_HJE> pointList =  pdao.selectPagingUsedPoint(paraMap);
		
		JSONArray jsonArr = new JSONArray();	// []
		// JSON 형식으로 만들어주어야 한다.
		
		
		if(pointList.size() > 0) {
			
			for(PointVO_HJE pvo : pointList) {
				
				JSONObject jsonObj = new JSONObject(); // {} {}
				
				jsonObj.put("odrdate", pvo.getOdrdate());    
				jsonObj.put("start_day", pvo.getStart_day());    
	            jsonObj.put("point", pvo.getPoint());
	            jsonObj.put("fk_odrcode", pvo.getFk_odrcode());
			
	            jsonArr.put(jsonObj);
			} // end of for
			
			String json = jsonArr.toString();	// 문자열로 변환
			
			request.setAttribute("json", json);
			// System.out.println("~~ 확인용  json : " + json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
		else {
			// DB에서 조회된 것이 없다면 
			
			String json = jsonArr.toString();	// 문자열로 변환
			// System.out.println("~~ 확인용  json : " + json);
			// ~~ 확인용  json : []
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}		
		/// *** value가 PointVO인 리스트 만들기 끝 *** //
		
		
		
	}

}
