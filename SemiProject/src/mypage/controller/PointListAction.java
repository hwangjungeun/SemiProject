package mypage.controller;


import java.text.DecimalFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import common.controller.AbstractController;
import member.model.MemberVO_PJW;
import mypage.model.*;

public class PointListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		String method= request.getMethod(); 
				
		if("post".equalsIgnoreCase(method)) {
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc ="javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return; // execute(HttpServletRequest request, HttpServletResponse response) 메소드 종료함
		}
		else {	*/
			
			HttpSession session = request.getSession();
			
			MemberVO_PJW loginuser = (MemberVO_PJW) session.getAttribute("loginuser");
			String userid = loginuser.getUserid();
//			String userid = request.getParameter("userid");
			InterPointDAO_HJE pdao = new PointDAO_HJE();
			
			// 콤마찍기
			DecimalFormat df = new DecimalFormat("###,###");
			
			Map<String,Integer> point_map = pdao.getPointInfo(userid);
			
			int point_sum = point_map.get("point_sum");
			String s_point_sum = df.format(point_sum);
			request.setAttribute("point_sum", s_point_sum);
			
			int point_canuse = point_map.get("point_canuse");
			String s_point_canuse = df.format(point_canuse);
			request.setAttribute("point_canuse", s_point_canuse);
			
			int point_used = point_map.get("point_used");
			String s_point_used = df.format(point_used);
			request.setAttribute("point_used", s_point_used);
			
			int point_unuse = point_map.get("point_unuse");
			String s_point_unuse = df.format(point_unuse);
			request.setAttribute("point_unuse", s_point_unuse);
			
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
			
			Map<String,String> paraMap = new HashMap<>();
			
			paraMap.put("userid", userid );
			paraMap.put("currentShowPageNo", currentShowPageNo);
			
			List<PointVO_HJE> pointList =  pdao.selectPagingPoint(paraMap);
			
			request.setAttribute("pointList", pointList);
			
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
			int totalPage = pdao.getTotalPage(userid);
			
			// *** [맨처음][이전] 만들기 *** //
			if(pageNo != 1) {
				pageBar += "<li class='page-item'><a class='page-link' href='pointList.go?userid="+userid+"&currentShowPageNo=1'>&laquo;&laquo;</a></li>";
				pageBar += "<li class='page-item'><a class='page-link' href='pointList.go?userid="+userid+"&currentShowPageNo="+(pageNo-1)+"'>&laquo;</a></li>";
			}
			
			
			// *** pagenation 만들기 *** //
			while( !(loop > blockSize || pageNo > totalPage) ) {
				// 한 블럭(3)당 보여지는 페이지 번호의 개수보다 작을때,
				// 메소드 getTotalPage을 통해 알아온 총 페이지 수보다 현재보여지는 페이지 수가 작을 떄
				
				if(pageNo == Integer.parseInt(currentShowPageNo)) { // 
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='pointList.go?userid="+userid+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
				}
				
				loop++;	// 1 2 3
				
				pageNo ++; //  1  2  3  
				//  4  5  6 
				//  7  8  9 
				
			} // end of while
			
			
			// *** [다음][마지막] 만들기 *** //
			if( pageNo <= totalPage ) {
				pageBar += "<li class='page-item'><a class='page-link' href='pointList.go?userid="+userid+"&currentShowPageNo="+pageNo+"'>&raquo;</a></li>";
				pageBar += "<li class='page-item'><a class='page-link' href='pointList.go?userid="+userid+"&currentShowPageNo="+totalPage+"'>&raquo;&raquo;</a></li>";
			}
			
			
			request.setAttribute("pageBar", pageBar);
			request.setAttribute("userid", userid);
			
			/// *** === 페이지바 만들기 끝 === *** ///
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/mypage/pointList.jsp");
		}
		
		
			
				
//	}

}

