package board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.BoardDAO;
import board.model.BoardVO;
import board.model.InterBoardDAO;
import common.controller.AbstractController;


public class QnaListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
			InterBoardDAO bdao = new BoardDAO();
			
			String board_id = request.getParameter("board_id");
			String board_subject = request.getParameter("board_subject");
			String board_content = request.getParameter("board_content");
			if(board_id != null && board_subject != null && board_content != null) {
				bdao.register(board_id,board_subject,board_content);
			
			}
	
			
			 Map<String, String> paraMap = new HashMap<>(); // DAO에 보낼 파라미터들을 담아줄 해쉬맵입니다.
	         
	         String searchType = request.getParameter("searchType"); // 아이디, 성명 
	         String searchWord = request.getParameter("searchWord"); // 검색어
	         
	         paraMap.put("searchType", searchType);
	         paraMap.put("searchWord", searchWord);
	         
	         
	         String currentShowPageNo = request.getParameter("currentShowPageNo"); // 현재 보고있는 페이지
	         String sizePerPage = request.getParameter("sizePerPage"); // 몇명씩 볼지
	         
	         
	         if( currentShowPageNo == null ) { // 현재보고있는 페이지가 null이면 1을 기본값으로 준다 // null인 경우는 처음으로 회원목록 페이지에 들어온 경우이다.
	            currentShowPageNo = "1";
	         }
	         
	         if ( sizePerPage == null || !( "3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage) ) ) {
	            sizePerPage = "10";
	         }
	         
	         
	         try { // 무언가를 검색하고 들어왔다면 정상적인 int 범위의 숫자이다. 허나 사용자가 GET방식을 이용하여 악의적으로 들어왔다면 걸러야한다.
	            Integer.parseInt(currentShowPageNo);
	         } catch (NumberFormatException e) {
	            currentShowPageNo = "1";
	         }
	         
	         paraMap.put("currentShowPageNo", currentShowPageNo);
	         paraMap.put("sizePerPage", sizePerPage);

	         
	         
	         List<BoardVO> boardList =  bdao.selectPagingboard();

	         // 검색을 해서 들어온 경우에는 검색타입과 검색어를 가지고가서 찾아줍니다.
	         // "검색"버튼을 한 번 더 누른다면 paraMap에 있는 애들은 NULL이여서 전체조회를 해줍니다.
	         
	         request.setAttribute("boardList", boardList); // View 페이지로 List를 전송시켜서 찍어주도록 합니다.
	         request.setAttribute("sizePerPage", sizePerPage); // 계속해서 페이지를 이동해도 사용자가 고른 몇명씩 볼지는 유지시켜줘야 한다.
	         
	         List<BoardVO> boardlist = bdao.selectPagingBoardList(paraMap);
	         
	         request.setAttribute("boardlist", boardlist);
	         request.setAttribute("sizePerPage", sizePerPage); // 계속해서 페이지를 이동해도 사용자가 고른 몇명씩 볼지는 유지시켜줘야 한다.

	         
	         String pageBar = "";
	         
	         int blockSize = 10;
	         // blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
	         
	         int loop = 1;
	         // loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 10개)까지만 증가하는 용도이다. 
	         
	         int pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
	         // pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
	         
	         int totalPage = bdao.getTotalPage(paraMap);
	   
	         
	         
	         if(searchType == null) {
	            searchType = "";
	         }
	         
	         if(searchWord == null) {
	            searchWord = "";
	         }
	         
	         request.setAttribute("searchType", searchType);
	         request.setAttribute("searchWord", searchWord);
	         
	         
	         // **** [맨처음][이전] 만들기  **** //
	         if(pageNo != 1) {
	            pageBar += "<li class='page-item' style='background-color:black;'><a class='page-link' href='qnaList.go?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[맨처음]</a></li>";
	            pageBar += "<li class='page-item'><a class='page-link' href='qnaList.go?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a></li>";
	         }
	         
	         
	         
	         while( !(loop > blockSize || pageNo > totalPage ) ) { // loop가 blockSize보다 커지면 탈출한다.
	            
	            if( pageNo == Integer.parseInt(currentShowPageNo) ) {
	               pageBar += "<li class='page-item active' style='background-color:black;'><a class='page-link' href='#'>"+pageNo+"</a></li>";
	            }
	            else {
	               pageBar += "<li class='page-item'><a class='page-link' href='qnaList.go?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";
	            }
	            
	            loop++; 
	            
	            pageNo++;    
	            
	            
	         }// end of while------------------------------------
	         
	         
	         // **** [다음][마지막] 만들기  **** //
	         // while문 끝내고 나왔으면 다음블럭의 첫페이지가 pageNo가 됨
	         // 즉 1블럭을 끝내고 나왔다면 pageNo = 11
	         
	         
	         if(pageNo <= totalPage) { // pageNo가 totalPage보다 작거나 같으면 [다음], [마지막] 버튼을 나타나게함
	            // 10명씩하면 총 21페이지, 내가 만약 21페이지를 클릭했다면
	            // while문에 들어간다. 
	            // while( !(1 > 10 || 21 > 21 ) )
	            // pageNo는 22가 됨 그래서 이 조건문은 돌아지지 않음
	            
	            pageBar += "<li class='page-item'><a class='page-link' href='qnaList.go?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a></li>";
	            pageBar += "<li class='page-item'><a class='page-link' href='qnaList.go?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[마지막]</a></li>";
	         }
	         
	         
	         request.setAttribute("pageBar", pageBar);

			
	     //	super.setRedirect(false);
			super.setViewPage("/WEB-INF/board/qnaList.jsp");	
			
			return;

		}
		
	}

